package com.mixaline.android_native.utils

import android.graphics.*
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.os.Build
import android.util.Base64

import java.io.ByteArrayOutputStream

fun encodeToBase64(image: Bitmap?, compressFormat: Bitmap.CompressFormat, quality: Int): String? {
  if(image == null) return null
  val byteArrayOutputStream = ByteArrayOutputStream()
  image.compress(compressFormat, quality, byteArrayOutputStream)
  val byteArray = byteArrayOutputStream.toByteArray()

  return Base64.encodeToString(byteArray, Base64.NO_WRAP)
}

fun renderDrawableToBitmap(
  d: Drawable?,
  bitmap: Bitmap?,
  x: Int,
  y: Int,
  w: Int,
  h: Int,
  alpha: Int = 255
) {
  if (bitmap != null) {
    val c = Canvas(bitmap)
    val oldBounds = d!!.copyBounds()
    var oldAlpha = 0
    if (Build.VERSION.SDK_INT >= 19) {
      oldAlpha = d.alpha
      d.alpha = alpha
    }
    d.setBounds(x, y, x + w, y + h)

    d.draw(c)
    d.bounds = oldBounds // Restore the bounds
    if (Build.VERSION.SDK_INT >= 19) {
      d.alpha = oldAlpha
    }
    c.setBitmap(null)

  }
}

fun drawableToBitmap(drawable: Drawable?): Bitmap? {
  if (drawable == null) {
    return null
  }

  if (drawable is BitmapDrawable) {
    val bitmapDrawable = drawable as BitmapDrawable?
    if (bitmapDrawable!!.bitmap != null) {
      return bitmapDrawable.bitmap
    }
  }

  val bitmap: Bitmap
  if (drawable.intrinsicWidth <= 0 || drawable.intrinsicHeight <= 0) {
    // single color bitmap will be created
    bitmap = Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888)
  } else {
    bitmap = Bitmap.createBitmap(
      drawable.intrinsicWidth,
      drawable.intrinsicHeight,
      Bitmap.Config.ARGB_8888
    )
  }

  val canvas = Canvas(bitmap)
  drawable.setBounds(0, 0, drawable.intrinsicWidth, drawable.intrinsicHeight)
  drawable.draw(canvas)

  return bitmap
}
