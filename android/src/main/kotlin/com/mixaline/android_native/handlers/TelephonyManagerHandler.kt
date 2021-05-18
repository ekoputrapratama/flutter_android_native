package com.mixaline.android_native.handlers

import android.annotation.SuppressLint
import android.content.Context
import android.telephony.TelephonyManager
import android.provider.Settings

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

import com.mixaline.android_native.utils.*

class TelephonyManagerHandler(messageChannel: MethodChannel, eventChannel: EventChannel, val context: Context) : BaseCallHandler(messageChannel, eventChannel) {
  private var isHandling = false
  private var telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

  companion object {
    val TAG = "TelephonyManager"
  }

  init {
    isHandling = true
    name = "TelephonyManager"
  }

  private fun onGetNetworkCountryIsoCall(call: MethodCall, result: MethodChannel.Result) {
    result.success(telephonyManager.networkCountryIso)
  }

  private fun onGetNetworkOperatorName(call: MethodCall, result: MethodChannel.Result) {
    result.success(telephonyManager.networkOperatorName)
  }

  private fun onGetSimCarrierIdCall(call: MethodCall, result: MethodChannel.Result){
    if(isAtLeastP()) {
      result.success(telephonyManager.simCarrierId)
    } else {
      result.success(null)
    }
  }

  private fun onGetDeviceId(call: MethodCall, result: MethodChannel.Result) {
    result.success(getDeviceIMEI())
  }

  @SuppressLint("HardwareIds")
  fun getDeviceIMEI(): String? {
    var deviceUniqueIdentifier: String? = null
    try {
      deviceUniqueIdentifier = telephonyManager.deviceId
    } catch(e: Exception) {
      // Ln.e(TAG, e)
    }
    if (null == deviceUniqueIdentifier || deviceUniqueIdentifier.isEmpty()) {
      deviceUniqueIdentifier = Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID)
    }
    return deviceUniqueIdentifier;
  }

  override fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if(isHandling) {
      when (call.method) {
        METHOD_GET_NETWORK_COUNTRY_ISO -> {
          onGetNetworkCountryIsoCall(call, result)
        }
        METHOD_GET_NETWORK_OPERATOR_NAME -> {
          onGetNetworkOperatorName(call, result)
        }
        METHOD_GET_SIM_CARRIER_ID -> {
          onGetSimCarrierIdCall(call, result)
        }
        METHOD_GET_DEVICE_ID -> {
          onGetDeviceId(call, result)
        }
      }
    }
  }

  override fun onDestroy() {
    TODO("Not yet implemented")
  }
}
