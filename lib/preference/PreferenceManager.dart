import 'package:android_native/content/Context.dart';
import 'package:android_native/content/SharedPreferences.dart';

mixin PreferenceManagerMixin {}

class PreferenceManager {
  static SharedPreferences getDefaultSharedPreference(
      [bool useDeviceProtectedStorage = false]) {
    return SharedPreferences("default", Context.MODE_PRIVATE,
        useDeviceProtectedStorage: useDeviceProtectedStorage);
  }
}
