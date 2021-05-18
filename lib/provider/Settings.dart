import 'package:android_native/android_native.dart';

// ignore_for_file: non_constant_identifier_names
const _SYSTEM_CAN_WRITE = "Settings.System.canWrite";
const _SYSTEM_PUT_STRING = "Settings.System.putString";
const _SYSTEM_GET_STRING = "Settings.System.getString";
const _SYSTEM_PUT_INT = "Settings.System.putInt";
const _SYSTEM_GET_INT = "Settings.System.getInt";

const _SECURE_CAN_WRITE = "Settings.Secure.canWrite";
const _SECURE_PUT_STRING = "Settings.Secure.putString";
const _SECURE_GET_STRING = "Settings.Secure.getString";
const _SECURE_PUT_INT = "Settings.Secure.putInt";
const _SECURE_GET_INT = "Settings.Secure.getInt";

const _GLOBAL_PUT_STRING = "Settings.Global.putString";
const _GLOBAL_GET_STRING = "Settings.Global.getString";
const _GLOBAL_PUT_INT = "Settings.Global.putInt";
const _GLOBAL_GET_INT = "Settings.Global.getInt";

class _SystemSettings with AndroidNativeObject {
  var SCREEN_BRIGHTNESS = "screen_brightness";
  var SCREEN_BRIGHTNESS_MODE = "screen_brightness_mode";
  var SCREEN_BRIGHTNESS_MODE_AUTOMATIC = 1;
  var SCREEN_BRIGHTNESS_MODE_MANUAL = 0;
  var SOUND_EFFECTS_ENABLED = "sound_effects_enabled";

  Uri CONTENT_URI = Uri.parse("content://" + Settings.AUTHORITY + "/system");

  Future<bool> canWrite() async {
    return await channel.invokeMethod(_SYSTEM_CAN_WRITE) as bool;
  }

  void putString(String key, String value) {
    channel.invokeMethod(_SYSTEM_PUT_STRING, {"key": key, "value": value});
  }

  Future<String?> getString(String key) async {
    return channel.invokeMethod(_SYSTEM_GET_STRING, {"key": key})
        as Future<String?>;
  }

  Future putInt(String key, int value) async {
    return await channel
        .invokeMethod(_SYSTEM_PUT_INT, {"key": key, "value": value});
  }

  Future<int> getInt(String key) async {
    return await channel.invokeMethod(_SYSTEM_GET_INT, {"key": key}) as int;
  }

  Uri getUriFor(String columnName) {
    return Uri.parse("content://${Settings.AUTHORITY}/system/$columnName");
  }
}

class _SecureSettings with AndroidNativeObject {
  var ENABLED_ACCESSIBILITY_SERVICES = "enabled_accessibility_services";
  var ENABLED_INPUT_METHODS = "enabled_input_methods";
  var INSTALL_NON_MARKET_APPS = "install_non_market_apps";
  var ACCESSIBILITY_ENABLED = "accessibility_enabled";

  Future<bool> canWrite() async {
    return channel.invokeMethod(_SECURE_CAN_WRITE) as Future<bool>;
  }

  void putString(String key, String value) {
    channel.invokeMethod(_SECURE_PUT_STRING, {"key": key, "value": value});
  }

  Future<String?> getString(String key) async {
    return await channel.invokeMethod(_SECURE_GET_STRING, {"key": key});
  }

  void putInt(String key, int value) {
    channel.invokeMethod(_SECURE_PUT_INT, {"key": key, "value": value});
  }

  Future<int> getInt(String key) async {
    return channel.invokeMethod(_SECURE_GET_INT, {"key": key}) as Future<int>;
  }
}

class _GlobalSettings with AndroidNativeObject {
  var ADB_ENABLED = "adb_enabled";
  var INSTALL_NON_MARKET_APPS = "install_non_market_apps";
  var DEVICE_NAME = "device_name";
  var DEVICE_PROVISIONED = "device_provisioned";
  var BLUETOOTH_ON = "bluetooth_on";

  void putString(String key, String value) {
    channel.invokeMethod(_GLOBAL_PUT_STRING, {"key": key, "value": value});
  }

  Future<String> getString(String key) async {
    return channel.invokeMethod(_GLOBAL_GET_STRING, {"key": key})
        as Future<String>;
  }

  void putInt(String key, int value) {
    channel.invokeMethod(_GLOBAL_PUT_INT, {"key": key, "value": value});
  }

  Future<int> getInt(String key) async {
    return channel.invokeMethod(_GLOBAL_GET_INT, {"key": key}) as Future<int>;
  }
}

class Settings {
  // Intent actions for Settings

  /// Activity Action: Show system settings.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  static const String ACTION_SETTINGS = "android.settings.SETTINGS";

  /// Activity Action: Show settings to allow configuration of APNs.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  ///
  /// <p class="note">
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  static const String ACTION_APN_SETTINGS = "android.settings.APN_SETTINGS";

  /// Activity Action: Show settings to allow configuration of current location
  /// sources.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  static const String ACTION_LOCATION_SOURCE_SETTINGS =
      "android.settings.LOCATION_SOURCE_SETTINGS";

  /// Activity Action: Show scanning settings to allow configuration of Wi-Fi
  /// and Bluetooth scanning settings.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  /// @hide
  static const String ACTION_LOCATION_SCANNING_SETTINGS =
      "android.settings.LOCATION_SCANNING_SETTINGS";

  /// Activity Action: Show settings to allow configuration of users.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  /// @hide
  static const String ACTION_USER_SETTINGS = "android.settings.USER_SETTINGS";

  /// Activity Action: Show settings to allow configuration of wireless controls
  /// such as Wi-Fi, Bluetooth and Mobile networks.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  static const String ACTION_WIRELESS_SETTINGS =
      "android.settings.WIRELESS_SETTINGS";

  /// Activity Action: Show tether provisioning activity.
  ///
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: {@link ConnectivityManager#EXTRA_TETHER_TYPE} should be included to specify which type
  /// of tethering should be checked. {@link ConnectivityManager#EXTRA_PROVISION_CALLBACK} should
  /// contain a {@link ResultReceiver} which will be called back with a tether result code.
  /// <p>
  /// Output: The result of the provisioning check.
  /// {@link ConnectivityManager#TETHER_ERROR_NO_ERROR} if successful,
  /// {@link ConnectivityManager#TETHER_ERROR_PROVISION_FAILED} for failure.
  ///
  /// @hide
  static const String ACTION_TETHER_PROVISIONING =
      "android.settings.TETHER_PROVISIONING_UI";

  /// Activity Action: Show settings to allow entering/exiting airplane mode.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  static const String ACTION_AIRPLANE_MODE_SETTINGS =
      "android.settings.AIRPLANE_MODE_SETTINGS";

  /// Activity Action: Show mobile data usage list.
  /// <p>
  /// Input: {@link EXTRA_NETWORK_TEMPLATE} and {@link EXTRA_SUB_ID} should be included to specify
  /// how and what mobile data statistics should be collected.
  /// <p>
  /// Output: Nothing
  /// @hide
  static const String ACTION_MOBILE_DATA_USAGE =
      "android.settings.MOBILE_DATA_USAGE";

  /// Activity Action: Modify Airplane mode settings using a voice command.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you safeguard against this.
  /// <p>
  /// This intent MUST be started using
  /// {@link android.service.voice.VoiceInteractionSession#startVoiceActivity
  /// startVoiceActivity}.
  /// <p>
  /// Note: The activity implementing this intent MUST verify that
  /// {@link android.app.Activity#isVoiceInteraction isVoiceInteraction} returns true before
  /// modifying the setting.
  /// <p>
  /// Input: To tell which state airplane mode should be set to, add the
  /// {@link #EXTRA_AIRPLANE_MODE_ENABLED} extra to this Intent with the state specified.
  /// If the extra is not included, no changes will be made.
  /// <p>
  /// Output: Nothing.
  static final String ACTION_VOICE_CONTROL_AIRPLANE_MODE =
      "android.settings.VOICE_CONTROL_AIRPLANE_MODE";

  /// Activity Action: Show settings for accessibility modules.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_ACCESSIBILITY_SETTINGS =
      "android.settings.ACCESSIBILITY_SETTINGS";

  /// Activity Action: Show settings to control access to usage information.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_USAGE_ACCESS_SETTINGS =
      "android.settings.USAGE_ACCESS_SETTINGS";

  /// Activity Category: Show application settings related to usage access.
  /// <p>
  /// An activity that provides a user interface for adjusting usage access related
  /// preferences for its containing application. Optional but recommended for apps that
  /// use {@link android.Manifest.permission#PACKAGE_USAGE_STATS}.
  /// <p>
  /// The activity may define meta-data to describe what usage access is
  /// used for within their app with {@link #METADATA_USAGE_ACCESS_REASON}, which
  /// will be displayed in Settings.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String INTENT_CATEGORY_USAGE_ACCESS_CONFIG =
      "android.intent.category.USAGE_ACCESS_CONFIG";

  /// Metadata key: Reason for needing usage access.
  /// <p>
  /// A key for metadata attached to an activity that receives action
  /// {@link #INTENT_CATEGORY_USAGE_ACCESS_CONFIG}, shown to the
  /// user as description of how the app uses usage access.
  /// <p>
  static const String METADATA_USAGE_ACCESS_REASON =
      "android.settings.metadata.USAGE_ACCESS_REASON";

  /// Activity Action: Show settings to allow configuration of security and
  /// location privacy.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_SECURITY_SETTINGS =
      "android.settings.SECURITY_SETTINGS";

  /// Activity Action: Show settings to allow configuration of trusted external sources
  ///
  /// Input: Optionally, the Intent's data URI can specify the application package name to
  /// directly invoke the management GUI specific to the package name. For example
  /// "package:com.my.app".
  /// <p>
  /// Output: Nothing.

  static const String ACTION_MANAGE_UNKNOWN_APP_SOURCES =
      "android.settings.MANAGE_UNKNOWN_APP_SOURCES";

  /// Activity Action: Show trusted credentials settings, opening to the user tab,
  /// to allow management of installed credentials.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  /// @hide

  static const String ACTION_TRUSTED_CREDENTIALS_USER =
      "com.android.settings.TRUSTED_CREDENTIALS_USER";

  /// Activity Action: Show dialog explaining that an installed CA cert may enable
  /// monitoring of encrypted network traffic.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this. Add {@link #EXTRA_NUMBER_OF_CERTIFICATES} extra to indicate the
  /// number of certificates.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  /// @hide

  static const String ACTION_MONITORING_CERT_INFO =
      "com.android.settings.MONITORING_CERT_INFO";

  /// Activity Action: Show settings to allow configuration of privacy options.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_PRIVACY_SETTINGS =
      "android.settings.PRIVACY_SETTINGS";

  /// Activity Action: Show settings to allow configuration of VPN.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_VPN_SETTINGS = "android.settings.VPN_SETTINGS";

  /// Activity Action: Show settings to allow configuration of Wi-Fi.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_WIFI_SETTINGS = "android.settings.WIFI_SETTINGS";

  /// Activity Action: Show settings to allow configuration of a static IP
  /// address for Wi-Fi.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you safeguard
  /// against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_WIFI_IP_SETTINGS =
      "android.settings.WIFI_IP_SETTINGS";

  /// Activity Action: Show settings to allow configuration of data and view data usage.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_DATA_USAGE_SETTINGS =
      "android.settings.DATA_USAGE_SETTINGS";

  /// Activity Action: Show settings to allow configuration of Bluetooth.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_BLUETOOTH_SETTINGS =
      "android.settings.BLUETOOTH_SETTINGS";

  /// Activity Action: Show settings to allow configuration of Assist Gesture.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  /// @hide

  static const String ACTION_ASSIST_GESTURE_SETTINGS =
      "android.settings.ASSIST_GESTURE_SETTINGS";

  /// Activity Action: Show settings to enroll fingerprints, and setup PIN/Pattern/Pass if
  /// necessary.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_FINGERPRINT_ENROLL =
      "android.settings.FINGERPRINT_ENROLL";

  /// Activity Action: Show settings to allow configuration of cast endpoints.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_CAST_SETTINGS = "android.settings.CAST_SETTINGS";

  /// Activity Action: Show settings to allow configuration of date and time.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_DATE_SETTINGS = "android.settings.DATE_SETTINGS";

  /// Activity Action: Show settings to allow configuration of sound and volume.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_SOUND_SETTINGS = "android.settings.SOUND_SETTINGS";

  /// Activity Action: Show settings to allow configuration of display.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_DISPLAY_SETTINGS =
      "android.settings.DISPLAY_SETTINGS";

  /// Activity Action: Show settings to allow configuration of Night display.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_NIGHT_DISPLAY_SETTINGS =
      "android.settings.NIGHT_DISPLAY_SETTINGS";

  /// Activity Action: Show settings to allow configuration of locale.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_LOCALE_SETTINGS =
      "android.settings.LOCALE_SETTINGS";

  /// Activity Action: Show settings to configure input methods, in particular
  /// allowing the user to enable input methods.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_VOICE_INPUT_SETTINGS =
      "android.settings.VOICE_INPUT_SETTINGS";

  /// Activity Action: Show settings to configure input methods, in particular
  /// allowing the user to enable input methods.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_INPUT_METHOD_SETTINGS =
      "android.settings.INPUT_METHOD_SETTINGS";

  /// Activity Action: Show settings to enable/disable input method subtypes.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// To tell which input method's subtypes are displayed in the settings, add
  /// {@link #EXTRA_INPUT_METHOD_ID} extra to this Intent with the input method id.
  /// If there is no extra in this Intent, subtypes from all installed input methods
  /// will be displayed in the settings.
  ///
  /// @see android.view.inputmethod.InputMethodInfo#getId
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_INPUT_METHOD_SUBTYPE_SETTINGS =
      "android.settings.INPUT_METHOD_SUBTYPE_SETTINGS";

  /// Activity Action: Show settings to manage the user input dictionary.
  /// <p>
  /// Starting with {@link android.os.Build.VERSION_CODES#KITKAT},
  /// it is guaranteed there will always be an appropriate implementation for this Intent action.
  /// In prior releases of the platform this was optional, so ensure you safeguard against it.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_USER_DICTIONARY_SETTINGS =
      "android.settings.USER_DICTIONARY_SETTINGS";

  /// Activity Action: Show settings to configure the hardware keyboard.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_HARD_KEYBOARD_SETTINGS =
      "android.settings.HARD_KEYBOARD_SETTINGS";

  /// Activity Action: Adds a word to the user dictionary.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: An extra with key <code>word</code> that contains the word
  /// that should be added to the dictionary.
  /// <p>
  /// Output: Nothing.
  ///
  /// @hide

  static const String ACTION_USER_DICTIONARY_INSERT =
      "com.android.settings.USER_DICTIONARY_INSERT";

  /// Activity Action: Show settings to allow configuration of application-related settings.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_APPLICATION_SETTINGS =
      "android.settings.APPLICATION_SETTINGS";

  /// Activity Action: Show settings to allow configuration of application
  /// development-related settings.  As of
  /// {@link android.os.Build.VERSION_CODES#JELLY_BEAN_MR1} this action is
  /// a required part of the platform.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_APPLICATION_DEVELOPMENT_SETTINGS =
      "android.settings.APPLICATION_DEVELOPMENT_SETTINGS";

  /// Activity Action: Show settings to allow configuration of quick launch shortcuts.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_QUICK_LAUNCH_SETTINGS =
      "android.settings.QUICK_LAUNCH_SETTINGS";

  /// Activity Action: Show settings to manage installed applications.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_MANAGE_APPLICATIONS_SETTINGS =
      "android.settings.MANAGE_APPLICATIONS_SETTINGS";

  /// Activity Action: Show settings to manage all applications.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_MANAGE_ALL_APPLICATIONS_SETTINGS =
      "android.settings.MANAGE_ALL_APPLICATIONS_SETTINGS";

  /// Activity Action: Show screen for controlling which apps can draw on top of other apps.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Optionally, the Intent's data URI can specify the application package name to
  /// directly invoke the management GUI specific to the package name. For example
  /// "package:com.my.app".
  /// <p>
  /// Output: Nothing.

  static const String ACTION_MANAGE_OVERLAY_PERMISSION =
      "android.settings.action.MANAGE_OVERLAY_PERMISSION";

  /// Activity Action: Show screen for controlling which apps are allowed to write/modify
  /// system settings.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Optionally, the Intent's data URI can specify the application package name to
  /// directly invoke the management GUI specific to the package name. For example
  /// "package:com.my.app".
  /// <p>
  /// Output: Nothing.

  static const String ACTION_MANAGE_WRITE_SETTINGS =
      "android.settings.action.MANAGE_WRITE_SETTINGS";

  /// Activity Action: Show screen of details about a particular application.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: The Intent's data URI specifies the application package name
  /// to be shown, with the "package" scheme.  That is "package:com.my.app".
  /// <p>
  /// Output: Nothing.

  static const String ACTION_APPLICATION_DETAILS_SETTINGS =
      "android.settings.APPLICATION_DETAILS_SETTINGS";

  /// Activity Action: Show the "Open by Default" page in a particular application's details page.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you safeguard against this.
  /// <p>
  /// Input: The Intent's data URI specifies the application package name
  /// to be shown, with the "package" scheme. That is "package:com.my.app".
  /// <p>
  /// Output: Nothing.
  /// @hide

  static const String ACTION_APPLICATION_DETAILS_SETTINGS_OPEN_BY_DEFAULT_PAGE =
      "android.settings.APPLICATION_DETAILS_SETTINGS_OPEN_BY_DEFAULT_PAGE";

  /// Activity Action: Show list of applications that have been running
  /// foreground services (to the user "running in the background").
  /// <p>
  /// Input: Extras "packages" is a string array of package names.
  /// <p>
  /// Output: Nothing.
  /// @hide

  static const String ACTION_FOREGROUND_SERVICES_SETTINGS =
      "android.settings.FOREGROUND_SERVICES_SETTINGS";

  /// Activity Action: Show screen for controlling which apps can ignore battery optimizations.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  /// <p>
  /// You can use {@link android.os.PowerManager#isIgnoringBatteryOptimizations
  /// PowerManager.isIgnoringBatteryOptimizations()} to determine if an application is
  /// already ignoring optimizations.  You can use
  /// {@link #ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS} to ask the user to put you
  /// on this list.

  static const String ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS =
      "android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS";

  /// Activity Action: Ask the user to allow an app to ignore battery optimizations (that is,
  /// put them on the whitelist of apps shown by
  /// {@link #ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS}).  For an app to use this, it also
  /// must hold the {@link android.Manifest.permission#REQUEST_IGNORE_BATTERY_OPTIMIZATIONS}
  /// permission.
  /// <p><b>Note:</b> most applications should <em>not</em> use this; there are many facilities
  /// provided by the platform for applications to operate correctly in the various power
  /// saving modes.  This is only for unusual applications that need to deeply control their own
  /// execution, at the potential expense of the user's battery life.  Note that these applications
  /// greatly run the risk of showing to the user as high power consumers on their device.</p>
  /// <p>
  /// Input: The Intent's data URI must specify the application package name
  /// to be shown, with the "package" scheme.  That is "package:com.my.app".
  /// <p>
  /// Output: Nothing.
  /// <p>
  /// You can use {@link android.os.PowerManager#isIgnoringBatteryOptimizations
  /// PowerManager.isIgnoringBatteryOptimizations()} to determine if an application is
  /// already ignoring optimizations.

  static const String ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS =
      "android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS";

  /// Activity Action: Show screen for controlling background data
  /// restrictions for a particular application.
  /// <p>
  /// Input: Intent's data URI set with an application name, using the
  /// "package" schema (like "package:com.my.app").
  ///
  /// <p>
  /// Output: Nothing.
  /// <p>
  /// Applications can also use {@link android.net.ConnectivityManager#getRestrictBackgroundStatus
  /// ConnectivityManager#getRestrictBackgroundStatus()} to determine the
  /// status of the background data restrictions for them.
  ///
  /// <p class="note">
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.

  static const String ACTION_IGNORE_BACKGROUND_DATA_RESTRICTIONS_SETTINGS =
      "android.settings.IGNORE_BACKGROUND_DATA_RESTRIONS_SETTINGS";

  /// @hide
  /// Activity Action: Show the "app ops" settings screen.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_APP_OPS_SETTINGS =
      "android.settings.APP_OPS_SETTINGS";

  /// Activity Action: Show settings for system update functionality.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  ///
  /// @hide

  static const String ACTION_SYSTEM_UPDATE_SETTINGS =
      "android.settings.SYSTEM_UPDATE_SETTINGS";

  /// Activity Action: Show settings for managed profile settings.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  ///
  /// @hide

  static const String ACTION_MANAGED_PROFILE_SETTINGS =
      "android.settings.MANAGED_PROFILE_SETTINGS";

  /// Activity Action: Show settings to allow configuration of sync settings.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// The account types available to add via the add account button may be restricted by adding an
  /// {@link #EXTRA_AUTHORITIES} extra to this Intent with one or more syncable content provider's
  /// authorities. Only account types which can sync with that content provider will be offered to
  /// the user.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_SYNC_SETTINGS = "android.settings.SYNC_SETTINGS";

  /// Activity Action: Show add account screen for creating a new account.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// The account types available to add may be restricted by adding an {@link #EXTRA_AUTHORITIES}
  /// extra to the Intent with one or more syncable content provider's authorities.  Only account
  /// types which can sync with that content provider will be offered to the user.
  /// <p>
  /// Account types can also be filtered by adding an {@link #EXTRA_ACCOUNT_TYPES} extra to the
  /// Intent with one or more account types.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_ADD_ACCOUNT =
      "android.settings.ADD_ACCOUNT_SETTINGS";

  /// Activity Action: Show settings for selecting the network operator.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// The subscription ID of the subscription for which available network operators should be
  /// displayed may be optionally specified with {@link #EXTRA_SUB_ID}.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_NETWORK_OPERATOR_SETTINGS =
      "android.settings.NETWORK_OPERATOR_SETTINGS";

  /// Activity Action: Show settings for selection of 2G/3G.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_DATA_ROAMING_SETTINGS =
      "android.settings.DATA_ROAMING_SETTINGS";

  /// Activity Action: Show settings for internal storage.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_INTERNAL_STORAGE_SETTINGS =
      "android.settings.INTERNAL_STORAGE_SETTINGS";

  /// Activity Action: Show settings for memory card storage.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_MEMORY_CARD_SETTINGS =
      "android.settings.MEMORY_CARD_SETTINGS";

  /// Activity Action: Show settings for global search.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing

  static const String ACTION_SEARCH_SETTINGS =
      "android.search.action.SEARCH_SETTINGS";

  /// Activity Action: Show general device information settings (serial
  /// number, software version, phone number, etc.).
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing

  static const String ACTION_DEVICE_INFO_SETTINGS =
      "android.settings.DEVICE_INFO_SETTINGS";

  /// Activity Action: Show NFC settings.
  /// <p>
  /// This shows UI that allows NFC to be turned on or off.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing
  /// @see android.nfc.NfcAdapter#isEnabled()

  static const String ACTION_NFC_SETTINGS = "android.settings.NFC_SETTINGS";

  /// Activity Action: Show NFC Sharing settings.
  /// <p>
  /// This shows UI that allows NDEF Push (Android Beam) to be turned on or
  /// off.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing
  /// @see android.nfc.NfcAdapter#isNdefPushEnabled()

  static const String ACTION_NFCSHARING_SETTINGS =
      "android.settings.NFCSHARING_SETTINGS";

  /// Activity Action: Show NFC Tap & Pay settings
  /// <p>
  /// This shows UI that allows the user to configure Tap&Pay
  /// settings.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing

  static const String ACTION_NFC_PAYMENT_SETTINGS =
      "android.settings.NFC_PAYMENT_SETTINGS";

  /// Activity Action: Show Daydream settings.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  /// @see android.service.dreams.DreamService

  static const String ACTION_DREAM_SETTINGS = "android.settings.DREAM_SETTINGS";

  /// Activity Action: Show Notification listener settings.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  /// @see android.service.notification.NotificationListenerService

  static const String ACTION_NOTIFICATION_LISTENER_SETTINGS =
      "android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS";

  /// Activity Action: Show Do Not Disturb access settings.
  /// <p>
  /// Users can grant and deny access to Do Not Disturb configuration from here.
  /// See {@link android.app.NotificationManager#isNotificationPolicyAccessGranted()} for more
  /// details.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  ///
  /// <p class="note">
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.

  static const String ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS =
      "android.settings.NOTIFICATION_POLICY_ACCESS_SETTINGS";

  /// @hide

  static const String ACTION_CONDITION_PROVIDER_SETTINGS =
      "android.settings.ACTION_CONDITION_PROVIDER_SETTINGS";

  /// Activity Action: Show settings for video captioning.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you safeguard
  /// against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_CAPTIONING_SETTINGS =
      "android.settings.CAPTIONING_SETTINGS";

  /// Activity Action: Show the top level print settings.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_PRINT_SETTINGS =
      "android.settings.ACTION_PRINT_SETTINGS";

  /// Activity Action: Show Zen Mode configuration settings.
  ///
  /// @hide

  static const String ACTION_ZEN_MODE_SETTINGS =
      "android.settings.ZEN_MODE_SETTINGS";

  /// Activity Action: Show Zen Mode visual effects configuration settings.
  ///
  /// @hide

  static const String ZEN_MODE_BLOCKED_EFFECTS_SETTINGS =
      "android.settings.ZEN_MODE_BLOCKED_EFFECTS_SETTINGS";

  /// Activity Action: Show Zen Mode onboarding activity.
  ///
  /// @hide

  static const String ZEN_MODE_ONBOARDING =
      "android.settings.ZEN_MODE_ONBOARDING";

  /// Activity Action: Show Zen Mode (aka Do Not Disturb) priority configuration settings.

  static const String ACTION_ZEN_MODE_PRIORITY_SETTINGS =
      "android.settings.ZEN_MODE_PRIORITY_SETTINGS";

  /// Activity Action: Show Zen Mode automation configuration settings.
  ///
  /// @hide

  static const String ACTION_ZEN_MODE_AUTOMATION_SETTINGS =
      "android.settings.ZEN_MODE_AUTOMATION_SETTINGS";

  /// Activity Action: Modify do not disturb mode settings.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you safeguard against this.
  /// <p>
  /// This intent MUST be started using
  /// {@link android.service.voice.VoiceInteractionSession#startVoiceActivity
  /// startVoiceActivity}.
  /// <p>
  /// Note: The Activity implementing this intent MUST verify that
  /// {@link android.app.Activity#isVoiceInteraction isVoiceInteraction}.
  /// returns true before modifying the setting.
  /// <p>
  /// Input: The optional {@link #EXTRA_DO_NOT_DISTURB_MODE_MINUTES} extra can be used to indicate
  /// how long the user wishes to avoid interruptions for. The optional
  /// {@link #EXTRA_DO_NOT_DISTURB_MODE_ENABLED} extra can be to indicate if the user is
  /// enabling or disabling do not disturb mode. If either extra is not included, the
  /// user maybe asked to provide the value.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_VOICE_CONTROL_DO_NOT_DISTURB_MODE =
      "android.settings.VOICE_CONTROL_DO_NOT_DISTURB_MODE";

  /// Activity Action: Show Zen Mode schedule rule configuration settings.
  ///
  /// @hide

  static const String ACTION_ZEN_MODE_SCHEDULE_RULE_SETTINGS =
      "android.settings.ZEN_MODE_SCHEDULE_RULE_SETTINGS";

  /// Activity Action: Show Zen Mode event rule configuration settings.
  ///
  /// @hide

  static const String ACTION_ZEN_MODE_EVENT_RULE_SETTINGS =
      "android.settings.ZEN_MODE_EVENT_RULE_SETTINGS";

  /// Activity Action: Show Zen Mode external rule configuration settings.
  ///
  /// @hide

  static const String ACTION_ZEN_MODE_EXTERNAL_RULE_SETTINGS =
      "android.settings.ZEN_MODE_EXTERNAL_RULE_SETTINGS";

  /// Activity Action: Show the regulatory information screen for the device.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you safeguard
  /// against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_SHOW_REGULATORY_INFO =
      "android.settings.SHOW_REGULATORY_INFO";

  /// Activity Action: Show Device Name Settings.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you safeguard
  /// against this.
  ///
  /// @hide

  static const String DEVICE_NAME_SETTINGS = "android.settings.DEVICE_NAME";

  /// Activity Action: Show pairing settings.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you safeguard
  /// against this.
  ///
  /// @hide

  static const String ACTION_PAIRING_SETTINGS =
      "android.settings.PAIRING_SETTINGS";

  /// Activity Action: Show battery saver settings.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you safeguard
  /// against this.

  static const String ACTION_BATTERY_SAVER_SETTINGS =
      "android.settings.BATTERY_SAVER_SETTINGS";

  /// Activity Action: Modify Battery Saver mode setting using a voice command.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you safeguard against this.
  /// <p>
  /// This intent MUST be started using
  /// {@link android.service.voice.VoiceInteractionSession#startVoiceActivity
  /// startVoiceActivity}.
  /// <p>
  /// Note: The activity implementing this intent MUST verify that
  /// {@link android.app.Activity#isVoiceInteraction isVoiceInteraction} returns true before
  /// modifying the setting.
  /// <p>
  /// Input: To tell which state batter saver mode should be set to, add the
  /// {@link #EXTRA_BATTERY_SAVER_MODE_ENABLED} extra to this Intent with the state specified.
  /// If the extra is not included, no changes will be made.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_VOICE_CONTROL_BATTERY_SAVER_MODE =
      "android.settings.VOICE_CONTROL_BATTERY_SAVER_MODE";

  /// Activity Action: Show Home selection settings. If there are multiple activities
  /// that can satisfy the {@link Intent#CATEGORY_HOME} intent, this screen allows you
  /// to pick your preferred activity.

  static const String ACTION_HOME_SETTINGS = "android.settings.HOME_SETTINGS";

  /// Activity Action: Show Default apps settings.
  /// <p>
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_MANAGE_DEFAULT_APPS_SETTINGS =
      "android.settings.MANAGE_DEFAULT_APPS_SETTINGS";

  /// Activity Action: Show notification settings.
  ///
  /// @hide

  static const String ACTION_NOTIFICATION_SETTINGS =
      "android.settings.NOTIFICATION_SETTINGS";

  /// Activity Action: Show app listing settings, filtered by those that send notifications.
  ///
  /// @hide

  static const String ACTION_ALL_APPS_NOTIFICATION_SETTINGS =
      "android.settings.ALL_APPS_NOTIFICATION_SETTINGS";

  /// Activity Action: Show notification settings for a single app.
  /// <p>
  ///     Input: {@link #EXTRA_APP_PACKAGE}, the package to display.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_APP_NOTIFICATION_SETTINGS =
      "android.settings.APP_NOTIFICATION_SETTINGS";

  /// Activity Action: Show notification settings for a single {@link NotificationChannel}.
  /// <p>
  ///     Input: {@link #EXTRA_APP_PACKAGE}, the package containing the channel to display.
  ///     Input: {@link #EXTRA_CHANNEL_ID}, the id of the channel to display.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_CHANNEL_NOTIFICATION_SETTINGS =
      "android.settings.CHANNEL_NOTIFICATION_SETTINGS";

  /// Activity Extra: The package owner of the notification channel settings to display.
  /// <p>
  /// This must be passed as an extra field to the {@link #ACTION_CHANNEL_NOTIFICATION_SETTINGS}.
  static const String EXTRA_APP_PACKAGE = "android.provider.extra.APP_PACKAGE";

  /// Activity Extra: The {@link NotificationChannel#getId()} of the notification channel settings
  /// to display.
  /// <p>
  /// This must be passed as an extra field to the {@link #ACTION_CHANNEL_NOTIFICATION_SETTINGS}.
  static const String EXTRA_CHANNEL_ID = "android.provider.extra.CHANNEL_ID";

  /// Activity Action: Show notification redaction settings.
  ///
  /// @hide

  static const String ACTION_APP_NOTIFICATION_REDACTION =
      "android.settings.ACTION_APP_NOTIFICATION_REDACTION";

  /// @hide */ static const String EXTRA_APP_UID = "app_uid";

  /// Activity Action: Show a dialog with disabled by policy message.
  /// <p> If an user action is disabled by policy, this dialog can be triggered to let
  /// the user know about this.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  ///
  /// @hide

  static const String ACTION_SHOW_ADMIN_SUPPORT_DETAILS =
      "android.settings.SHOW_ADMIN_SUPPORT_DETAILS";

  /// Activity Action: Show a dialog for remote bugreport flow.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  ///
  /// @hide

  static const String ACTION_SHOW_REMOTE_BUGREPORT_DIALOG =
      "android.settings.SHOW_REMOTE_BUGREPORT_DIALOG";

  /// Activity Action: Show VR listener settings.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  ///
  /// @see android.service.vr.VrListenerService

  static const String ACTION_VR_LISTENER_SETTINGS =
      "android.settings.VR_LISTENER_SETTINGS";

  /// Activity Action: Show Picture-in-picture settings.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  ///
  /// @hide

  static const String ACTION_PICTURE_IN_PICTURE_SETTINGS =
      "android.settings.PICTURE_IN_PICTURE_SETTINGS";

  /// Activity Action: Show Storage Manager settings.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  ///
  /// @hide

  static const String ACTION_STORAGE_MANAGER_SETTINGS =
      "android.settings.STORAGE_MANAGER_SETTINGS";

  /// Activity Action: Allows user to select current webview implementation.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.

  static const String ACTION_WEBVIEW_SETTINGS =
      "android.settings.WEBVIEW_SETTINGS";

  /// Activity Action: Show enterprise privacy section.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  /// @hide
  // @SystemApi
  // @TestApi
  static const String ACTION_ENTERPRISE_PRIVACY_SETTINGS =
      "android.settings.ENTERPRISE_PRIVACY_SETTINGS";

  /// Activity Action: Show screen that let user select its Autofill Service.
  /// <p>
  /// Input: Intent's data URI set with an application name, using the
  /// "package" schema (like "package:com.my.app").
  ///
  /// <p>
  /// Output: {@link android.app.Activity#RESULT_OK} if user selected an Autofill Service belonging
  /// to the caller package.
  ///
  /// <p>
  /// <b>NOTE: </b> Applications should call
  /// {@link android.view.autofill.AutofillManager#hasEnabledAutofillServices()} and
  /// {@link android.view.autofill.AutofillManager#isAutofillSupported()}, and only use this action
  /// to start an activity if they return {@code false} and {@code true} respectively.

  static const String ACTION_REQUEST_SET_AUTOFILL_SERVICE =
      "android.settings.REQUEST_SET_AUTOFILL_SERVICE";

  /// Activity Action: Show screen for controlling which apps have access on volume directories.
  /// <p>
  /// Input: Nothing.
  /// <p>
  /// Output: Nothing.
  /// <p>
  /// Applications typically use this action to ask the user to revert the "Do not ask again"
  /// status of directory access requests made by
  /// {@link android.os.storage.StorageVolume#createAccessIntent(String)}.

  static const String ACTION_STORAGE_VOLUME_ACCESS_SETTINGS =
      "android.settings.STORAGE_VOLUME_ACCESS_SETTINGS";

  static final String AUTHORITY = "settings";

  static var System = _SystemSettings();
  static var Secure = _SecureSettings();
  static var Global = _GlobalSettings();
}
