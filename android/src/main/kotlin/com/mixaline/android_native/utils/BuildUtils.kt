package com.mixaline.android_native.utils

import android.os.Build

internal fun isAtLeastM(): Boolean {
  return Build.VERSION.SDK_INT >= Build.VERSION_CODES.M
}

internal fun isAtLeastO(): Boolean {
  return Build.VERSION.SDK_INT >= Build.VERSION_CODES.O
}

internal fun isAtLeastP(): Boolean {
  return Build.VERSION.SDK_INT >= Build.VERSION_CODES.P
}

internal fun isAtLeastKW(): Boolean {
  return Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT_WATCH
}

internal fun isPriorO(): Boolean {
  return Build.VERSION.SDK_INT < Build.VERSION_CODES.O
}

internal fun isPriorOMR1(): Boolean {
  return Build.VERSION.SDK_INT < Build.VERSION_CODES.O_MR1
}

internal fun isAtLeastN(): Boolean {
  return Build.VERSION.SDK_INT >= Build.VERSION_CODES.N
}
internal fun isAtLeastLMR1(): Boolean{
  return Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1
}
//internal fun isAtLeast(): Boolean{}

internal fun isAtLeastL(): Boolean {
  return Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP
}

internal fun isPriorL(): Boolean {
  return Build.VERSION.SDK_INT < Build.VERSION_CODES.LOLLIPOP
}

internal fun isPriorLMR1(): Boolean {
  return Build.VERSION.SDK_INT < Build.VERSION_CODES.LOLLIPOP_MR1
}


internal fun isPriorM(): Boolean {
  return Build.VERSION.SDK_INT < Build.VERSION_CODES.M
}

internal fun isAtLeastR(): Boolean {
  return Build.VERSION.SDK_INT >= Build.VERSION_CODES.R
}
