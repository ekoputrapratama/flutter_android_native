package com.mixaline.android_native.handlers

import android.content.ComponentName
import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.drawable.Drawable


import com.mixaline.android_native.utils.*

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class PackageManagerHandler(messageChannel: MethodChannel, eventChannel: EventChannel, context: Context) : BaseCallHandler(messageChannel,eventChannel) {
  private var isHandling = false
  private var packageManager = context.packageManager

  init {
    isHandling = true
    name = "PackageManager"
  }

  private fun onGetActivityInfoCall(call: MethodCall, result: MethodChannel.Result) {
    val packageName = call.argument<String>(PARAM_PACKAGE_NAME)
    val className = call.argument<String>(PARAM_CLASS_NAME)
    val flags = call.argument<Int>(PARAM_FLAGS)
    if(packageName != null && className != null) {
      val component = ComponentName(packageName, className)
      try {
        val map = packageManager.getActivityInfo(component, flags ?: 0).toMap(packageManager)
        result.success(map)
      } catch(e: PackageManager.NameNotFoundException) {
        result.success(null)
      }
    } else {
      result.success(null)
    }
  }

  private fun onGetPackageInfoCall(call: MethodCall, result: MethodChannel.Result) {
    val packageName = call.argument<String>(PARAM_PACKAGE_NAME)
    val flags = call.argument<Int>(PARAM_FLAGS)
    if(packageName != null) {
      result.success(packageManager.getPackageInfo(packageName, flags ?: 0).toMap(packageManager))
    } else {
      result.success(null)
    }
  }

  private fun onGetInstalledApplicationsCall(call: MethodCall, result: MethodChannel.Result){
    val flags = call.argument<Int>(PARAM_FLAGS)!!

    val apps = packageManager.getInstalledApplications(flags)
      .mapNotNull { info ->
        info.toMap(packageManager)
      }

    result.success(apps)
  }

  private fun onGetInstalledPackagesCall(call: MethodCall, result: MethodChannel.Result){
    val flags = call.argument<Int>(PARAM_FLAGS)!!

    val packages = packageManager.getInstalledPackages(flags)
    Ln.d(name, "packages length ${packages.size}")
    val apps = packages
      .mapNotNull { info ->
        info.toMap(packageManager)
      }

    Ln.d(name, "apps length ${apps.size}")
    result.success(apps)
  }

  private fun onQueryIntentActivitiesCall(call: MethodCall, result: MethodChannel.Result) {
    val flags = call.argument<Int>(PARAM_FLAGS)!!
    val intentMap = call.argument<Map<*, *>>("intent")!!
    val intent = mapToIntent(intentMap)

    val infos = packageManager.queryIntentActivities(intent, flags)
      .mapNotNull { info -> info.toMap(packageManager) }

    result.success(infos)
  }

  private fun onGetApplicationIconCall(call: MethodCall, result: MethodChannel.Result) {
    val packageName = call.argument<String>(PARAM_PACKAGE_NAME)

    if(packageName != null) {
      val icon = packageManager.getApplicationIcon(packageName)

      result.success(normalizeIcon(icon, 100))
    } else {
      result.success(null)
    }
  }

  override fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if(isHandling) {
      when(call.method) {
        METHOD_GET_ACTIVITY_INFO -> {
          onGetActivityInfoCall(call, result)
        }
        METHOD_GET_INSTALLED_APPLICATIONS -> {
          onGetInstalledApplicationsCall(call, result)
        }
        METHOD_GET_INSTALLED_PACKAGES -> {
          onGetInstalledPackagesCall(call, result)
        }
        METHOD_QUERY_INTENT_ACTIVITIES -> {
          onQueryIntentActivitiesCall(call, result)
        }
        METHOD_GET_TEXT -> {

        }
        METHOD_GET_APPLICATION_ICON -> {
          onGetApplicationIconCall(call, result)
        }
        METHOD_GET_PACKAGE_INFO -> {
          onGetPackageInfoCall(call, result)
        }
      }
    }
  }

  override fun onDestroy() {
    isHandling = false
  }
}
