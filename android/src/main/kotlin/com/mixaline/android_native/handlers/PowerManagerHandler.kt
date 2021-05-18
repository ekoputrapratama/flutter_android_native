package com.mixaline.android_native.handlers

import android.content.Context
import android.os.PowerManager
import com.mixaline.android_native.utils.*

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class PowerManagerHandler(messageChannel: MethodChannel, eventChannel: EventChannel, val context: Context) : BaseCallHandler(messageChannel,eventChannel) {
  private var isHandling = false
  private var powerManager = context.getSystemService(Context.POWER_SERVICE) as PowerManager

  init {
    isHandling = true
    name = "PowerManager"
  }

  private fun onIsInteractiveCall(call: MethodCall, result: MethodChannel.Result){
    if(isAtLeastKW()) {
      result.success(powerManager.isInteractive)
    } else {
      result.success(powerManager.isScreenOn)
    }
  }

  override fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if(isHandling) {
      when (call.method) {
        METHOD_IS_SCREEN_ON -> {
          onIsInteractiveCall(call, result)
        }
        METHOD_IS_INTERACTIVE -> {
          onIsInteractiveCall(call, result)
        }
      }
    }
  }

  override fun onDestroy() {
    TODO("Not yet implemented")
  }
}
