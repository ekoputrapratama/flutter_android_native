package com.mixaline.android_native.handlers

import android.content.Context
import android.media.AudioManager
import com.mixaline.android_native.utils.*
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class AudioManagerHandler(messageChannel: MethodChannel, eventChannel: EventChannel, private val context: Context) : BaseCallHandler(messageChannel,eventChannel) {

  private var audioManager: AudioManager? = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager?
  private var isHandling = false

  init {
    isHandling = true
  }

  private fun onSetStreamVolumeCall(call: MethodCall, result: MethodChannel.Result){
    val streamType = call.argument<Int>(PARAM_STREAM_TYPE)!!
    val volume = call.argument<Int>(PARAM_VOLUME)!!
    audioManager?.setStreamVolume(streamType, volume, 0)

    val currentVol = audioManager?.getStreamVolume(streamType)
    if(currentVol == volume) {
      result.success(true)
    } else {
      result.error("AudioManagerException", "cannot set stream volume for type $streamType to $volume", null)
    }
  }

  private fun onGetStreamVolumeCall(call: MethodCall, result: MethodChannel.Result) {
    val streamType = call.argument<Int>(PARAM_STREAM_TYPE)!!
    if(audioManager != null){
      val currentVolume = audioManager!!.getStreamVolume(streamType)
      result.success(currentVolume)
    } else {
      result.error("NullException", "cannot get AudioManager system service", null)
    }
  }

  private fun onGetStreamMaxVolumeCall(call: MethodCall, result: MethodChannel.Result) {
    val streamType = call.argument<Int>(PARAM_STREAM_TYPE)!!
    if(audioManager != null){
      val maxVolume = audioManager!!.getStreamMaxVolume(streamType)
      result.success(maxVolume)
    } else {
      result.error("NullException", "cannot get AudioManager system service", null)
    }
  }

  private fun onGetStreamMinVolumeCall(call: MethodCall, result: MethodChannel.Result) {
    val streamType = call.argument<Int>(PARAM_STREAM_TYPE)!!

    if(audioManager != null){
      if(isAtLeastP()) {
        val minVolume = audioManager!!.getStreamMinVolume(streamType)
        result.success(minVolume)
      } else {
        result.success(0)
      }
    } else {
      result.error("NullException", "cannot get AudioManager system service", null)
    }
  }

  private fun onIsMusicActiveCall(call: MethodCall, result: MethodChannel.Result) {
    if(audioManager == null) {
      result.error("NullException", "cannot get AudioManager system service", null)
      return
    }

    val isActive = audioManager!!.isMusicActive

    result.success(isActive)
  }

  override fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if(isHandling) {
      when (call.method) {
        METHOD_GET_STREAM_MAX_VOLUME -> {
          onGetStreamMaxVolumeCall(call, result)
        }
        METHOD_GET_STREAM_MIN_VOLUME -> {
          onGetStreamMinVolumeCall(call, result)
        }
        METHOD_GET_STREAM_VOLUME -> {
          onGetStreamVolumeCall(call, result)
        }
        METHOD_SET_STREAM_VOLUME -> {
          onSetStreamVolumeCall(call, result)
        }
        METHOD_IS_MUSIC_ACTIVE -> {
          onIsMusicActiveCall(call, result)
        }
      }
    }
  }

  override fun onDestroy() {
    isHandling = false
    audioManager = null
  }
}
