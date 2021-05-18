package com.mixaline.android_native.handlers

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import androidx.core.content.ContextCompat

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

import com.mixaline.android_native.utils.*

class ContextHandler(messageChannel: MethodChannel, eventChannel: EventChannel, context: Context)
  : BaseCallHandler(messageChannel, eventChannel) {

  var context: Context? = null

  init {
    // isHandling = true
    name = HANDLER_CONTEXT
    this.context = context
  }

  private fun onStartActivityCall(call: MethodCall, result: MethodChannel.Result) {
    Ln.d(HANDLER_ACTIVITY, "onStartActivityCall")
    val intentMap = call.arguments as Map<*, *>
    val intent = mapToIntent(intentMap)
    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
    context?.startActivity(intent)
  }

  private fun onCheckSelfPermissionCall(call: MethodCall, result: MethodChannel.Result) {
    Ln.d(HANDLER_ACTIVITY, "onCheckSelfPermissionCall")

    val permission = call.argument<String>("permission")
    if (context != null && permission != null) {
      val grantResult = ContextCompat.checkSelfPermission(context!!, permission)
      result.success(grantResult)
    } else {
      result.success(PackageManager.PERMISSION_DENIED)
    }
  }

  override fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if(context != null) {
      when(call.method) {
        METHOD_START_ACTIVITY -> {
          onStartActivityCall(call, result)
        }
        METHOD_CHECK_SELF_PERMISSION -> {
          onCheckSelfPermissionCall(call, result)
        }
      }
    }
  }

  override fun onDestroy() {
    // isHandling = false
  }
}
