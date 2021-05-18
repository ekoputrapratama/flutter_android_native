import 'package:android_native/content/pm/ApplicationInfo.dart';
import 'package:android_native/content/pm/ComponentInfo.dart';

class ActivityInfo extends ComponentInfo {
  late int colorMode;
  late int configChanges;
  late int documentLaunchMode;
  late int flags;
  late int launchMode;
  late int maxRecents;
  late String? parentActivityName;
  late String? permission;
  late int persistableMode;
  late int screenOrientation;
  late int softInputMode;
  late String targetActivity;
  late String taskAffinity;
  late int theme;
  late int uiOptions;
  late WindowLayout? windowLayout;

  // ActivityInfo._(
  //     ApplicationInfo applicationInfo,
  //     int descriptionRes,
  //     bool directBootAware,
  //     bool enabled,
  //     bool exported,
  //     String processName,
  //     String splitName)
  //     : super.newInstance(applicationInfo, descriptionRes, directBootAware,
  //           enabled, exported, processName, splitName);

  ActivityInfo();
  ActivityInfo.fromActivityInfo(ActivityInfo info)
      : super.fromComponentInfo(info) {
    colorMode = info.colorMode;
    configChanges = info.configChanges;
    documentLaunchMode = info.documentLaunchMode;
    flags = info.flags;
    launchMode = info.launchMode;
    maxRecents = info.maxRecents;
    parentActivityName = info.parentActivityName;
    permission = info.permission;
    persistableMode = info.persistableMode;
    screenOrientation = info.screenOrientation;
    softInputMode = info.softInputMode;
    targetActivity = info.targetActivity;
    taskAffinity = info.taskAffinity;
    theme = info.theme;
    uiOptions = info.uiOptions;
    windowLayout = info.windowLayout;
  }

  ActivityInfo.fromMap(Map map) : super.fromMap(map) {
    colorMode = map['colorMode'];
    configChanges = map['configChanges'];
    documentLaunchMode = map['documentLaunchMode'];
    flags = map['flags'];
    launchMode = map['launchMode'];
    maxRecents = map['maxRecents'];
    parentActivityName = map['parentActivityName'];
    permission = map['permission'];
    persistableMode = map['persistableMode'];
    screenOrientation = map['screenOrientation'];
    softInputMode = map['softInputMode'];
    targetActivity = map['targetActivity'];
    taskAffinity = map['taskAffinity'];
    theme = map['theme'];
    uiOptions = map['uiOptions'];
    windowLayout = map['windowLayout'] != null
        ? WindowLayout.fromMap(map['windowLayout'])
        : null;
  }

  Map toMap() {
    var map = super.toMap();
    map['colorMode'] = colorMode;
    map['configChanges'] = configChanges;
    map['documentLaunchMode'] = documentLaunchMode;
    map['flags'] = flags;
    map['launchMode'] = launchMode;
    map['maxRecents'] = maxRecents;
    map['parentActivityName'] = parentActivityName;
    map['permission'] = permission;
    map['persistableMode'] = persistableMode;
    map['screenOrientation'] = screenOrientation;
    map['softInputMode'] = softInputMode;
    map['targetActivity'] = targetActivity;
    map['taskAffinity'] = taskAffinity;
    map['theme'] = theme;
    map['uiOptions'] = uiOptions;
    map['windowLayout'] = windowLayout?.toMap();
    return map;
  }
}

class WindowLayout {
  final int gravity;
  final int height;
  final double heightFraction;
  final int minHeight;
  final int minWidth;
  final int width;
  final double widthFraction;
  WindowLayout(this.width, this.widthFraction, this.height, this.heightFraction,
      this.gravity, this.minWidth, this.minHeight);

  WindowLayout.fromMap(Map map)
      : this(
            map['width'],
            map['widthFraction'],
            map['height'],
            map['heightFraction'],
            map['gravity'],
            map['minWidth'],
            map['minHeight']);

  Map toMap() {
    var map = Map();

    map['width'] = width;
    map['widthFraction'] = widthFraction;
    map['height'] = height;
    map['heightFraction'] = heightFraction;
    map['gravity'] = gravity;
    map['minWidth'] = minWidth;
    map['minHeight'] = minHeight;
    return map;
  }
}
