package com.mixaline.android_native.handlers

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Build

import com.mixaline.android_native.ActivityRegistry
import com.mixaline.android_native.PermissionRegistry
import com.mixaline.android_native.IntentRegistry

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry
import com.mixaline.android_native.utils.*

class AndroidNativeCallHandler(
  private var applicationContext: Context, private var messenger: BinaryMessenger
) : MethodCallHandler, EventChannel.StreamHandler,
    PluginRegistry.ActivityResultListener, 
    PluginRegistry.RequestPermissionsResultListener,
    PluginRegistry.NewIntentListener {

  private var activityRegistry: ActivityRegistry? = null
  private var permissionRegistry: PermissionRegistry? = null
  private var intentRegistry: IntentRegistry? = null
  private var activity: Activity? = null

  private var handlers: MutableMap<String, BaseCallHandler> = mutableMapOf()
  private var messageChannel = MethodChannel(messenger, MESSAGES_CHANNEL)
  private var eventChannel = EventChannel(messenger, EVENTS_CHANNEL)


  companion object {
    const val MESSAGES_CHANNEL = "com.mixaline.android_native/messages"
    const val EVENTS_CHANNEL = "com.mixaline.android_native/events"
  }

  init {
    messageChannel!!.setMethodCallHandler(this)
  }

  fun setActivity(activity: Activity?) {
    this.activity = activity
    if(handlers.containsKey(HANDLER_ACTIVITY)) {
      val handler = handlers[HANDLER_ACTIVITY] as ActivityHandler
      handler.activity = activity
    }
  }

  fun setPermissionRegistry(registry: PermissionRegistry?) {
    this.permissionRegistry = registry
    registry?.addListener(this)
  }

  fun setActivityRegistry(registry: ActivityRegistry?) {
    this.activityRegistry = registry
    registry?.addListener(this)
  }

  fun setIntentRegistry(registry: IntentRegistry?) {
    this.intentRegistry = registry
    registry?.addListener(this)
  }

  override fun onListen(o: Any, eventSink: EventChannel.EventSink) {

  }

  override fun onCancel(o: Any) {

  }

  override fun onMethodCall(call: MethodCall, result: Result) {

    val handlerName = call.method.split(".").first()
    Ln.d("onMethodCall : using handler $handlerName for handling method call ${call.method}")
    var handler: BaseCallHandler?
    if(!handlers.containsKey(handlerName)) {
      handler = getHandlerInstance(handlerName)
      when {
        handler != null -> {
          handlers[handlerName] = handler
        }
        handlerName == "Build" -> {

          val map = mutableMapOf<Any, Any?>()
          map["SDK_INT"] = Build.VERSION.SDK_INT
          map["SDK"] = Build.VERSION.SDK
          map["SERIAL"] = Build.SERIAL
          if(isAtLeastM()) {
            map["PREVIEW_SDK_INT"] = Build.VERSION.PREVIEW_SDK_INT
            map["BASE_OS"] = Build.VERSION.BASE_OS
            map["SECURITY_PATCH"] = Build.VERSION.SECURITY_PATCH
          }
          map["CODENAME"] = Build.VERSION.CODENAME
          map["INCREMENTAL"] = Build.VERSION.INCREMENTAL
          map["RELEASE"] = Build.VERSION.RELEASE
          // map["RELEASE_OR_CODENAME"] = Build.VERSION.RELEASE_OR_CODENAME;


          result.success(map)
        }
        else -> {
          result.notImplemented()
        }
      }
    } else {
      handler = handlers[handlerName]
    }

    handler?.handleMethodCall(call, result)
  }

  private fun getHandlerInstance(name: String): BaseCallHandler? {
    return when(name) {
      HANDLER_AUDIO_MANAGER -> {
        AudioManagerHandler(messageChannel, eventChannel, applicationContext)
      }
      HANDLER_PACKAGE_MANAGER -> {
        PackageManagerHandler(messageChannel, eventChannel, applicationContext)
      }
      HANDLER_SETTINGS -> {
        SettingsHandler(messageChannel, eventChannel, applicationContext)
      }
      HANDLER_KEYGUARD_MANAGER -> {
        KeyguardManagerHandler(messageChannel, eventChannel, applicationContext)
      }
      HANDLER_POWER_MANAGER -> {
        PowerManagerHandler(messageChannel, eventChannel, applicationContext)
      }
      HANDLER_ACTIVITY -> {
        ActivityHandler(messageChannel, eventChannel, activity)
      }
      HANDLER_CONTEXT -> {
        ContextHandler(messageChannel, eventChannel, applicationContext)
      }
      HANDLER_SHARED_PREFERENCES -> {
        SharedPreferencesHandler(messageChannel, eventChannel, applicationContext)
      }
      HANDLER_CONTENT_RESOLVER -> {
        ContentResolverHandler(messageChannel, eventChannel, applicationContext)
      }
      HANDLER_TELEPHONY_MANAGER -> {
        TelephonyManagerHandler(messageChannel, eventChannel, applicationContext)
      }
      else -> null
    }
  }

  override fun onNewIntent(intent: Intent): Boolean {
    val results: Map<Any, Any?> = intent.toMap()
    Ln.d("onNewIntent : $results")
    messageChannel.invokeMethod(METHOD_ON_NEW_INTENT, results)
    return false
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    Ln.d("onActivityResult : requestCode=$requestCode, resultCode=$resultCode")
    val results: HashMap<Any, Any?> = HashMap()
    results["requestCode"] = requestCode
    results["resultCode"] = resultCode
    results["intent"] = data?.toMap()
    messageChannel.invokeMethod(METHOD_ON_ACTIVITY_RESULT, results)
    return true
  }

  override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray): Boolean {
    Ln.d( "onRequestPermissionsResult : requestCode=$requestCode, permissions=$permissions")
    val results: HashMap<Any, Any?> = HashMap()
    results["requestCode"] = requestCode
    results["permissions"] = permissions?.toCollection(ArrayList())
    results["grantResults"] = grantResults?.toCollection(ArrayList())
    messageChannel.invokeMethod(METHOD_ON_REQUEST_PERMISSIONS_RESULT, results)
    return true
  }

}
