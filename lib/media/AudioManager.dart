import 'dart:async';

import 'package:android_native/android_native.dart';

const _GET_STREAM_MAX_VOLUME = "AudioManager.getStreamMaxVolume";
const _GET_STREAM_MIN_VOLUME = "AudioManager.getStreamMinVolume";
const _GET_STREAM_VOLUME = "AudioManager.getStreamVolume";
const _SET_STREAM_VOLUME = "AudioManager.setStreamVolume";
const _IS_MUSIC_ACTIVE = "AudioManager.isMusicActive";
const _PARAM_STREAM_TYPE = "streamType";
const _PARAM_VOLUME = "volume";

// abstract class StreamType {
//   static const int VOICE_CALL = 0;
//   static const int SYSTEM = 1;
//   static const int RING = 2;
//   static const int MUSIC = 3;
//   static const int ALARM = 4;
//   static const int NOTIFICATION = 5;
//   static const int ACCESSIBILITY = 10;
//   static const int DTMF = 8;
// }

class AudioManager with AndroidNativeObject {
  /// Broadcast intent, a hint for applications that audio is about to become
  /// 'noisy' due to a change in audio outputs. For example, this intent may
  /// be sent when a wired headset is unplugged, or when an A2DP audio
  /// sink is disconnected, and the audio system is about to automatically
  /// switch audio route to the speaker. Applications that are controlling
  /// audio streams may consider pausing, reducing volume or some other action
  /// on receipt of this intent so as not to surprise the user with audio
  /// from the speaker.
  static const String ACTION_AUDIO_BECOMING_NOISY =
      "android.media.AUDIO_BECOMING_NOISY";

  /// Sticky broadcast intent action indicating that the ringer mode has
  /// changed. Includes the new ringer mode.
  ///
  /// @see #EXTRA_RINGER_MODE
  static const String RINGER_MODE_CHANGED_ACTION =
      "android.media.RINGER_MODE_CHANGED";

  /// @hide
  /// Sticky broadcast intent action indicating that the internal ringer mode has
  /// changed. Includes the new ringer mode.
  ///
  /// @see #EXTRA_RINGER_MODE
  static const String INTERNAL_RINGER_MODE_CHANGED_ACTION =
      "android.media.INTERNAL_RINGER_MODE_CHANGED_ACTION";

  /// The new ringer mode.
  ///
  /// @see #RINGER_MODE_CHANGED_ACTION
  /// @see #RINGER_MODE_NORMAL
  /// @see #RINGER_MODE_SILENT
  /// @see #RINGER_MODE_VIBRATE
  static const String EXTRA_RINGER_MODE = "android.media.EXTRA_RINGER_MODE";

  /// Broadcast intent action indicating that the vibrate setting has
  /// changed. Includes the vibrate type and its new setting.
  ///
  /// @see #EXTRA_VIBRATE_TYPE
  /// @see #EXTRA_VIBRATE_SETTING
  /// @deprecated Applications should maintain their own vibrate policy based on
  /// current ringer mode and listen to {@link #RINGER_MODE_CHANGED_ACTION} instead.
  static const String VIBRATE_SETTING_CHANGED_ACTION =
      "android.media.VIBRATE_SETTING_CHANGED";

  /// @hide Broadcast intent when the volume for a particular stream type changes.
  /// Includes the stream, the new volume and previous volumes.
  /// Notes:
  ///  - for internal platform use only, do not make public,
  ///  - never used for "remote" volume changes
  ///
  /// @see #EXTRA_VOLUME_STREAM_TYPE
  /// @see #EXTRA_VOLUME_STREAM_VALUE
  /// @see #EXTRA_PREV_VOLUME_STREAM_VALUE
  static const String VOLUME_CHANGED_ACTION =
      "android.media.VOLUME_CHANGED_ACTION";

  /// @hide Broadcast intent when the devices for a particular stream type changes.
  /// Includes the stream, the new devices and previous devices.
  /// Notes:
  ///  - for internal platform use only, do not make public,
  ///  - never used for "remote" volume changes
  ///
  /// @see #EXTRA_VOLUME_STREAM_TYPE
  /// @see #EXTRA_VOLUME_STREAM_DEVICES
  /// @see #EXTRA_PREV_VOLUME_STREAM_DEVICES
  /// @see #getDevicesForStream
  static const String STREAM_DEVICES_CHANGED_ACTION =
      "android.media.STREAM_DEVICES_CHANGED_ACTION";

  /// @hide Broadcast intent when a stream mute state changes.
  /// Includes the stream that changed and the new mute state
  ///
  /// @see #EXTRA_VOLUME_STREAM_TYPE
  /// @see #EXTRA_STREAM_VOLUME_MUTED
  static const String STREAM_MUTE_CHANGED_ACTION =
      "android.media.STREAM_MUTE_CHANGED_ACTION";

  /// @hide Broadcast intent when the master mute state changes.
  /// Includes the the new volume
  ///
  /// @see #EXTRA_MASTER_VOLUME_MUTED
  static const String MASTER_MUTE_CHANGED_ACTION =
      "android.media.MASTER_MUTE_CHANGED_ACTION";

  /// The new vibrate setting for a particular type.
  ///
  /// @see #VIBRATE_SETTING_CHANGED_ACTION
  /// @see #EXTRA_VIBRATE_TYPE
  /// @see #VIBRATE_SETTING_ON
  /// @see #VIBRATE_SETTING_OFF
  /// @see #VIBRATE_SETTING_ONLY_SILENT
  /// @deprecated Applications should maintain their own vibrate policy based on
  /// current ringer mode and listen to {@link #RINGER_MODE_CHANGED_ACTION} instead.
  static const String EXTRA_VIBRATE_SETTING =
      "android.media.EXTRA_VIBRATE_SETTING";

  /// The vibrate type whose setting has changed.
  ///
  /// @see #VIBRATE_SETTING_CHANGED_ACTION
  /// @see #VIBRATE_TYPE_NOTIFICATION
  /// @see #VIBRATE_TYPE_RINGER
  /// @deprecated Applications should maintain their own vibrate policy based on
  /// current ringer mode and listen to {@link #RINGER_MODE_CHANGED_ACTION} instead.
  static const String EXTRA_VIBRATE_TYPE = "android.media.EXTRA_VIBRATE_TYPE";

  /// @hide The stream type for the volume changed intent.
  static const String EXTRA_VOLUME_STREAM_TYPE =
      "android.media.EXTRA_VOLUME_STREAM_TYPE";

  /// @hide
  /// The stream type alias for the volume changed intent.
  /// For instance the intent may indicate a change of the {@link #STREAM_NOTIFICATION} stream
  /// type (as indicated by the {@link #EXTRA_VOLUME_STREAM_TYPE} extra), but this is also
  /// reflected by a change of the volume of its alias, {@link #STREAM_RING} on some devices,
  /// {@link #STREAM_MUSIC} on others (e.g. a television).
  static const String EXTRA_VOLUME_STREAM_TYPE_ALIAS =
      "android.media.EXTRA_VOLUME_STREAM_TYPE_ALIAS";

  /// @hide The volume associated with the stream for the volume changed intent.
  static const String EXTRA_VOLUME_STREAM_VALUE =
      "android.media.EXTRA_VOLUME_STREAM_VALUE";

  /// @hide The previous volume associated with the stream for the volume changed intent.
  static const String EXTRA_PREV_VOLUME_STREAM_VALUE =
      "android.media.EXTRA_PREV_VOLUME_STREAM_VALUE";

  /// @hide The devices associated with the stream for the stream devices changed intent.
  static const String EXTRA_VOLUME_STREAM_DEVICES =
      "android.media.EXTRA_VOLUME_STREAM_DEVICES";

  /// @hide The previous devices associated with the stream for the stream devices changed intent.
  static const String EXTRA_PREV_VOLUME_STREAM_DEVICES =
      "android.media.EXTRA_PREV_VOLUME_STREAM_DEVICES";

  /// @hide The new master volume mute state for the master mute changed intent.
  /// Value is boolean
  static const String EXTRA_MASTER_VOLUME_MUTED =
      "android.media.EXTRA_MASTER_VOLUME_MUTED";

  /// @hide The new stream volume mute state for the stream mute changed intent.
  /// Value is boolean
  static const String EXTRA_STREAM_VOLUME_MUTED =
      "android.media.EXTRA_STREAM_VOLUME_MUTED";

  /// Broadcast Action: Wired Headset plugged in or unplugged.
  ///
  /// You <em>cannot</em> receive this through components declared
  /// in manifests, only by explicitly registering for it with
  /// {@link Context#registerReceiver(BroadcastReceiver, IntentFilter)
  /// Context.registerReceiver()}.
  ///
  /// <p>The intent will have the following extra values:
  /// <ul>
  ///   <li><em>state</em> - 0 for unplugged, 1 for plugged. </li>
  ///   <li><em>name</em> - Headset type, human readable string </li>
  ///   <li><em>microphone</em> - 1 if headset has a microphone, 0 otherwise </li>
  /// </ul>
  /// </ul>
  static const String ACTION_HEADSET_PLUG =
      "android.intent.action.HEADSET_PLUG";

  /// Broadcast Action: A sticky broadcast indicating an HDMI cable was plugged or unplugged.
  ///
  /// The intent will have the following extra values: {@link #EXTRA_AUDIO_PLUG_STATE},
  /// {@link #EXTRA_MAX_CHANNEL_COUNT}, {@link #EXTRA_ENCODINGS}.
  /// <p>It can only be received by explicitly registering for it with
  /// {@link Context#registerReceiver(BroadcastReceiver, IntentFilter)}.
  static const String ACTION_HDMI_AUDIO_PLUG =
      "android.media.action.HDMI_AUDIO_PLUG";

  /// Extra used in {@link #ACTION_HDMI_AUDIO_PLUG} to communicate whether HDMI is plugged in
  /// or unplugged.
  /// An integer value of 1 indicates a plugged-in state, 0 is unplugged.
  static const String EXTRA_AUDIO_PLUG_STATE =
      "android.media.extra.AUDIO_PLUG_STATE";

  /// Extra used in {@link #ACTION_HDMI_AUDIO_PLUG} to define the maximum number of channels
  /// supported by the HDMI device.
  /// The corresponding integer value is only available when the device is plugged in (as expressed
  /// by {@link #EXTRA_AUDIO_PLUG_STATE}).
  static const String EXTRA_MAX_CHANNEL_COUNT =
      "android.media.extra.MAX_CHANNEL_COUNT";

  /// Extra used in {@link #ACTION_HDMI_AUDIO_PLUG} to define the audio encodings supported by
  /// the connected HDMI device.
  /// The corresponding array of encoding values is only available when the device is plugged in
  /// (as expressed by {@link #EXTRA_AUDIO_PLUG_STATE}). Encoding values are defined in
  /// {@link AudioFormat} (for instance see {@link AudioFormat#ENCODING_PCM_16BIT}). Use
  /// {@link android.content.Intent#getIntArrayExtra(String)} to retrieve the encoding values.
  static const String EXTRA_ENCODINGS = "android.media.extra.ENCODINGS";

  /// The audio stream for phone calls */
  static const int STREAM_VOICE_CALL = 0;

  /// The audio stream for system sounds */
  static const int STREAM_SYSTEM = 1;

  /// The audio stream for the phone ring */
  static const int STREAM_RING = 2;

  /// The audio stream for music playback */
  static const int STREAM_MUSIC = 3;

  /// The audio stream for alarms */
  static const int STREAM_ALARM = 4;

  /// The audio stream for notifications */
  static const int STREAM_NOTIFICATION = 5;

  /// @hide The audio stream for phone calls when connected to bluetooth */
  static const int STREAM_BLUETOOTH_SCO = 6;

  /// @hide The audio stream for enforced system sounds in certain countries (e.g camera in Japan) */
  static const int STREAM_SYSTEM_ENFORCED = 7;

  /// The audio stream for DTMF Tones */
  static const int STREAM_DTMF = 8;

  /// @hide The audio stream for text to speech (TTS) */
  static const int STREAM_TTS = 9;

  /// Used to identify the volume of audio streams for accessibility prompts */
  static const int STREAM_ACCESSIBILITY = 10;

  /// Increase the ringer volume.
  ///
  /// @see #adjustVolume(int, int)
  /// @see #adjustStreamVolume(int, int, int)
  static const int ADJUST_RAISE = 1;

  /// Decrease the ringer volume.
  ///
  /// @see #adjustVolume(int, int)
  /// @see #adjustStreamVolume(int, int, int)
  static const int ADJUST_LOWER = -1;

  /// Maintain the previous ringer volume. This may be useful when needing to
  /// show the volume toast without actually modifying the volume.
  ///
  /// @see #adjustVolume(int, int)
  /// @see #adjustStreamVolume(int, int, int)
  static const int ADJUST_SAME = 0;
  // Flags should be powers of 2!
  /// Show a toast containing the current volume.
  ///
  /// @see #adjustStreamVolume(int, int, int)
  /// @see #adjustVolume(int, int)
  /// @see #setStreamVolume(int, int, int)
  /// @see #setRingerMode(int)
  static const int FLAG_SHOW_UI = 1 << 0;

  /// Whether to include ringer modes as possible options when changing volume.
  /// For example, if true and volume level is 0 and the volume is adjusted
  /// with {@link #ADJUST_LOWER}, then the ringer mode may switch the silent or
  /// vibrate mode.
  /// <p>
  /// By default this is on for the ring stream. If this flag is included,
  /// this behavior will be present regardless of the stream type being
  /// affected by the ringer mode.
  ///
  /// @see #adjustVolume(int, int)
  /// @see #adjustStreamVolume(int, int, int)
  static const int FLAG_ALLOW_RINGER_MODES = 1 << 1;

  /// Whether to play a sound when changing the volume.
  /// <p>
  /// If this is given to {@link #adjustVolume(int, int)} or
  /// {@link #adjustSuggestedStreamVolume(int, int, int)}, it may be ignored
  /// in some cases (for example, the decided stream type is not
  /// {@link AudioManager#STREAM_RING}, or the volume is being adjusted
  /// downward).
  ///
  /// @see #adjustStreamVolume(int, int, int)
  /// @see #adjustVolume(int, int)
  /// @see #setStreamVolume(int, int, int)
  static const int FLAG_PLAY_SOUND = 1 << 2;

  /// Removes any sounds/vibrate that may be in the queue, or are playing (related to
  /// changing volume).
  static const int FLAG_REMOVE_SOUND_AND_VIBRATE = 1 << 3;

  /// Whether to vibrate if going into the vibrate ringer mode.
  static const int FLAG_VIBRATE = 1 << 4;

  /// Indicates to VolumePanel that the volume slider should be disabled as user
  /// cannot change the stream volume
  /// @hide
  static const int FLAG_FIXED_VOLUME = 1 << 5;

  /// Indicates the volume set/adjust call is for Bluetooth absolute volume
  /// @hide
  static const int FLAG_BLUETOOTH_ABS_VOLUME = 1 << 6;

  /// Adjusting the volume was prevented due to silent mode, display a hint in the UI.
  /// @hide
  static const int FLAG_SHOW_SILENT_HINT = 1 << 7;

  /// Indicates the volume call is for Hdmi Cec system audio volume
  /// @hide
  static const int FLAG_HDMI_SYSTEM_AUDIO_VOLUME = 1 << 8;

  /// Indicates that this should only be handled if media is actively playing.
  /// @hide
  static const int FLAG_ACTIVE_MEDIA_ONLY = 1 << 9;

  /// Like FLAG_SHOW_UI, but only dialog warnings and confirmations, no sliders.
  /// @hide
  static const int FLAG_SHOW_UI_WARNINGS = 1 << 10;

  /// Adjusting the volume down from vibrated was prevented, display a hint in the UI.
  /// @hide
  static const int FLAG_SHOW_VIBRATE_HINT = 1 << 11;

  /// Adjusting the volume due to a hardware key press.
  /// @hide
  static const int FLAG_FROM_KEY = 1 << 12;

  /// Ringer mode that will be silent and will not vibrate. (This overrides the
  /// vibrate setting.)
  ///
  /// @see #setRingerMode(int)
  /// @see #getRingerMode()
  static const int RINGER_MODE_SILENT = 0;

  /// Ringer mode that will be silent and will vibrate. (This will cause the
  /// phone ringer to always vibrate, but the notification vibrate to only
  /// vibrate if set.)
  ///
  /// @see #setRingerMode(int)
  /// @see #getRingerMode()
  static const int RINGER_MODE_VIBRATE = 1;

  /// Ringer mode that may be audible and may vibrate. It will be audible if
  /// the volume before changing out of this mode was audible. It will vibrate
  /// if the vibrate setting is on.
  ///
  /// @see #setRingerMode(int)
  /// @see #getRingerMode()
  static const int RINGER_MODE_NORMAL = 2;
  // maximum valid ringer mode value. Values must start from 0 and be contiguous.
  static const int RINGER_MODE_MAX = RINGER_MODE_NORMAL;

  /// Vibrate type that corresponds to the ringer.
  ///
  /// @see #setVibrateSetting(int, int)
  /// @see #getVibrateSetting(int)
  /// @see #shouldVibrate(int)
  /// @deprecated Applications should maintain their own vibrate policy based on
  /// current ringer mode that can be queried via {@link #getRingerMode()}.
  static const int VIBRATE_TYPE_RINGER = 0;

  /// Vibrate type that corresponds to notifications.
  ///
  /// @see #setVibrateSetting(int, int)
  /// @see #getVibrateSetting(int)
  /// @see #shouldVibrate(int)
  /// @deprecated Applications should maintain their own vibrate policy based on
  /// current ringer mode that can be queried via {@link #getRingerMode()}.
  static const int VIBRATE_TYPE_NOTIFICATION = 1;

  /// Vibrate setting that suggests to never vibrate.
  ///
  /// @see #setVibrateSetting(int, int)
  /// @see #getVibrateSetting(int)
  /// @deprecated Applications should maintain their own vibrate policy based on
  /// current ringer mode that can be queried via {@link #getRingerMode()}.
  static const int VIBRATE_SETTING_OFF = 0;

  /// Vibrate setting that suggests to vibrate when possible.
  ///
  /// @see #setVibrateSetting(int, int)
  /// @see #getVibrateSetting(int)
  /// @deprecated Applications should maintain their own vibrate policy based on
  /// current ringer mode that can be queried via {@link #getRingerMode()}.
  static const int VIBRATE_SETTING_ON = 1;

  /// Vibrate setting that suggests to only vibrate when in the vibrate ringer
  /// mode.
  ///
  /// @see #setVibrateSetting(int, int)
  /// @see #getVibrateSetting(int)
  /// @deprecated Applications should maintain their own vibrate policy based on
  /// current ringer mode that can be queried via {@link #getRingerMode()}.
  static const int VIBRATE_SETTING_ONLY_SILENT = 2;

  /// Suggests using the default stream type. This may not be used in all
  /// places a stream type is needed.
  static const int USE_DEFAULT_STREAM_TYPE = -2147483648;

  /// Checks valid ringer mode values.
  ///
  /// @return true if the ringer mode indicated is valid, false otherwise.
  ///
  /// @see #setRingerMode(int)
  /// @hide
  static bool isValidRingerMode(int ringerMode) {
    if (ringerMode < 0 || ringerMode > RINGER_MODE_MAX) {
      return false;
    }
    return true;
  }

  /// Adjusts the volume of a particular stream by one step in a direction.
  /// <p>
  /// This method should only be used by applications that replace the platform-wide
  /// management of audio settings or the main telephony application.
  ///
  /// @param streamType The stream type to adjust. One of {@link #STREAM_VOICE_CALL},
  /// {@link #STREAM_SYSTEM}, {@link #STREAM_RING}, {@link #STREAM_MUSIC} or
  /// {@link #STREAM_ALARM}
  /// @param direction The direction to adjust the volume. One of
  ///            {@link #ADJUST_LOWER}, {@link #ADJUST_RAISE}, or
  ///            {@link #ADJUST_SAME}.
  /// @param flags One or more flags.
  /// @see #adjustVolume(int, int)
  /// @see #setStreamVolume(int, int, int)
  Future<void> adjustStreamVolume(
      int streamType, int direction, int flags) async {}

  /// Adjusts the volume of the most relevant stream. For example, if a call is
  /// active, it will have the highest priority regardless of if the in-call
  /// screen is showing. Another example, if music is playing in the background
  /// and a call is not active, the music stream will be adjusted.
  /// <p>
  /// This method should only be used by applications that replace the platform-wide
  /// management of audio settings or the main telephony application.
  ///
  /// @param direction The direction to adjust the volume. One of
  ///            {@link #ADJUST_LOWER}, {@link #ADJUST_RAISE}, or
  ///            {@link #ADJUST_SAME}.
  /// @param flags One or more flags.
  /// @see #adjustSuggestedStreamVolume(int, int, int)
  /// @see #adjustStreamVolume(int, int, int)
  /// @see #setStreamVolume(int, int, int)
  Future adjustVolume(int direction, int flags) async {}

  /// Adjusts the volume of the most relevant stream, or the given fallback
  /// stream.
  /// <p>
  /// This method should only be used by applications that replace the platform-wide
  /// management of audio settings or the main telephony application.
  ///
  /// @param direction The direction to adjust the volume. One of
  ///            {@link #ADJUST_LOWER}, {@link #ADJUST_RAISE}, or
  ///            {@link #ADJUST_SAME}.
  /// @param suggestedStreamType The stream type that will be used if there
  ///            isn't a relevant stream. {@link #USE_DEFAULT_STREAM_TYPE} is valid here.
  /// @param flags One or more flags.
  /// @see #adjustVolume(int, int)
  /// @see #adjustStreamVolume(int, int, int)
  /// @see #setStreamVolume(int, int, int)
  Future adjustSuggestedStreamVolume(
      int direction, int suggestedStreamType, int flags) async {}

  /// Adjusts the master volume for the device's audio amplifier.
  /// <p>
  ///
  /// @param steps The number of volume steps to adjust. A positive
  ///            value will raise the volume.
  /// @param flags One or more flags.
  /// @hide
  Future adjustMasterVolume(int steps, int flags) async {}

  /// Returns the current ringtone mode.
  ///
  /// @return The current ringtone mode, one of {@link #RINGER_MODE_NORMAL},
  ///         {@link #RINGER_MODE_SILENT}, or {@link #RINGER_MODE_VIBRATE}.
  /// @see #setRingerMode(int)
  // Future<int> getRingerMode() async {
  //   return invokeMethod<int>(_GET_RINGER_MODE, null);
  // }

  /// Get last audible volume before stream was muted.
  ///
  /// @hide
  // Future<int> getLastAudibleStreamVolume(int streamType) async {}

  /// Get the stream type whose volume is driving the UI sounds volume.
  /// UI sounds are screen lock/unlock, camera shutter, key clicks...
  /// @hide
  // Future<int> getMasterStreamType() async {}

  /// Sets the ringer mode.
  /// <p>
  /// Silent mode will mute the volume and will not vibrate. Vibrate mode will
  /// mute the volume and vibrate. Normal mode will be audible and may vibrate
  /// according to user settings.
  ///
  /// @param ringerMode The ringer mode, one of {@link #RINGER_MODE_NORMAL},
  ///            {@link #RINGER_MODE_SILENT}, or {@link #RINGER_MODE_VIBRATE}.
  /// @see #getRingerMode()
  // Future setRingerMode(int ringerMode) async {}

  /// Returns the maximum volume index for master volume.
  ///
  /// @hide
  // Future<int> getMasterMaxVolume() async {}

  /// Returns the current volume index for master volume.
  ///
  /// @return The current volume index for master volume.
  /// @hide
  // Future<int> getMasterVolume() async {}

  /// Get last audible volume before master volume was muted.
  ///
  /// @hide
  // Future<int> getLastAudibleMasterVolume() async {}

  /// Sets the volume index for master volume.
  ///
  /// @param index The volume index to set. See
  ///            {@link #getMasterMaxVolume()} for the largest valid value.
  /// @param flags One or more flags.
  /// @see #getMasterMaxVolume()
  /// @see #getMasterVolume()
  /// @hide
  Future setMasterVolume(int index, int flags) async {}

  /// Solo or unsolo a particular stream. All other streams are muted.
  /// <p>
  /// The solo command is protected against client process death: if a process
  /// with an active solo request on a stream dies, all streams that were muted
  /// because of this request will be unmuted automatically.
  /// <p>
  /// The solo requests for a given stream are cumulative: the AudioManager
  /// can receive several solo requests from one or more clients and the stream
  /// will be unsoloed only when the same number of unsolo requests are received.
  /// <p>
  /// For a better user experience, applications MUST unsolo a soloed stream
  /// in onPause() and solo is again in onResume() if appropriate.
  ///
  /// @param streamType The stream to be soloed/unsoloed.
  /// @param state The required solo state: true for solo ON, false for solo OFF
  Future setStreamSolo(int streamType, bool state) async {}

  /// Mute or unmute an audio stream.
  /// <p>
  /// The mute command is protected against client process death: if a process
  /// with an active mute request on a stream dies, this stream will be unmuted
  /// automatically.
  /// <p>
  /// The mute requests for a given stream are cumulative: the AudioManager
  /// can receive several mute requests from one or more clients and the stream
  /// will be unmuted only when the same number of unmute requests are received.
  /// <p>
  /// For a better user experience, applications MUST unmute a muted stream
  /// in onPause() and mute is again in onResume() if appropriate.
  /// <p>
  /// This method should only be used by applications that replace the platform-wide
  /// management of audio settings or the main telephony application.
  ///
  /// @param streamType The stream to be muted/unmuted.
  /// @param state The required mute state: true for mute ON, false for mute OFF
  Future setStreamMute(int streamType, bool state) async {}

  /// Returns the maximum volume index for a particular stream.
  ///
  /// @param streamType The stream type whose maximum volume index is returned.
  /// @return The maximum valid volume index for the stream.
  /// @see #getStreamVolume(int)
  Future<int> getStreamMaxVolume(int streamType) async {
    var args = Map();
    args[_PARAM_STREAM_TYPE] = streamType;
    var volume = await channel.invokeMethod(_GET_STREAM_MAX_VOLUME, args);

    return volume;
  }

  /// Returns the current volume index for a particular stream.
  ///
  /// @param streamType The stream type whose volume index is returned.
  /// @return The current volume index for the stream.
  /// @see #getStreamMaxVolume(int)
  /// @see #setStreamVolume(int, int, int)
  Future<int> getStreamVolume(int streamType) async {
    var args = Map();
    args[_PARAM_STREAM_TYPE] = streamType;
    var volume = await channel.invokeMethod(_GET_STREAM_VOLUME, args);

    return volume;
  }

  Future<int> getStreamMinVolume(int streamType) async {
    var args = Map();
    args[_PARAM_STREAM_TYPE] = streamType;
    var volume = await channel.invokeMethod(_GET_STREAM_MIN_VOLUME, args);

    return volume;
  }

  Future setStreamVolume(int streamType, int value) async {
    var args = Map();
    args[_PARAM_STREAM_TYPE] = streamType;
    args[_PARAM_VOLUME] = value;
    var success = await channel.invokeMethod(_SET_STREAM_VOLUME, args);

    return success;
  }

  Future<bool> isMusicActive() async {
    var isActive = await channel.invokeMethod(_IS_MUSIC_ACTIVE) as bool;

    return isActive;
  }
}
