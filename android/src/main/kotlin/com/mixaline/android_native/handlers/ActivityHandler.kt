package com.mixaline.android_native.handlers

import android.app.Activity
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import com.mixaline.android_native.utils.*
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel



class ActivityHandler(messageChannel: MethodChannel, eventChannel: EventChannel, activity: Activity?)
  : BaseCallHandler(messageChannel,eventChannel) {
  private var isHandling = false
  private var packageManager: PackageManager? = activity?.packageManager

  var activity: Activity? = null
    set(value) {
      field = value
      this.packageManager = value?.packageManager
    }

  init {
    isHandling = true
    name = HANDLER_ACTIVITY
    this.activity = activity
  }

  // private fun (call: MethodCall, result: MethodChannel.Result) {

  // }

  private fun onRequestPermissionsCall(call: MethodCall, result: MethodChannel.Result) {
    Ln.d(HANDLER_ACTIVITY, "onRequestPermissionsCall")
    val args = call.arguments as Map<*, *>

    val permissions = args["permissions"] as List<String>
    val requestCode = args["requestCode"] as Int

    if (activity != null && permissions != null && permissions.isNotEmpty()) {
      ActivityCompat.requestPermissions(activity!!, permissions.toTypedArray(), requestCode)
    }
  }

  private fun onStartActivityForResultCall(call: MethodCall, result: MethodChannel.Result) {
    Ln.d(HANDLER_ACTIVITY, "onStartActivityForResultCall")
    val intentMap = call.argument<Map<*, *>>("intent")!!
    val requestCode = call.argument<Int>("requestCode")!!
    val intent = mapToIntent(intentMap)
    activity?.startActivityForResult(intent, requestCode)
  }

  private fun onGetIntentCall(call: MethodCall, result: MethodChannel.Result) {
    Ln.d(HANDLER_ACTIVITY, "onGetIntentCall")

    result.success(activity!!.intent?.toMap())
  }

  override fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if (isHandling && activity != null) {
      when (call.method) {
        METHOD_START_ACTIVITY_FOR_RESULT -> {
          onStartActivityForResultCall(call, result)
        }
        METHOD_REQUEST_PERMISSIONS -> {
          onRequestPermissionsCall(call, result)
        }
        METHOD_GET_INTENT -> {
          onGetIntentCall(call, result)
        }
      }
    }
  }

  override fun onDestroy() {
    isHandling = false
  }
}

