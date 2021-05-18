import 'dart:typed_data';
import 'dart:convert';
import 'package:android_native/content/pm/PackageManager.dart';
import 'package:flutter/cupertino.dart';

import 'ApplicationInfo.dart';

class PackageItemInfo {
  late int banner = 0;
  late int icon = 0;
  late int labelRes = 0;
  late int logo = 0;
  String? name;
  String? nonLocalizedLabel;
  late String packageName;
  String? _icon;
  String? _unbadgedIcon;
  String? _logo;
  String? _banner;
  String? _label;

  static const DEFAULT_MAX_LABEL_SIZE_PX = 500.0;
  static const MAX_SAFE_LABEL_LENGTH = 1000;

  static const SAFE_LABEL_FLAG_TRIM = 1;
  static const SAFE_LABEL_FLAG_SINGLE_LINE = 2;
  static const SAFE_LABEL_FLAG_FIRST_LINE = 4;

  PackageItemInfo();
  PackageItemInfo.fromPackageItemInfo(PackageItemInfo info) {
    banner = info.banner;
    icon = info.icon;
    labelRes = info.labelRes;

    logo = info.logo;
    name = info.name;
    nonLocalizedLabel = info.nonLocalizedLabel;
    packageName = info.packageName;

    _label = info._label;
    _logo = info._logo;
    _icon = info._icon;
    _unbadgedIcon = info._unbadgedIcon;
    _banner = info._banner;
  }

  PackageItemInfo.fromMap(Map map) {
    // PackageItemInfo variables
    if (map.containsKey('banner')) banner = map['banner'];
    icon = map['icon'];
    labelRes = map['labelRes'];

    logo = map['logo'];
    name = map['name'];
    nonLocalizedLabel = map['nonLocalizedLabel'];
    packageName = map['packageName'];

    if (map.containsKey('label')) _label = map['label'];
    if (map.containsKey('base64_banner')) _banner = map['base64_banner'];

    if (map.containsKey('base64_icon')) _icon = map['base64_icon'];

    if (map.containsKey('base64_logo')) _logo = map['base64_logo'];

    if (map.containsKey('base64_unbadged_icon'))
      _unbadgedIcon = map['base64_unbadged_icon'];
  }

  static void forceSafeLabels() {
    // _sForceSafeLabels = true;
  }

  String loadLabel(PackageManager pm) {
    return _label!;
  }

  Uint8List loadIcon(PackageManager pm) {
    return base64.decode(base64.normalize(_icon!));
  }

  Uint8List? loadBanner(PackageManager pm) {
    return (_banner != null) ? base64.decode(_banner!) : null;
  }

  Uint8List? loadLogo(PackageManager pm) {
    return (_logo != null) ? base64.decode(_logo!) : null;
  }

  Uint8List loadUnbadgedIcon(PackageManager pm) {
    return base64.decode(_unbadgedIcon!);
  }

  @protected
  ApplicationInfo? getApplicationInfo() {
    return null;
  }

  Map toMap() {
    var map = Map();
    map["banner"] = banner;
    map["icon"] = icon;
    map["labelRes"] = labelRes;
    map["logo"] = logo;
    map["name"] = name;
    map["nonLocalizedLabel"] = nonLocalizedLabel;
    map["packageName"] = packageName;
    return map;
  }
}
