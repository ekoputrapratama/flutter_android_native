import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import '../../android_native.dart';
import '../ComponentName.dart';
import '../Intent.dart';
import 'ActivityInfo.dart';
import 'ApplicationInfo.dart';
import 'PackageInfo.dart';
import 'ResolveInfo.dart';

const _HANDLER_NAME = "PackageManager";

const _GET_ACTIVITY_INFO = "$_HANDLER_NAME.getActivityInfo";
const _GET_INSTALLED_APPLICATIONS = "$_HANDLER_NAME.getInstalledApplications";
const _GET_INSTALLED_PACKAGES = "$_HANDLER_NAME.getInstalledPackages";
const _GET_PACKAGE_INFO = "$_HANDLER_NAME.getPackageInfo";
const _GET_TEXT = "$_HANDLER_NAME.getText";
const _GET_APPLICATION_ICON = "$_HANDLER_NAME.getApplicationIcon";
const _QUERY_INTENT_ACTIVITIES = "$_HANDLER_NAME.queryIntentActivities";

class PackageManager extends AndroidNativeObject {
  // static getActivityInfo(){}

  static const PERMISSION_GRANTED = 0;
  static const PERMISSION_DENIED = -1;
  static const MATCH_ALL = 131072;
  static const MATCH_APEX = 1073741824;
  static const MATCH_DEFAULT_ONLY = 65536;
  static const GET_UNINSTALLED_PACKAGES = 8192;
  static const GET_META_DATA = 128;
  static const GET_SHARED_LIBRARY_FILES = 1024;
  static const MATCH_UNINSTALLED_PACKAGES = 8192;
  static const MATCH_SYSTEM_ONLY = 1048576;

  Future<ActivityInfo?> getActivityInfo(ComponentName componentName,
      {int flags = 0}) async {
    var result = await channel.invokeMethod(_GET_ACTIVITY_INFO, {
      "packageName": componentName.packageName,
      "className": componentName.className,
      "flags": flags
    });

    return (result != null) ? ActivityInfo.fromMap(result) : null;
  }

  Future<PackageInfo?> getPackageInfo(String packageName, int flags) async {
    var result = await channel.invokeMethod<Map>(
        _GET_PACKAGE_INFO, {"packageName": packageName, "flags": flags});

    return PackageInfo.fromMap(result);
  }

  Future<String?> getText(
      String packageName, int resid, ApplicationInfo? appInfo) async {
    return await invokeMethod<String?>(_GET_TEXT, {
      "packageName": packageName,
      "resid": resid,
      "appInfo": appInfo?.toMap()
    });
  }

  Future<Uint8List?> getApplicationIcon(String packageName) async {
    var result =
        await invokeMethod(_GET_APPLICATION_ICON, {"packageName": packageName});

    if (result != null) {
      return base64.decode(base64.normalize(result));
    }

    return null;
  }

  Future<List<PackageInfo>> getInstalledPackages(int flags) async {
    var results = await invokeMethod(_GET_INSTALLED_PACKAGES, {"flags": flags});

    List<PackageInfo> res = [];

    if (results is List) {
      log("packages length ${results.length}");
      for (var item in results) {
        var info = PackageInfo.fromMap(item as Map);
        if (info != null) res.add(info);
      }
    }

    return res;
  }

  Future<List<ResolveInfo>> queryIntentActivities(
      Intent intent, int flags) async {
    var results = await invokeMethod(
        _QUERY_INTENT_ACTIVITIES, {"intent": intent.toMap(), "flags": flags});

    List<ResolveInfo> res = [];

    if (results is List) {
      for (var item in results) {
        var info = ResolveInfo.fromMap(item as Map);
        if (info != null) res.add(info);
      }
    }

    return res;
  }

  Future<List<ApplicationInfo>> getInstalledApplications(int flags) async {
    var results =
        await invokeMethod(_GET_INSTALLED_APPLICATIONS, {"flags": flags});

    List<ApplicationInfo> res = [];

    if (results is List) {
      for (var item in results) {
        var info = ApplicationInfo.fromMap(item as Map);
        if (info != null) res.add(info);
      }
    }

    return res;
  }
}
