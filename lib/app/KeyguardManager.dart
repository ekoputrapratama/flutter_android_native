import 'package:android_native/android_native.dart';

const _IS_KEYGUARD_LOCKED = "KeyguardManager.isKeyguardLocked";

class KeyguardManager extends AndroidNativeObject {
  KeyguardManager() : super();

  Future<bool> isKeyguardLocked() async {
    return await channel.invokeMethod(_IS_KEYGUARD_LOCKED) as bool;
  }
}
