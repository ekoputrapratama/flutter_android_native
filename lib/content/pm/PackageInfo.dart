import 'ApplicationInfo.dart';

class PackageInfo {
  ApplicationInfo? applicationInfo;
  String packageName = "";
  bool isApex = false;
  int firstInstallTime = 0;
  int baseRevisionCode = 0;
  String sharedUserId = "";
  int versionCode = 0;
  String versionName = "";

  PackageInfo._();
  static PackageInfo? fromMap(Map? map) {
    if (map != null) {
      var instance = PackageInfo._();

      instance.packageName = map['packageName'];
      instance.isApex = map['isApex'];
      instance.applicationInfo =
          ApplicationInfo.fromMap(map['applicationInfo']);
      instance.firstInstallTime = map['firstInstallTime'];
      instance.baseRevisionCode = map['baseRevisionCode'];
      instance.versionCode = map['versionCode'];
      instance.versionName = map['versionName'];
      instance.sharedUserId = map['sharedUserId'];

      return instance;
    }

    return null;
  }

  Map toMap() {
    var map = Map();
    map['packageName'] = packageName;
    map['isApex'] = isApex;
    map['applicationInfo'] = applicationInfo?.toMap();
    map['firstInstallTime'] = firstInstallTime;
    map['baseRevisionCode'] = baseRevisionCode;
    map['versionCode'] = versionCode;
    map['versionName'] = versionName;
    map['sharedUserId'] = sharedUserId;
    return map;
  }
}
