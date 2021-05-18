package com.mixaline.android_native.handlers

import android.content.Context
import android.database.ContentObserver
import android.net.Uri
import android.os.Handler
import android.os.Looper

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result

import com.mixaline.android_native.utils.*

class ContentResolverHandler(messageChannel: MethodChannel, eventChannel: EventChannel, val context: Context) : BaseCallHandler(messageChannel, eventChannel) {
  private var isHandling = false
  private var observers = mutableMapOf<String, ContentObserver>()

  init {
    isHandling = true
    name = "ContentResolver"
  }

  override fun handleMethodCall(call: MethodCall, result: Result) {
    if(isHandling) {
      when (call.method) {
        METHOD_REGISTER_CONTENT_RESOLVER -> {
          val uri = Uri.parse(call.argument<String>(PARAM_URI)!!)
          Ln.d("registering content resolver with uri $uri")

          val observer = MyContentObserver(Handler(Looper.myLooper()!!), uri)
          
          observers[uri.toString()] = observer
          context.contentResolver.registerContentObserver(
            uri, true,
            observer
          )
        }
      }
    }
  }

  override fun onDestroy() {
    TODO("Not yet implemented")
  }

  inner class MyContentObserver(handler: Handler?, val observedUri: Uri) : ContentObserver(handler) {
    override fun onChange(selfChange: Boolean, uri: Uri?, flags: Int) {
      super.onChange(selfChange, uri, flags)
      Ln.d("ContentObserver onChange with uri $uri")
      val map = mutableMapOf<Any, Any?>()
      map["uri"] = uri?.toString()
      map["flags"] = flags
      map["selfChange"] = selfChange
      map["observedUri"] = observedUri.toString()
      messageChannel.invokeMethod(METHOD_CONTENT_OBSERVER_ON_CHANGE, map)
    }
  }
}
