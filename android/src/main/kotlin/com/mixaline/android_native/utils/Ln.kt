package com.mixaline.android_native.utils

import android.util.Log
import java.io.PrintWriter
import java.io.StringWriter

/**
 * Log both to Android logger (so that logs are visible in "adb logcat") and standard output/error (so that they are visible in the terminal
 * directly).
 */
object Ln {

  private val TAG = "com.mixaline.android_native"
  private val PREFIX = "[android_native] "

  private var threshold = Level.DEBUG

  enum class Level {
    DEBUG, INFO, WARN, ERROR
  }

  /**
   * Initialize the log level.
   *
   *
   * Must be called before starting any new thread.
   *
   * @param level the log level
   */
  fun initLogLevel(level: Level?) {
    threshold = level!!
  }
  @JvmStatic
  fun isEnabled(level: Level): Boolean {
    return level.ordinal >= threshold.ordinal
  }

  @JvmStatic
  fun d(vararg params: Any?) {
    var tag: Any?
    var msg: Any?
    if (isEnabled(Level.DEBUG)) {
      if (params.size > 1) {
        tag = params[0]
        msg = params[1]
        if (tag == null || tag.toString().isEmpty()) {
          tag = TAG
        }
      } else {
        tag = TAG
        msg = params[0]
      }

      Log.d(tag.toString(), msg.toString())
//      println(PREFIX + "DEBUG: " + msg.toString())
    }
  }
  @JvmStatic
  fun i(vararg params: Any?) {
    var tag: Any?
    var msg: Any?
    if (isEnabled(Level.INFO)) {
      if (params.size > 1) {
        tag = params[0]
        msg = params[1]
        if (tag == null || tag.toString().isEmpty()) {
          tag = TAG
        }
      } else {
        tag = TAG
        msg = params[0]
      }

      Log.i(tag.toString(), msg.toString())
//      println(PREFIX + "INFO: " + msg.toString())
    }

  }
  @JvmStatic
  fun w(vararg params: Any?) {
    var tag: Any?
    var msg: Any?
    if (isEnabled(Level.WARN)) {
      if (params.size > 1) {
        tag = params[0]
        msg = params[1]
        if (tag == null || tag.toString().isEmpty()) {
          tag = TAG
        }
      } else {
        tag = TAG
        msg = params[0]
      }

      Log.w(tag.toString(), msg.toString())
//      println(PREFIX + "DEBUG: " + msg.toString())
    }
  }

  @JvmStatic
  fun e(vararg params: Any?) {
    var tag: Any? = TAG
    var msg: Any? = null
    var throwable: Throwable? = null
    if (isEnabled(Level.ERROR)) {
      if (params.size > 2) {
        tag = params[0]
        msg = params[1]
        throwable = params[2] as Throwable

      } else if (params.size > 1) {
        if(params[0] is String && params[1] is String) {
          tag = params[0]
          msg = params[1]
        } else if(params[0] is String && params[1] is Throwable) {
          tag = TAG
          msg = params[0]
          throwable = params[1] as Throwable
        }
      } else {
        msg = params[0]
      }

      Log.e(tag.toString(), msg.toString(), throwable)
    }
//    if (isEnabled(Level.ERROR)) {
//      Log.e(TAG, message, throwable)
//      println(PREFIX + "ERROR: " + message)
//      throwable?.printStackTrace()
//      if (throwable != null) {
//        val sw = StringWriter()
//        throwable.printStackTrace(PrintWriter(sw))
//        println(PREFIX + sw.toString())
//      }
//    }
  }
} // not instantiable
