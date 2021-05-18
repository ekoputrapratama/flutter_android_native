import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

const String ANDROID_NATIVE_CHANNEL = "android_native_channel";
const String ANDROID_NATIVE_CHANNEL_NAME =
    "com.mixaline.android_native/messages";

// class MethodCallListener {
//   void onMethodCall(MethodCall call) {}
// }

mixin AndroidNativeMixin {
  static MethodChannel _channel = Get.find();
}

typedef MethodCallListener = FutureOr<dynamic> Function(
    String method, dynamic arguments);

class AndroidNativeObject {
  static Map<String, MethodCallListener> _methodCallListeners = Map();
  static MethodChannel _channel =
      Get.put(MethodChannel(ANDROID_NATIVE_CHANNEL_NAME));
  MethodChannel get channel => _channel;
  // ignore: non_constant_identifier_names
  static var ANDROID_SDK_INT;
  static var ANDROID_SDK;
  static var ANDROID_PREVIEW_SDK_INT;
  static var ANDROID_BASE_OS;
  static var ANDROID_CODENAME;
  static var ANDROID_INCREMENTAL;
  static var ANDROID_RELEASE;
  static var ANDROID_RELEASE_OR_CODENAME;
  static var ANDROID_SECURITY_PATCH;

  // BaseClass() {
  //   // if (channel == null) {
  //   //   channel = Get.put(MethodChannel(ANDROID_NATIVE_CHANNEL_NAME),
  //   //       tag: ANDROID_NATIVE_CHANNEL);
  //   // }

  //   if (!channel.checkMethodCallHandler(onMethodCall)) {
  //     channel.setMethodCallHandler(onMethodCall);
  //   }
  // }

  init() {
    if (!channel.checkMethodCallHandler(onMethodCall)) {
      channel.setMethodCallHandler(onMethodCall);
    }
  }

  Future onMethodCall(MethodCall call) async {
    log("onMethodCall : ${call.method} ${_methodCallListeners.length} $_methodCallListeners");
    var name = call.method.split(".").first;

    if (_methodCallListeners.containsKey(name)) {
      var listener = _methodCallListeners[name]!;
      var method = call.method.split(".")
        ..removeWhere((element) => element == name);

      listener(method.join("."), call.arguments);
    }
    // for (var cb in _methodCallListeners) {
    //   cb(call);
    // }
  }

  void registerMethodCallListener(String key, MethodCallListener listener) {
    _methodCallListeners[key] = listener;
  }

  void unregisterMethodCallListener(String name) {
    _methodCallListeners.removeWhere((key, value) => key == name);
  }

  Future<T?> invokeMethod<T>(String method, [dynamic arguments]) async {
    return await _channel.invokeMethod(method, arguments);
  }
}
