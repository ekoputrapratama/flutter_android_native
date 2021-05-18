import '../android_native.dart';

const _GET_NETWORK_COUNTRY_ISO = "TelephonyManager.getNetworkCountryIso";
const _GET_NETWORK_OPERATOR_NAME = "TelephonyManager.getNetworkOperatorName";
const _GET_SIM_CARRIER_ID = "TelephonyManager.getSimCarrierId";
const _GET_DEVICE_ID = "TelephonyManager.getDeviceId";

class TelephonyManager with AndroidNativeObject {
  TelephonyManager() : super();
  static const UNKNOWN_CARRIER_ID = -1;

  Future<String> getNetworkCountryIso() async {
    return await invokeMethod(_GET_NETWORK_COUNTRY_ISO) as String;
  }

  Future<String> getNetworkOperatorName() async {
    return await invokeMethod(_GET_NETWORK_OPERATOR_NAME) as String;
  }

  Future<int> getSimCarrierId() async {
    return await invokeMethod(_GET_SIM_CARRIER_ID) as int;
  }

  Future<String> getDeviceId() async {
    return await invokeMethod(_GET_DEVICE_ID) as String;
  }
}
