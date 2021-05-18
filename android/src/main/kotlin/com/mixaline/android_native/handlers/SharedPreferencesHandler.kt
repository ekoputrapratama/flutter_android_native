package com.mixaline.android_native.handlers

import android.content.SharedPreferences
import android.content.SharedPreferences.OnSharedPreferenceChangeListener
import android.content.Context
import com.mixaline.android_native.utils.isAtLeastN

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class SharedPreferencesHandler(messageChannel: MethodChannel, eventChannel: EventChannel, val context: Context) : BaseCallHandler(messageChannel,eventChannel) {
  private var isHandling = false
  private var sharedPreferences: MutableMap<String, SharedPreferences> = mutableMapOf()
  private var changeListeners: MutableMap<String, OnSharedPreferenceChangeListener> = mutableMapOf()
  companion object {
    const val TAG = "SharedPreferencesHandler"
  }

  init {
    isHandling = true
    name = HANDLER_SHARED_PREFERENCES
  }

  private fun onGetIntCall(call: MethodCall, result: MethodChannel.Result){
    val name = call.argument<String>("name")!!
    val key = call.argument<String>("key")!!
    var defaultValue = call.argument<Int>("defaultValue")
    if(sharedPreferences[name] != null){
      if(defaultValue == null) {
        defaultValue = 0
      }
      result.success(sharedPreferences[name]!!.getInt(key, defaultValue))
    } else {
      result.success(null)
    }
  }

  private fun onGetStringCall(call: MethodCall, result: MethodChannel.Result){
    val name = call.argument<String>("name")!!
    val key = call.argument<String>("key")!!
    val defaultValue = call.argument<String>("defaultValue")
    if(sharedPreferences[name] != null){
      result.success(sharedPreferences[name]!!.getString(key, defaultValue!!))
    } else {
      result.success(null)
    }
  }

  private fun onGetBooleanCall(call: MethodCall, result: MethodChannel.Result){
    val name = call.argument<String>("name")!!
    val key = call.argument<String>("key")!!
    var defaultValue = call.argument<Boolean>("defaultValue")
    if(sharedPreferences[name] != null){
      if(defaultValue == null) {
        defaultValue = false
      }
      result.success(sharedPreferences[name]!!.getBoolean(key, defaultValue))
    } else {
      result.success(null)
    }
  }

  private fun onPutBooleanCall(call: MethodCall, result: MethodChannel.Result) {
    val name = call.argument<String>("name")!!
    val key = call.argument<String>("key")!!
    val value = call.argument<Boolean>("value")!!
    result.success(sharedPreferences[name]!!.edit().putBoolean(key, value).commit())
  }

  private fun onPutIntCall(call: MethodCall, result: MethodChannel.Result) {
    val name = call.argument<String>("name")!!
    val key = call.argument<String>("key")!!
    val value = call.argument<Int>("value")!!
    result.success(sharedPreferences[name]!!.edit().putInt(key, value).commit())
  }

  private fun onPutStringCall(call: MethodCall, result: MethodChannel.Result) {
    val name = call.argument<String>("name")!!
    val key = call.argument<String>("key")!!
    val value = call.argument<String>("value")!!
    result.success(sharedPreferences[name]!!.edit().putString(key, value).commit())
  }

  private fun onPutFloatCall(call: MethodCall, result: MethodChannel.Result) {
    val name = call.argument<String>("name")!!
    val key = call.argument<String>("key")!!
    val value = call.argument<Float>("value")!!
    result.success(sharedPreferences[name]!!.edit().putFloat(key, value).commit())
  }
  
  private fun onGetAllCall(call: MethodCall, result: MethodChannel.Result) {
    val name = call.argument<String>("name")!!
    result.success(sharedPreferences[name]!!.all)
  }

  private fun onRegisterSharedPreferenceChangeListenerCall(call: MethodCall, result: MethodChannel.Result) {
    val name = call.argument<String>("name")!!

    if(changeListeners[name] == null) {
      changeListeners[name] = OnSharedPreferenceChangeListener { _, _ ->
        val map = mutableMapOf<Any, Any?>()
        map["name"] = name
        messageChannel.invokeMethod("OnSharedPreferenceChangeListener", map)
      }
    }
  }

  private fun initPreferences(call: MethodCall){
    val name = call.argument<String>("name")!!
    val useDeviceProtectedStorage = call.argument<Boolean>(PARAM_USE_DEVICE_PROTECTED_STORAGE)!!
    var storageContext: Context = context
    if(!sharedPreferences.containsKey(name)) {
      val mode = call.argument<Int>("mode")!!
      if(useDeviceProtectedStorage && isAtLeastN()) {
        storageContext = context.createDeviceProtectedStorageContext()
      }
      sharedPreferences[name] = storageContext.getSharedPreferences(name, mode)
    }
  }

  override fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
    initPreferences(call)
    when(call.method) {
      METHOD_SP_GET_STRING -> {
        onGetStringCall(call, result)
      }
      METHOD_SP_GET_INT -> {
        onGetIntCall(call, result)
      }
      METHOD_SP_GET_BOOLEAN -> {
        onGetBooleanCall(call, result)
      }
      METHOD_SP_GET_ALL -> {
        onGetAllCall(call, result)
      }
      METHOD_SP_PUT_STRING -> {
        onPutStringCall(call, result)
      }
      METHOD_SP_PUT_INT -> {
        onPutIntCall(call, result)
      }
      METHOD_SP_PUT_BOOLEAN -> {
        onPutBooleanCall(call, result)
      }
      METHOD_SP_PUT_FLOAT -> {
        onPutFloatCall(call, result)
      }
      METHOD_SP_REGISTER_SP_CHANGE_LISTENER -> {
        onRegisterSharedPreferenceChangeListenerCall(call, result)
      }
    }
  }

  override fun onDestroy() {

  }
}
