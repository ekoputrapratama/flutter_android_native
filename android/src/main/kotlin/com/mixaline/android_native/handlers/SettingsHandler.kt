package com.mixaline.android_native.handlers

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.media.AudioManager
import android.provider.Settings
import androidx.core.content.ContextCompat
import com.mixaline.android_native.utils.*

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

// const _SETTINGS_PORT_NAME = "settingsEventPort";

class SettingsHandler(messageChannel: MethodChannel, eventChannel: EventChannel, private val context: Context) : BaseCallHandler(messageChannel, eventChannel) {

  private var isHandling = false

  companion object {
    const val TAG = "SettingsHandler"
  }

  init {
    isHandling = true
    name = HANDLER_SETTINGS
  }

  // Secure Settings method

  private fun onSecureGetStringCall(call: MethodCall, result: MethodChannel.Result) {
    Ln.d("onSecureGetStringCall")
    val key = call.argument<String>("key")
    result.success(Settings.Secure.getString(context.contentResolver, key))
  }

  private fun onSecureGetIntCall(call: MethodCall, result: MethodChannel.Result) {
    val key = call.argument<String>("key")
    result.success(Settings.Secure.getInt(context.contentResolver, key))
  }

  private fun onSecureGetLongCall(call: MethodCall, result: MethodChannel.Result) {
    val key = call.argument<String>("key")
    result.success(Settings.Secure.getLong(context.contentResolver, key))
  }

  private fun onSecureGetFloatCall(call: MethodCall, result: MethodChannel.Result) {
    val key = call.argument<String>("key")
    result.success(Settings.Secure.getFloat(context.contentResolver, key))
  }

  private fun onSecurePutStringCall(call: MethodCall, result: MethodChannel.Result) {
    val key = call.argument<String>("key")
    val value = call.argument<String>("value")!!
    Settings.Secure.putString(
      context.contentResolver,
      key,
      value
    )
  }

  private fun onSecurePutIntCall(call: MethodCall, result: MethodChannel.Result) {
    val key = call.argument<String>("key")
    val value = call.argument<Int>("value")!!
    Settings.Secure.putInt(
      context.contentResolver,
      key,
      value
    )

    val newValue = Settings.Secure.getInt(context.contentResolver, key)

    result.success(value == newValue)
  }

  private fun onSecurePutLongCall(call: MethodCall, result: MethodChannel.Result) {
    val args = call.arguments as Map<*, *>
    val key = call.argument<String>("key")
    val value = getLong(args["value"])!!
    Settings.Secure.putLong(
      context.contentResolver,
      key,
      value
    )

    val newValue = Settings.Secure.getLong(context.contentResolver, key)
    result.success(value == newValue)
  }

  private fun onSecurePutFloatCall(call: MethodCall, result: MethodChannel.Result) {
    val args = call.arguments as Map<*, *>
    val key = call.argument<String>("key")
    val value = getFloat(args["value"])!!
    Settings.Secure.putFloat(
      context.contentResolver,
      key,
      value
    )

    val newValue = Settings.Secure.getFloat(context.contentResolver, key)

    result.success(value == newValue)
  }

  private fun onSecureCanWriteCall(call: MethodCall, result: MethodChannel.Result) {
    val granted = ContextCompat.checkSelfPermission(
      context,
      Manifest.permission.WRITE_SECURE_SETTINGS
    ) == PackageManager.PERMISSION_GRANTED

    result.success(granted)
  }

  // System Settings method

  private fun onSystemGetStringCall(call: MethodCall, result: MethodChannel.Result) {
    val key = call.argument<String>("key")
    result.success(Settings.System.getString(context.contentResolver, key))
  }

  private fun onSystemGetIntCall(call: MethodCall, result: MethodChannel.Result) {
    val key = call.argument<String>("key")
    result.success(Settings.System.getInt(context.contentResolver, key))
  }

  private fun onSystemGetLongCall(call: MethodCall, result: MethodChannel.Result) {
    val key = call.argument<String>("key")
    result.success(Settings.System.getLong(context.contentResolver, key))
  }

  private fun onSystemGetFloatCall(call: MethodCall, result: MethodChannel.Result) {
    val key = call.argument<String>("key")
    result.success(Settings.System.getFloat(context.contentResolver, key))
  }

  private fun onSystemPutStringCall(call: MethodCall, result: MethodChannel.Result) {
    val key = call.argument<String>("key")
    val value = call.argument<String>("value")!!
    Settings.System.putString(
      context.contentResolver,
      key,
      value
    )
  }

  private fun onSystemPutIntCall(call: MethodCall, result: MethodChannel.Result) {
    val key = call.argument<String>("key")
    val value = call.argument<Int>("value")!!
    Settings.System.putInt(
      context.contentResolver,
      key,
      value
    )

    val newValue = Settings.System.getInt(context.contentResolver, key)
    if(value != newValue) {
      Ln.d("cannot update system settings $key")
    } else {
      Ln.d("settings with key $key has been updated to $value")
    }
    result.success(value == newValue)
  }

  private fun onSystemPutLongCall(call: MethodCall, result: MethodChannel.Result) {
    val args = call.arguments as Map<*, *>
    Settings.System.putLong(
      context.contentResolver,
      call.argument<String>("key"),
      getLong(args["value"])!!
    )
  }

  private fun onSystemPutFloatCall(call: MethodCall, result: MethodChannel.Result) {
    val args = call.arguments as Map<*, *>
    Settings.System.putFloat(
      context.contentResolver,
      call.argument<String>("key"),
      getFloat(args["value"])!!
    )
  }

  private fun onSystemCanWriteCall(call: MethodCall, result: MethodChannel.Result) {
    if (isAtLeastM()) {
      result.success(Settings.System.canWrite(context))
    } else {
      result.success(false)
    }
  }

  private  fun onSystemGetUriFor(call: MethodCall, result: MethodChannel.Result) {
    val name = call.argument<String>("name")
    val uri = Settings.System.getUriFor(name).toString()
    result.success(uri)
  }

  private  fun onSecureGetUriFor(call: MethodCall, result: MethodChannel.Result) {
    val name = call.argument<String>("name")
    val uri = Settings.Secure.getUriFor(name).toString()
    result.success(uri)
  }

  override fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if (isHandling) {

      when (call.method) {
        METHOD_SYSTEM_CAN_WRITE -> {
          onSystemCanWriteCall(call, result)
        }
        METHOD_SECURE_CAN_WRITE -> {
          onSecureCanWriteCall(call, result)
        }
        METHOD_SYSTEM_GET_STRING -> {
          onSystemGetStringCall(call, result)
        }
        METHOD_SYSTEM_GET_INT -> {
          onSystemGetIntCall(call, result)
        }
        METHOD_SYSTEM_GET_URI_FOR -> {
          onSystemGetUriFor(call, result)
        }
        METHOD_SECURE_GET_STRING -> {
          onSecureGetStringCall(call, result)
        }
        METHOD_SECURE_GET_INT -> {
          onSecureGetIntCall(call, result)
        }
        METHOD_SECURE_GET_URI_FOR -> {
          onSecureGetUriFor(call, result)
        }
      }
    }
  }

  override fun onDestroy() {
    isHandling = false
  }
}
