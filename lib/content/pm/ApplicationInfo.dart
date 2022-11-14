import 'package:android_native/content/Context.dart';
import 'package:android_native/content/pm/PackageItemInfo.dart';
import 'package:android_native/content/pm/PackageManager.dart';

class ApplicationInfo extends PackageItemInfo {
  static const int CATEGORY_UNDEFINED = -1;
  static const int CATEGORY_GAME = 0;
  static const int CATEGORY_AUDIO = 1;
  static const int CATEGORY_VIDEO = 2;
  static const int CATEGORY_IMAGE = 3;
  static const int CATEGORY_SOCIAL = 4;
  static const int CATEGORY_NEWS = 5;
  static const int CATEGORY_MAPS = 6;
  static const int CATEGORY_PRODUCTIVITY = 7;

  static const int FLAG_SYSTEM = 1;
  static const int FLAG_DEBUGGABLE = 2;
  static const int FLAG_ALLOW_BACKUP = 32768;
  static const int FLAG_ALLOW_CLEAR_USER_DATA = 64;
  static const int FLAG_ALLOW_TASK_REPARENTING = 32;
  static const int FLAG_EXTERNAL_STORAGE = 262144;
  static const int FLAG_EXTRACT_NATIVE_LIBS = 268435456;
  static const int FLAG_FACTORY_TEST = 16;
  static const int FLAG_FULL_BACKUP_ONLY = 67108864;
  static const int FLAG_HARDWARE_ACCELERATED = 536870912;
  static const int FLAG_HAS_CODE = 4;
  static const int FLAG_INSTALLED = 8388608;
  static const int FLAG_IS_DATA_ONLY = 16777216;
  static const int FLAG_IS_GAME = 33554432;
  static const int FLAG_KILL_AFTER_RESTORE = 65536;
  static const int FLAG_LARGE_HEAP = 1048576;
  static const int FLAG_MULTIARCH = -2147483648;
  static const int FLAG_PERSISTENT = 8;
  static const int FLAG_RESIZEABLE_FOR_SCREENS = 4096;
  static const int FLAG_RESTORE_ANY_VERSION = 131072;
  static const int FLAG_STOPPED = 2097152;
  static const int FLAG_SUPPORTS_LARGE_SCREENS = 2048;
  static const int FLAG_SUPPORTS_NORMAL_SCREENS = 1024;
  static const int FLAG_SUPPORTS_RTL = 4194304;
  static const int FLAG_SUPPORTS_SCREEN_DENSITIES = 8192;
  static const int FLAG_SUPPORTS_SMALL_SCREENS = 512;
  static const int FLAG_SUPPORTS_XLARGE_SCREENS = 524288;
  static const int FLAG_SUSPENDED = 1073741824;
  static const int FLAG_TEST_ONLY = 256;
  static const int FLAG_UPDATED_SYSTEM_APP = 128;
  static const int FLAG_USES_CLEARTEXT_TRAFFIC = 134217728;
  static const int FLAG_VM_SAFE_MODE = 16384;

  int category = CATEGORY_UNDEFINED;
  String? className = '';
  String dataDir = '';
  int descriptionRes = 0;
  bool enabled = false;
  int flags = 0;
  int minSdkVersion = 0;
  String processName = '';
  String publicSourceDir = '';
  String sourceDir = '';
  int targetSdkVersion = 0;
  int theme = 0;

  bool _isProfileableByShell = false;
  bool _isResourceOverlay = false;
  bool _isVirtualPreload = false;

  bool get isProfileableByShell => _isProfileableByShell;
  bool get isResourceOverlay => _isResourceOverlay;
  bool get isVirtualPreload => _isVirtualPreload;

  ApplicationInfo.fromMap(Map map) : super.fromMap(map) {
    // ApplicationInfo variables
    category = map['category'];
    className = map['className'];
    dataDir = map['dataDir'];
    descriptionRes = map['descriptionRes'];
    enabled = map['enabled'];
    flags = map['flags'];
    minSdkVersion = map['minSdkVersion'];
    processName = (map.containsKey('processName') && map['processName'] != null)
        ? map['processName']
        : map['packageName'];
    publicSourceDir = map['publicSourceDir'];
    sourceDir = map['sourceDir'];
    targetSdkVersion = map['targetSdkVersion'];
    theme = map['theme'];
  }

  // static ApplicationInfo? fromMap(Map? map) {
  //   if (map != null) {
  //     var instance = ApplicationInfo();

  //     // PackageItemInfo variables
  //     instance.banner = map['banner'];
  //     instance.icon = map['icon'];
  //     instance.labelRes = map['labelRes'];

  //     instance.logo = map['logo'];
  //     instance.name = map['name'];
  //     instance.nonLocalizedLabel = map['nonLocalizedLabel'];
  //     instance.packageName = map['packageName'];

  //     if (map.containsKey('label')) instance.setLabel(map['label']);
  //     if (map.containsKey('base64_banner'))
  //       instance.setBase64Banner(map['base64_banner']);

  //     if (map.containsKey('base64_icon'))
  //       instance.setBase64Icon(map['base64_icon']);

  //     if (map.containsKey('base64_logo'))
  //       instance.setBase64Logo(map['base64_logo']);

  //     if (map.containsKey('base64_unbadged_icon'))
  //       instance.setBase64UnbadgedIcon(map['base64_unbadged_icon']);

  //     // ApplicationInfo variables
  //     instance.category = map['category'];
  //     instance.className = map['className'];
  //     instance.dataDir = map['dataDir'];
  //     instance.descriptionRes = map['descriptionRes'];
  //     instance.enabled = map['enabled'];
  //     instance.flags = map['flags'];
  //     instance.minSdkVersion = map['minSdkVersion'];
  //     instance.processName =
  //         (map.containsKey('processName') && map['processName'] != null)
  //             ? map['processName']
  //             : map['packageName'];
  //     instance.publicSourceDir = map['publicSourceDir'];
  //     instance.sourceDir = map['sourceDir'];
  //     instance.targetSdkVersion = map['targetSdkVersion'];
  //     instance.theme = map['theme'];
  //     return instance;
  //   }
  //   return null;
  // }

  String? getCategoryTitle(Context context, int category) {
    switch (category) {
      case CATEGORY_AUDIO:
        return 'audio';
      case CATEGORY_GAME:
        return 'game';
      case CATEGORY_IMAGE:
        return 'image';
      case CATEGORY_MAPS:
        return 'maps';
      case CATEGORY_NEWS:
        return 'news';
      case CATEGORY_PRODUCTIVITY:
        return 'productivity';
      case CATEGORY_SOCIAL:
        return 'social';
      case CATEGORY_VIDEO:
        return 'video';
      default:
        return null;
    }
  }

  Future<String?> loadDescription(PackageManager pm) async {
    if (descriptionRes != 0) {
      var label = await pm.getText(packageName, descriptionRes, this);
      if (label != null) {
        return label;
      }
    }
    return null;
  }

  @override
  ApplicationInfo? getApplicationInfo() {
    return this;
  }

  Map toMap() {
    var map = super.toMap();

    map['theme'] = theme;
    map['descriptionRes'] = descriptionRes;
    map['targetSdkVersion'] = targetSdkVersion;
    map['minSdkVersion'] = minSdkVersion;
    map['category'] = category;
    map['className'] = className;
    map['dataDir'] = dataDir;
    map['processName'] = processName;
    map['enabled'] = enabled;
    map['flags'] = flags;
    map['publicSourceDir'] = publicSourceDir;
    map['sourceDir'] = sourceDir;
    // map[''] = ;
    return map;
  }
}
