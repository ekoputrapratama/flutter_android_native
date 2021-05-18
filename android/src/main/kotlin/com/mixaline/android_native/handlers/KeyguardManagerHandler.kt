package com.mixaline.android_native.handlers

import android.app.KeyguardManager
import android.content.Context

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class KeyguardManagerHandler(messageChannel: MethodChannel, eventChannel: EventChannel, val context: Context) : BaseCallHandler(messageChannel, eventChannel) {
  private var isHandling = false
  private var keyguardManager = context.getSystemService(Context.KEYGUARD_SERVICE) as KeyguardManager

  companion object {
    const val TAG = "KeyguardManagerHandler"
    const val HANDLER_NAME = ""
  }

  init {
    isHandling = true
    name = "KeyguardManager"
  }

  override fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if(isHandling) {
      when (call.method) {
        METHOD_IS_KEYGUARD_LOCKED -> {
          result.success(keyguardManager.isKeyguardLocked)
        }
      }
    }
  }

  override fun onDestroy() {
    TODO("Not yet implemented")
  }
}
