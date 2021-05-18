import 'dart:ui';
import 'dart:async';
import 'dart:isolate';
import 'dart:convert';
import 'dart:developer';

import 'package:android_native/android_native.dart';
import 'package:android_native/content/Context.dart';
import 'package:android_native/content/pm/PackageManager.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// import 'AsyncTask.dart';

typedef AccessibilityServiceCallback = FutureOr<dynamic> Function();

abstract class AccessibilityService extends AndroidNativeObject
    with ContextMixin {
  static MethodChannel? _backgroundChannel;
  static MethodChannel _foregroundChannel =
      const MethodChannel("com.mixaline.varity/foreground_channel");

  static bool _running = false;
  static bool get running => _running;

  static int _serviceId = 0;
  static Map<int, AccessibilityService> _serviceRegistry = Map();

  // static final _asyncTaskQueue = AsyncTaskQueue();

  var packageManager = PackageManager();

  static Future<int> registerService(
      AccessibilityService serviceHandler) async {
    log("registering service");
    WidgetsFlutterBinding.ensureInitialized();
    if (_backgroundChannel == null) {
      _backgroundChannel =
          MethodChannel("com.mixaline.varity/accessibility_background");
      _backgroundChannel!.setMethodCallHandler(onBackgroundMethodCall);
    }
    var id = _serviceId++;
    _serviceRegistry[id] = serviceHandler;

    final running = await _backgroundChannel!.invokeMethod("isRunning");
    if (running != _running) {
      _running = running;
    }

    if (_running) {
      log("service is already running calling onServiceConected immediatly");
      serviceHandler.onServiceConnected();
    }
    return id;
  }

  static void unregisterServiceById(int serviceId) {
    _serviceRegistry.remove(serviceId);
  }

  static void unregisterService(AccessibilityService service) {
    _serviceRegistry.removeWhere((key, value) => value == service);
  }

  static Future<dynamic> start(
      AccessibilityServiceCallback serviceEntrypoint) async {
    CallbackHandle? handle =
        PluginUtilities.getCallbackHandle(serviceEntrypoint);
    if (handle == null) {
      log("background entrypoint cannot be null");
      return false;
    }
    log("starting accessibility  service");
    await _foregroundChannel
        .invokeMethod("start", {"callbackHandle": handle.toRawHandle()});
    log("checking if accessibility service is running");
    final running = await _foregroundChannel.invokeMethod("isRunning");
    if (running != _running) {
      _running = running;
    }

    return running;
  }

  static Future<void> onForegroundMethodCall(MethodCall call) async {
    log("onForegoundMethodCall ${call.method}");
    switch (call.method) {
      case "dispatchResultCallback":
        /**
         * this method called from background isolote in native code
         * so we need to use isolate to send the message to main isolate.
         */
        // final Map args = call.arguments;
        // final sendPort =
        //     IsolateNameServer.lookupPortByName(WORKMANAGER_EVENT_PORT_NAME);
        // args["method"] = call.method;
        // sendPort.send(args);
        break;
    }
  }

  static Future<void> onBackgroundMethodCall(MethodCall call) async {
    log("onBackgroundMethodCall ${call.method}");
    switch (call.method) {
      case "onServiceConnected":
        log("accessibility service started");
        _running = true;
        for (var service in _serviceRegistry.values) {
          service.onServiceConnected();
        }
        break;
      case "onDestroyed":
        log("accessibility service destroyed");
        for (var service in _serviceRegistry.values) {
          service.onDestroy();
        }
        break;
      case "onAccessibilityEvent":
        // log("accessibility service event ${call.arguments}");
        var event = AccessibilityEvent.fromMap(call.arguments as Map);

        for (var service in _serviceRegistry.values) {
          service.onAccessibilityEvent(event);
        }
        break;
    }
  }

  FutureOr<dynamic> onAccessibilityEvent(AccessibilityEvent? event);
  FutureOr<dynamic> onDestroy();
  FutureOr<dynamic> onServiceConnected();
  FutureOr<dynamic> onInterrupt();
}

class AccessibilityEvent {
  static AccessibilityEvent? fromMap(Map? map) {
    if (map != null) {
      var instance = AccessibilityEvent();
      instance.eventType = map["eventType"];
      instance.packageName = map["packageName"];
      instance.className = map["className"];
      instance.eventTime = map["eventTime"];
      instance.recordCount = map["recordCount"];
      instance.windowChanges = map["windowChanges"];
      return instance;
    }
    return null;
  }

  int eventType = 0;
  String? packageName;
  String? className;
  int eventTime = 0;
  int recordCount = 0;
  int windowChanges = 0;

  static const int TYPE_WINDOWS_CHANGED = 4194304;
  static const int TYPE_WINDOW_CONTENT_CHANGED = 2048;
  static const int TYPE_WINDOW_STATE_CHANGED = 32;

  Map toMap() {
    var map = Map();
    map["eventType"] = eventType;
    map["packageName"] = packageName;
    map["className"] = className;
    map["eventTime"] = eventTime;
    map["recordCount"] = recordCount;
    map["windowChanges"] = windowChanges;

    return map;
  }
}
