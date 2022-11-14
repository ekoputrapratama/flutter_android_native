import 'package:android_native/android_native.dart';
import 'package:android_native/app/KeyguardManager.dart';
import 'package:android_native/content/ContentResolver.dart';
import 'package:android_native/content/SharedPreferences.dart';
import 'package:android_native/content/pm/PackageManager.dart';
import 'package:android_native/media/AudioManager.dart';
import 'package:android_native/os/PowerManager.dart';
import 'package:android_native/telephony/TelephonyManager.dart';

import 'Intent.dart';

const _START_ACTIVITY = "Context.startActivity";
const _CHECK_SELF_PERMISSION = "Context.checkSelfPermission";
const _GET_PACKAGE_NAME = "Context.getPackageName";
const _GET_DATABASE_PATH = "Context.getDatabasePath";
const _GET_DATA_DIR = "Context.getDataDir";
const _GET_CACHE_DIR = "Context.getCacheDir";
const _GET_OBB_DIR = "Context.getObbDir";
const _MOVE_DATABASE_FROM = "Context.moveDatabaseFrom";
const _MOVE_SHARED_PREFERENCES_FROM = "Context.moveSharedPreferencesFrom";

class Context extends AndroidNativeObject with ContextMixin {
  static const AUDIO_SERVICE = "audio";
  static const KEYGUARD_SERVICE = "keyguard";
  static const POWER_SERVICE = "power";
  static const TELEPHONY_SERVICE = "phone";
  static const MODE_PRIVATE = 0;
  static const MODE_MULTI_PROCESS = 4;

  Context([_useDeviceProtectedStorage = false]);

  Context createDeviceProtectedStorageContext() {
    return Context(true);
  }
}

mixin ContextMixin on AndroidNativeObject {
  final _contentResolver = ContentResolver();
  final _packageManager = PackageManager();
  bool _useDeviceProtectedStorage = true;
  void startActivity(Intent intent) {
    channel.invokeMethod(_START_ACTIVITY, intent.toMap());
  }

  Future<int> checkSelfPermission(String permission) async {
    return await channel.invokeMethod(
        _CHECK_SELF_PERMISSION, {"permission": permission}) as int;
  }

  ContextMixin getApplicationContext() {
    return this;
  }

  PackageManager getPackageManager() {
    return _packageManager;
  }

  ContentResolver getContentResolver() {
    return _contentResolver;
  }

  Future<String> getPackageName() async {
    return invokeMethod(_GET_PACKAGE_NAME) as Future<String>;
  }

  SharedPreferences getSharedPreferences(String name, int mode) {
    return SharedPreferences(name, mode,
        useDeviceProtectedStorage: _useDeviceProtectedStorage);
  }

  bool isDeviceProtectedStorage() {
    return _useDeviceProtectedStorage;
  }

  Future<String> getDatabasePath(String name) async {
    return await invokeMethod(_GET_DATABASE_PATH);
  }

  Future<String> getDataDir() async {
    return await invokeMethod(_GET_DATA_DIR);
  }

  Future<String> getCacheDir() async {
    return await invokeMethod(_GET_CACHE_DIR);
  }

  Future<String> getObbDir() async {
    return await invokeMethod(_GET_OBB_DIR);
  }

  Future<bool> moveDatabaseFrom(Context context, String name) async {
    var currentPath = await getDatabasePath("dummy");
    var oldPath = await context.getDatabasePath("dummy");

    if (currentPath != oldPath) {
      invokeMethod(_MOVE_DATABASE_FROM);
    }
    return false;
  }

  Future<bool> moveSharedPreferencesFrom(Context context, String name) async {
    var currentData = await getDataDir();
    var oldData = await context.getDataDir();

    if (currentData != oldData) {
      invokeMethod(_MOVE_SHARED_PREFERENCES_FROM);
    }
    return false;
  }

  dynamic getSystemService(String service) {
    switch (service) {
      case Context.AUDIO_SERVICE:
        return AudioManager();
      case Context.KEYGUARD_SERVICE:
        return KeyguardManager();
      case Context.POWER_SERVICE:
        return PowerManager();
      case Context.TELEPHONY_SERVICE:
        return TelephonyManager();
    }
  }
}
