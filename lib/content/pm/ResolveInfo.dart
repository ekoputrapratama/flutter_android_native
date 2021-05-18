import 'dart:convert';
import 'dart:typed_data';

import 'package:android_native/content/pm/ActivityInfo.dart';

class ResolveInfo {
  late ActivityInfo? activityInfo;
  late int icon;
  late bool isDefault;
  late bool isInstantAppAvailable;
  late int labelRes;
  late int match;
  late String? nonLocalizedLabel;
  late int preferredOrder;
  late int priority;
  late String? resolvePackageName;
  // final int specificIndex;
  late String? _icon;
  late String _label;

  ResolveInfo();
  ResolveInfo.fromResolveInfo(ResolveInfo info) {
    activityInfo = info.activityInfo;
    icon = info.icon;
    isDefault = info.isDefault;
    isInstantAppAvailable = info.isInstantAppAvailable;
    labelRes = info.labelRes;
    match = info.match;
    nonLocalizedLabel = info.nonLocalizedLabel;
    preferredOrder = info.preferredOrder;
    priority = info.priority;
    resolvePackageName = info.resolvePackageName;
    // specificIndex =  map['specificIndex'];
    _icon = info._icon;
    _label = info._label;
  }
  ResolveInfo.fromMap(Map map) {
    activityInfo = ActivityInfo.fromMap(map['activityInfo']);
    icon = map['icon'];
    isDefault = map['isDefault'];
    isInstantAppAvailable = map['isInstantAppAvailable'];
    labelRes = map['labelRes'];
    match = map['match'];
    nonLocalizedLabel = map['nonLocalizedLabel'];
    preferredOrder = map['preferredOrder'];
    priority = map['priority'];
    resolvePackageName = map['resolvePackageName'];
    // specificIndex =  map['specificIndex'];
    _icon = map['base64_icon'];
    _label = map['label'];
  }

  String loadLabel() {
    return _label;
  }

  Uint8List loadIcon() {
    return base64.decode(base64.normalize(_icon!));
  }

  Map toMap() {
    var map = Map();
    map['activityInfo'] = activityInfo?.toMap();
    map['icon'] = icon;
    map['isDefault'] = isDefault;
    map['isInstantAppAvailable'] = isInstantAppAvailable;
    map['labelRes'] = labelRes;
    map['match'] = match;
    map['nonLocalizedLabel'] = nonLocalizedLabel;
    map['preferredOrder'] = preferredOrder;
    map['priority'] = priority;
    map['resolvePackageName'] = resolvePackageName;
    // map['base64_icon']
    map['label'] = _label;
    return map;
  }
}
