package com.mixaline.android_native

import android.app.Activity
import android.content.Context

import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar

import com.mixaline.android_native.handlers.*
import com.mixaline.android_native.utils.*
import io.flutter.plugin.common.BinaryMessenger


fun interface ActivityRegistry {
  fun addListener(handler: PluginRegistry.ActivityResultListener): Any?
}

fun interface PermissionRegistry {
  fun addListener(handler: PluginRegistry.RequestPermissionsResultListener): Any?
}

fun interface IntentRegistry {
  fun addListener(handler: PluginRegistry.NewIntentListener): Any?
}

fun interface ActivityOnDestroyRegistry {
  fun addListener(handler: PluginRegistry.ViewDestroyListener)
}

/** AndroidNativePlugin */
class AndroidNativePlugin : FlutterPlugin, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private var channel: MethodChannel? = null
  private var methodCallHandler: AndroidNativeCallHandler? = null

  companion object {
    const val TAG = "AndroidNativePlugin"
    

    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val plugin = AndroidNativePlugin();
      plugin.startListening(registrar.context(), registrar.messenger())

      if (registrar.activeContext() is Activity) {
        val activity = registrar.activity() ?: return
        plugin.startListeningToActivity(
          activity,
          registrar::addActivityResultListener,
          registrar::addRequestPermissionsResultListener,
          registrar::addNewIntentListener
        )
      }
    }
  }

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    Ln.d(TAG, "onAttachedToEngine")
    startListening(binding.applicationContext, binding.binaryMessenger)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    Ln.d(TAG, "onAttachedToActivity")
    startListeningToActivity(
      binding.activity,
      binding::addActivityResultListener,
      binding::addRequestPermissionsResultListener,
      binding::addOnNewIntentListener
    )
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    Ln.d(TAG, "onReattachedToActivityForConfigChanges")
    onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivity() {
    Ln.d(TAG, "onDetachedFromActivity")
    stopListeningToActivity();
  }

  override fun onDetachedFromActivityForConfigChanges() {
    Ln.d(TAG, "onDetachedFromActivityForConfigChanges")
    onDetachedFromActivity();
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    Ln.d(TAG, "onDetachedFromEngine")
    stopListening()
  }

  private fun stopListening() {
    // channel?.setMethodCallHandler(null)
    // channel = null
  }

  fun startListening(applicationContext: Context, messenger: BinaryMessenger) {
    methodCallHandler = AndroidNativeCallHandler(applicationContext, messenger)
  }

  fun startListeningToActivity(activity: Activity, activityRegistry: ActivityRegistry, permissionRegistry: PermissionRegistry, intentRegistry: IntentRegistry) {
    Ln.d("intent hasExtra ${activity.intent.hasExtra("search")}")
    Ln.d("packageName ${activity.intent.getStringExtra("package_name")}")
    if (methodCallHandler != null) {
      methodCallHandler?.setActivity(activity)
      methodCallHandler?.setActivityRegistry(activityRegistry)
      methodCallHandler?.setPermissionRegistry(permissionRegistry)
      methodCallHandler?.setIntentRegistry(intentRegistry)
    }
  }

  private fun stopListeningToActivity() {
    if (methodCallHandler != null) {
      methodCallHandler?.setActivity(null)
      methodCallHandler?.setActivityRegistry(null)
      methodCallHandler?.setPermissionRegistry(null)
      methodCallHandler?.setIntentRegistry(null)
    }
  }
}
