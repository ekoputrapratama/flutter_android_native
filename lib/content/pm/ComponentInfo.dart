import 'package:android_native/content/pm/PackageItemInfo.dart';

import 'ApplicationInfo.dart';

class ComponentInfo extends PackageItemInfo {
  late ApplicationInfo applicationInfo;
  late int descriptionRes;
  late bool directBootAware;
  late bool enabled;
  late bool exported;
  late String processName;
  late String splitName;

  ComponentInfo();
  ComponentInfo.fromComponentInfo(ComponentInfo info)
      : super.fromPackageItemInfo(info) {
    applicationInfo = info.applicationInfo;
    descriptionRes = info.descriptionRes;
    directBootAware = info.directBootAware;
    enabled = info.enabled;
    exported = info.exported;
    processName = info.processName;
    splitName = info.splitName;
  }

  ComponentInfo.fromMap(Map map) : super.fromMap(map) {
    applicationInfo = ApplicationInfo.fromMap(map['applicationInfo']);
    descriptionRes = map['descriptionRes'];
    directBootAware = map['directBootAware'];
    enabled = map['enabled'];
    exported = map['exported'];
    processName = map['processName'];
    splitName = map['splitName'];
  }
  ComponentInfo.newInstance(
      this.applicationInfo,
      this.descriptionRes,
      this.directBootAware,
      this.enabled,
      this.exported,
      this.processName,
      this.splitName);

  Map toMap() {
    var map = super.toMap();
    map['applicationInfo'] = applicationInfo.toMap();
    map['descriptionRes'] = descriptionRes;
    map['directBootAware'] = directBootAware;
    map['enabled'] = enabled;
    map['exported'] = exported;
    map['processName'] = processName;
    map['splitName'] = splitName;
    return map;
  }
}
