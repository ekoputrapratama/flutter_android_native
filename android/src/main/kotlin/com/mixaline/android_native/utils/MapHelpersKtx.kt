package com.mixaline.android_native.utils

import android.content.ComponentName
import android.content.Intent
import android.content.pm.*
import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import android.net.Uri
import android.os.Bundle

internal fun ActivityInfo.toMap(pm: PackageManager): Map<Any, Any?> {
  val map = mutableMapOf<Any, Any?>()
  
  // ActivityInfo
  if(isAtLeastL()) {
    map["documentLaunchMode"] = documentLaunchMode
    map["maxRecents"] = maxRecents
    map["persistableMode"] = persistableMode
  }

  if(isAtLeastN()) {
    map["windowLayout"] = windowLayout?.toMap()
    map["directBootAware"] = directBootAware
  }

  if(isAtLeastO()) {
    map["colorMode"] = colorMode
    map["splitName"] = splitName
  }

  map["configChanges"] = configChanges
  map["flags"] = flags
  map["launchMode"] = launchMode
  map["parentActivityName"] = parentActivityName
  map["premission"] = permission
  map["screenOrientation"] = screenOrientation
  map["softInputMode"] = softInputMode
  map["targetActivity"] = targetActivity
  map["taskAffinity"] = taskAffinity
  map["theme"] = theme
  map["uiOptions"] = uiOptions

  
  // ComponentInfo
  map["applicationInfo"] = applicationInfo.toMap(pm)
  map["descriptionRes"] = descriptionRes
  map["enabled"] = enabled
  map["exported"] = exported
  map["processName"] = processName


  // PackageItemInfo
  map["name"] = name
  map["packageName"] = packageName
  map["labelRes"] = labelRes
  map["icon"] = icon
  map["logo"] = logo
  if (isAtLeastKW())
    map["banner"] = banner
  map["label"] = loadLabel(
      pm
  ).toString()

  val icon = pm.getApplicationIcon(packageName)
  val iconHeight = getNormalizedImageHeight(icon)
  val iconWidth = getNormalizedImageWidth(icon)
  val iconBitmap = Bitmap.createBitmap(
      iconWidth,
      iconHeight,
      Bitmap.Config.ARGB_8888
  )
  val y = (iconBitmap!!.height - iconHeight) / 2
  renderDrawableToBitmap(
      icon, iconBitmap, 0, y, iconWidth,
      iconHeight
  )

  map["base64_icon"] = encodeToBase64(iconBitmap, Bitmap.CompressFormat.PNG, 50)
  map["base64_logo"] = encodeToBase64(drawableToBitmap(loadLogo(
      pm
  )), Bitmap.CompressFormat.PNG, 50)
  if (isAtLeastKW())
    map["base64_banner"] = encodeToBase64(drawableToBitmap(loadBanner(
        pm
    )), Bitmap.CompressFormat.PNG, 50)
  if (isAtLeastLMR1())
    map["base64_unbadged_icon"] = encodeToBase64(drawableToBitmap(loadUnbadgedIcon(
        pm
    )), Bitmap.CompressFormat.PNG, 50)
  
  return map
}

internal fun ActivityInfo.WindowLayout.toMap() : Map<Any, Any?> {
  val map = mutableMapOf<Any, Any?>()
  if(isAtLeastN()) {
    map["width"] = width
    map["height"] = height
    map["widthFraction"] = widthFraction
    map["heightFraction"] = heightFraction
    map["gravity"] = gravity
    map["minHeight"] = minHeight
    map["minWidth"] = minWidth
  }
  return map;
}

private fun getNormalizedImageWidth(drawable: Drawable): Int {
  val maxHeight = 64

  var imageHeight = drawable.intrinsicHeight
  var imageWidth = drawable.intrinsicWidth

  var scale = -1f
  if (imageHeight > maxHeight) {
    scale = maxHeight.toFloat() / imageHeight
  }

  if (scale != -1f) {
    imageWidth = (scale * imageWidth).toInt()
  }

  return imageWidth
}

private fun getNormalizedImageHeight(drawable: Drawable): Int {
  val maxHeight = 64

  var imageHeight = drawable.intrinsicHeight
  var imageWidth = drawable.intrinsicWidth

  var scale = -1f
  if (imageHeight > maxHeight) {
    scale = maxHeight.toFloat() / imageHeight
  }

  if (scale != -1f) {
    imageHeight = (scale * imageHeight).toInt()
  }

  return imageHeight
}

internal fun ApplicationInfo.toMap(pm: PackageManager): Map<Any, Any?> {
  val map = mutableMapOf<Any, Any?>()
  // ApplicationInfo
  map["nonLocalizedLabel"] = nonLocalizedLabel
  map["icon"] = icon
  if (isAtLeastO())
    map["category"] = category
  map["className"] = className
  map["descriptionRes"] = descriptionRes
  map["enabled"] = enabled
  map["flags"] = flags
  if (isAtLeastN())
    map["minSdkVersion"] = minSdkVersion
  map["targetSdkVersion"] = targetSdkVersion
  map["dataDir"] = dataDir
  map["publicSourceDir"] = publicSourceDir
  map["sourceDir"] = sourceDir
  map["theme"] = theme

  // PackageItemInfo
  map["name"] = name
  map["packageName"] = packageName
  map["labelRes"] = labelRes
  map["icon"] = icon
  map["logo"] = logo
  if (isAtLeastKW())
    map["banner"] = banner
  map["label"] = loadLabel(
      pm
  ).toString()

  val icon = pm.getApplicationIcon(packageName)
  val iconHeight = getNormalizedImageHeight(icon)
  val iconWidth = getNormalizedImageWidth(icon)
  val iconBitmap = Bitmap.createBitmap(
      iconWidth,
      iconHeight,
      Bitmap.Config.ARGB_8888
  )
  val y = (iconBitmap!!.height - iconHeight) / 2
  renderDrawableToBitmap(
      icon, iconBitmap, 0, y, iconWidth,
      iconHeight
  )

  map["base64_icon"] = encodeToBase64(iconBitmap, Bitmap.CompressFormat.PNG, 100)
  map["base64_logo"] = encodeToBase64(drawableToBitmap(loadLogo(
      pm
  )), Bitmap.CompressFormat.PNG, 50)
  if (isAtLeastKW())
    map["base64_banner"] = encodeToBase64(drawableToBitmap(loadBanner(
        pm
    )), Bitmap.CompressFormat.PNG, 50)
  if (isAtLeastLMR1())
    map["base64_unbadged_icon"] = encodeToBase64(drawableToBitmap(loadUnbadgedIcon(
        pm
    )), Bitmap.CompressFormat.PNG, 50)

  return map
}

internal fun PackageInfo.toMap(pm: PackageManager): Map<Any, Any?> {
  val map = mutableMapOf<Any, Any?>()
  map["applicationInfo"] = applicationInfo?.toMap(pm)
  map["packageName"] = packageName
  // map["isApex"] = isApex
  map["firstInstallTime"] = firstInstallTime
  if (isAtLeastLMR1())
    map["baseRevisionCode"] = baseRevisionCode
  map["versionCode"] = versionCode
  map["versionName"] = versionName
  map["sharedUserId"] = sharedUserId

  return map
}

fun normalizeIcon(drawable: Drawable, quality: Int = 100): String? {
  val iconHeight = getNormalizedImageHeight(drawable)
  val iconWidth = getNormalizedImageWidth(drawable)
  val iconBitmap = Bitmap.createBitmap(
      iconWidth,
      iconHeight,
      Bitmap.Config.ARGB_8888
  )
  val y = (iconBitmap!!.height - iconHeight) / 2
  renderDrawableToBitmap(
      drawable, iconBitmap, 0, y, iconWidth,
      iconHeight
  )

  return encodeToBase64(iconBitmap, Bitmap.CompressFormat.PNG, quality)
}

internal fun ResolveInfo.toMap(pm: PackageManager): Map<Any, Any?> {
  val map = mutableMapOf<Any, Any?>()

  map["activityInfo"] = activityInfo.toMap(pm)
  map["icon"] = icon
  map["isDefault"] = isDefault
  if (isAtLeastO())
    map["isInstantAppAvailable"] = isInstantAppAvailable
  map["labelRes"] = labelRes
  map["match"] = match
  map["nonLocalizedLabel"] = nonLocalizedLabel
  map["preferredOrder"] = preferredOrder
  map["priority"] = priority
  map["resolvePackageName"] = resolvePackageName
  // map["specificIndex"] specificIndex
  map["label"] = loadLabel(pm)

  val icon = loadIcon(pm)
  map["base64_icon"] = normalizeIcon(icon, 50)
  return map
}


fun Intent.toMap(): Map<Any, Any?> {
  val map = mutableMapOf<Any, Any?>()
  map["action"] = action
  if (categories != null) {
    map["categories"] = categories.joinToString(",")
  }
  if (data != null) {
    map["data"] = data.toString()
  }

  val bundle = extras
  if(bundle != null){
    val mapBundle = mutableMapOf<Any, Any?>()
    for (key in bundle.keySet()) {
      mapBundle[key] = bundle.get(key)
    }
    map["extras"] = mapBundle
  }
  return map
}


fun mapToComponent(map: Map<*, *>?): ComponentName? {
  return if (map != null) {
    ComponentName(map["packageName"] as String, map["className"] as String)
  } else {
    null
  }
}

internal fun parseMapToBundle(map: Map<*, *>): Bundle? {
  val bundle = Bundle()
  for ((key, value) in map.entries) {
    when(value) {
      is String -> {
        bundle.putString(key as String?, value)
      }
      is Double -> {
        bundle.putDouble(key as String?, value)
      }
      is Float -> {
        bundle.putFloat(key as String?, value)
      }
      is Long -> {
        bundle.putLong(key as String?, value)
      }
      is Int -> {
        bundle.putInt(key as String?, value)
      }
      is List<*> -> {
        if(value.isNotEmpty() && value.first() is Int) {
          bundle.putIntArray(key as String?, (value as List<Int>).toIntArray())
        } else if(value.isNotEmpty() && value.first() is String) {
          bundle.putStringArray(key as String?, (value as List<String>).toTypedArray())
        } else if(value.isNotEmpty() && value.first() is Double) {
          bundle.putDoubleArray(key as String?, (value as List<Double>).toDoubleArray())
        } else if(value.isNotEmpty() && value.first() is Short) {
          bundle.putShortArray(key as String?, (value as List<Short>).toShortArray())
        } else if(value.isNotEmpty() && value.first() is Long) {
          bundle.putLongArray(key as String?, (value as List<Long>).toLongArray())
        }

      }
      is Map<*, *> -> {
        bundle.putBundle(key as String?, parseMapToBundle(value))
      }
    }
  }

  return bundle
}


fun mapToIntent(map: Map<*, *>): Intent {
  val intent = Intent()
  intent.action = map["action"] as String?
  if (map.containsKey("categories") && map["categories"] != null) {
    (map["categories"] as List<String>).forEach {
      intent.addCategory(it)
    }
  }
  if (map.containsKey("data") && map["data"] != null) {
    intent.data = Uri.parse(map["data"] as String)
  }
  if (map.containsKey("component") && map["component"] != null) {
    intent.component = mapToComponent(map["component"] as Map<*, *>?)
  }
  if (map.containsKey("package") && map["package"] != null) {
    intent.`package` = map["package"] as String
  }
  if (map.containsKey("extras") && map["extras"] != null) {
//    intent.putExtras(map["extras"]);
    val bundleMap = map["extras"] as Map<*, *>
    val bundle = parseMapToBundle(bundleMap)
    if(bundle != null) {
      for (key in bundle.keySet()) {
        when(val value = bundle.get(key)) {
          is String -> {
            bundle.putString(key, value)
          }
          is Double -> {
            bundle.putDouble(key, value)
          }
          is Float -> {
            bundle.putFloat(key, value)
          }
          is Long -> {
            bundle.putLong(key, value)
          }
          is Int -> {
            bundle.putInt(key, value)
          }
          is List<*> -> {
            if(value.isNotEmpty() && value.first() is Int) {
              bundle.putIntArray(key, (value as List<Int>).toIntArray())
            } else if(value.isNotEmpty() && value.first() is String) {
              bundle.putStringArray(key, (value as List<String>).toTypedArray())
            } else if(value.isNotEmpty() && value.first() is Double) {
              bundle.putDoubleArray(key, (value as List<Double>).toDoubleArray())
            } else if(value.isNotEmpty() && value.first() is Short) {
              bundle.putShortArray(key, (value as List<Short>).toShortArray())
            } else if(value.isNotEmpty() && value.first() is Long) {
              bundle.putLongArray(key, (value as List<Long>).toLongArray())
            }

          }
          is Map<*, *> -> {
            bundle.putBundle(key, parseMapToBundle(value))
          }
        }
      }
    }
  }
  return intent
}
