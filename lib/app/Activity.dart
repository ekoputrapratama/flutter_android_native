import 'dart:developer';

import 'package:android_native/content/Context.dart';
import 'package:android_native/content/pm/PackageManager.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' as Widget;
import 'package:get/get.dart';

import '../android_native.dart';
import '../content/Intent.dart';

const _START_ACTIVITY_FOR_RESULT = "Activity.startActivityForResult";
const _GET_INTENT = "Activity.getIntent";
const _REQUEST_PERMISSIONS = "Activity.requestPermissions";

mixin ActivityMixin {
  MethodChannel get channel => Get.find();
  final packageManager = PackageManager();
  final _context = Context();

  Context getContext() {
    return _context;
  }

  Future<Intent> getIntent() async {
    var map = await channel.invokeMethod<Map>(_GET_INTENT, null);
    return Intent.fromMap(map);
  }

  void startActivityForResult(Intent intent, int requestCode) {
    var map = Map();
    map["intent"] = intent.toMap();
    map["requestCode"] = requestCode;
    channel.invokeMethod(_START_ACTIVITY_FOR_RESULT, map);
  }

  void requestPermissions(List<String> permissions, int requestCode) {
    channel.invokeMethod(_REQUEST_PERMISSIONS,
        {"permissions": permissions, "requestCode": requestCode});
  }

  List<int>? _parseGrantResults(dynamic? grantResults) {
    if (grantResults == null) return null;

    if (grantResults is List) {
      var results = <int>[];
      for (var r in grantResults) {
        results.add(r);
      }
      return results;
    }

    return null;
  }

  List<String>? _parsePermissions(dynamic? permissions) {
    if (permissions == null) return null;

    if (permissions is List) {
      var results = <String>[];
      for (var permission in permissions) {
        results.add(permission);
      }
      return results;
    }

    return null;
  }

  void onActivityMethodCall(String method, dynamic arguments) {
    log("onActivityMethodCall : $method");
    switch (method) {
      case "onActivityResult":
        var args = arguments as Map;
        var intent = Intent.fromMap(args["intent"]);
        var requestCode = args["requestCode"];
        var resultCode = args["resultCode"];
        onActivityResult(requestCode, resultCode, intent);
        break;
      case "onRequestPermissionsResult":
        var args = arguments as Map;

        var requestCode = args["requestCode"] as int;
        var grantResults = _parseGrantResults(args["grantResults"]);
        var permissions = _parsePermissions(args["permissions"]);

        onRequestPermissionsResult(requestCode, permissions, grantResults);
        break;
      case "onNewIntent":
        var args = arguments as Map;
        var intent = Intent.fromMap(args);
        onNewIntent(intent);
        break;
    }
  }

  void onRequestPermissionsResult(
      int requestCode, List<String>? permissions, List<int>? grantResults) {}

  void onActivityResult(int requestCode, int resultCode, Intent? intent) {}
  void onNewIntent(Intent intent) {
    log("onNewIntent ${intent.toMap()}");
  }
}

abstract class Activity extends Widget.StatefulWidget {
  Activity({Widget.Key? key}) : super(key: key);
}

abstract class ActivityStateless extends Widget.StatelessWidget
    with ActivityMixin, AndroidNativeObject, ContextMixin {
  ActivityStateless({Widget.Key? key}) : super(key: key) {
    registerMethodCallListener("Activity", onActivityMethodCall);
    init();
  }
}

abstract class ActivityState<T extends Activity> extends Widget.State<T>
    with ActivityMixin, AndroidNativeObject, ContextMixin {
  ActivityState() : super() {
    registerMethodCallListener("Activity", onActivityMethodCall);
    init();
  }
}
