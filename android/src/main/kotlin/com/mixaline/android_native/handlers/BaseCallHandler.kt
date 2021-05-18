package com.mixaline.android_native.handlers

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


abstract class BaseCallHandler(val messageChannel: MethodChannel, val eventChannel: EventChannel) {
  var name: String? = null

  abstract fun handleMethodCall(call: MethodCall, result: MethodChannel.Result)
  abstract fun onDestroy()
}
