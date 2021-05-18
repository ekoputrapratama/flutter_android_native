import '../android_native.dart';

const _IS_INTERACTIVE = "PowerManager.isInteractive";
const _IS_IGNORING_BATTERY_OPTIMIZATION =
    "PowerManager.isIgnoringBatteryOptimizations";

class PowerManager with AndroidNativeObject {
  PowerManager() : super();

  Future<bool> isInteractive() async {
    return await channel.invokeMethod(_IS_INTERACTIVE) as bool;
  }

  @deprecated
  Future<bool> isScreenOn() async {
    return await channel.invokeMethod(_IS_INTERACTIVE) as bool;
  }

  Future<bool> isIgnoringBatteryOptimizations() async {
    return await channel.invokeMethod(_IS_IGNORING_BATTERY_OPTIMIZATION)
        as bool;
  }
}
