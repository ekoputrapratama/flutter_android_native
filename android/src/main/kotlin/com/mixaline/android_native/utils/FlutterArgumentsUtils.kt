package com.mixaline.android_native.utils

internal fun getLong(o: Any?): Long? {
  return if (o == null || o is Long) (o as Long) else (o as Int).toLong()
}

internal fun getFloat(o: Any?): Float? {
  return if (o == null || o is Float || o is Double) {
    when (o) {
      is Float -> (o as Float)
      is Double -> (o as Double).toFloat()
      else -> null
    }
  } else {
    null
  }
}