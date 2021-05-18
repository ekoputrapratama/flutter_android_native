package com.mixaline.android_native.handlers


const val HANDLER_AUDIO_MANAGER = "AudioManager"
const val HANDLER_ACTIVITY = "Activity"
const val HANDLER_PACKAGE_MANAGER = "PackageManager"
const val HANDLER_KEYGUARD_MANAGER = "KeyguardManager"
const val HANDLER_POWER_MANAGER = "PowerManager"
const val HANDLER_SETTINGS = "Settings"
const val HANDLER_CONTEXT = "Context"
const val HANDLER_PREFERENCE_MANAGER = "PreferenceManager"
const val HANDLER_SHARED_PREFERENCES = "SharedPreferences"
const val HANDLER_CONTENT_RESOLVER = "ContentResolver"
const val HANDLER_TELEPHONY_MANAGER = "TelephonyManager"

// Activity methods
const val METHOD_ON_ACTIVITY_RESULT = "${HANDLER_ACTIVITY}.onActivityResult"
const val METHOD_ON_NEW_INTENT = "${HANDLER_ACTIVITY}.onNewIntent"
const val METHOD_GET_INTENT = "${HANDLER_ACTIVITY}.getIntent"
const val METHOD_ON_REQUEST_PERMISSIONS_RESULT = "${HANDLER_ACTIVITY}.onRequestPermissionsResult"
const val METHOD_START_ACTIVITY_FOR_RESULT = "${HANDLER_ACTIVITY}.startActivityForResult"
const val METHOD_REQUEST_PERMISSIONS = "${HANDLER_ACTIVITY}.requestPermissions"

// Context methods
const val METHOD_CHECK_SELF_PERMISSION = "${HANDLER_CONTEXT}.checkSelfPermission"
const val METHOD_START_ACTIVITY = "${HANDLER_CONTEXT}.startActivity"
const val METHOD_GET_SHARED_PREFERENCES = "${HANDLER_CONTEXT}.getSharedPreferences"

// PreferenceManager
const val METHOD_GET_DEFAULT_SHARED_PREFERENCES = "getDefaultSharedPreferences"

// SharedPreferences
const val METHOD_SP_GET_LONG = "${HANDLER_SHARED_PREFERENCES}.getLong"
const val METHOD_SP_GET_STRING = "${HANDLER_SHARED_PREFERENCES}.getString"
const val METHOD_SP_GET_INT = "${HANDLER_SHARED_PREFERENCES}.getInt"
const val METHOD_SP_GET_FLOAT = "${HANDLER_SHARED_PREFERENCES}.getFloat"
const val METHOD_SP_GET_BOOLEAN = "${HANDLER_SHARED_PREFERENCES}.getBoolean"
const val METHOD_SP_GET_ALL = "${HANDLER_SHARED_PREFERENCES}.getAll"
const val METHOD_SP_REGISTER_SP_CHANGE_LISTENER = "${HANDLER_SHARED_PREFERENCES}.registerOnSharedPreferenceChangeListener"

const val METHOD_SP_PUT_STRING = "${HANDLER_SHARED_PREFERENCES}.putString"
const val METHOD_SP_PUT_INT = "${HANDLER_SHARED_PREFERENCES}.putInt"
const val METHOD_SP_PUT_FLOAT = "${HANDLER_SHARED_PREFERENCES}.putFloat"
const val METHOD_SP_PUT_BOOLEAN = "${HANDLER_SHARED_PREFERENCES}.putBoolean"

// AudioManager methods
const val METHOD_GET_STREAM_VOLUME = "${HANDLER_AUDIO_MANAGER}.getStreamVolume"
const val METHOD_GET_STREAM_MAX_VOLUME = "${HANDLER_AUDIO_MANAGER}.getStreamMaxVolume"
const val METHOD_GET_STREAM_MIN_VOLUME = "${HANDLER_AUDIO_MANAGER}.getStreamMinVolume"
const val METHOD_IS_MUSIC_ACTIVE = "${HANDLER_AUDIO_MANAGER}.isMusicActive"
const val METHOD_SET_STREAM_VOLUME = "${HANDLER_AUDIO_MANAGER}.setStreamVolume"

// Settings methods
const val METHOD_SYSTEM_CAN_WRITE = "${HANDLER_SETTINGS}.System.canWrite"
const val METHOD_SYSTEM_GET_LONG = "${HANDLER_SETTINGS}.System.getLong"
const val METHOD_SYSTEM_GET_STRING = "${HANDLER_SETTINGS}.System.getString"
const val METHOD_SYSTEM_GET_INT = "${HANDLER_SETTINGS}.System.getInt"
const val METHOD_SYSTEM_GET_FLOAT = "${HANDLER_SETTINGS}.System.getFloat"
const val METHOD_SYSTEM_GET_URI_FOR = "${HANDLER_SETTINGS}.System.getUriFor"
const val METHOD_SECURE_GET_LONG = "${HANDLER_SETTINGS}.Secure.getLong"
const val METHOD_SECURE_GET_STRING = "${HANDLER_SETTINGS}.Secure.getString"
const val METHOD_SECURE_GET_INT = "${HANDLER_SETTINGS}.Secure.getInt"
const val METHOD_SECURE_GET_FLOAT = "${HANDLER_SETTINGS}.Secure.getFloat"
const val METHOD_SECURE_GET_URI_FOR = "${HANDLER_SETTINGS}.Secure.getUriFor"
const val METHOD_SECURE_CAN_WRITE = "${HANDLER_SETTINGS}.Secure.canWrite"

// KeyguardManager methods
const val METHOD_IS_KEYGUARD_LOCKED = "${HANDLER_KEYGUARD_MANAGER}.isKeyguardLocked"

// PowerManager methods
const val METHOD_IS_SCREEN_ON = "${HANDLER_POWER_MANAGER}.isScreenOn"
const val METHOD_IS_INTERACTIVE = "${HANDLER_POWER_MANAGER}.isInteractive"

// PackageManager methods
const val METHOD_GET_ACTIVITY_INFO = "${HANDLER_PACKAGE_MANAGER}.getActivityInfo"
const val METHOD_GET_PACKAGE_INFO = "${HANDLER_PACKAGE_MANAGER}.getPackageInfo"
const val METHOD_GET_INSTALLED_APPLICATIONS = "${HANDLER_PACKAGE_MANAGER}.getInstalledApplications"
const val METHOD_GET_INSTALLED_PACKAGES = "${HANDLER_PACKAGE_MANAGER}.getInstalledPackages"
const val METHOD_GET_TEXT = "${HANDLER_PACKAGE_MANAGER}.getText"
const val METHOD_GET_APPLICATION_ICON = "${HANDLER_PACKAGE_MANAGER}.getApplicationIcon"
const val METHOD_QUERY_INTENT_ACTIVITIES = "${HANDLER_PACKAGE_MANAGER}.queryIntentActivities"

// ContentResolver
const val METHOD_REGISTER_CONTENT_RESOLVER = "${HANDLER_CONTENT_RESOLVER}.registerContentObserver"
const val METHOD_UNREGISTER_CONTENT_RESOLVER = "${HANDLER_CONTENT_RESOLVER}.unregisterContentObserver"
const val METHOD_CONTENT_OBSERVER_ON_CHANGE = "${HANDLER_CONTENT_RESOLVER}.onChange"

// TelephonyManager
const val METHOD_GET_NETWORK_COUNTRY_ISO = "${HANDLER_TELEPHONY_MANAGER}.getNetworkCountryIso"
const val METHOD_GET_NETWORK_OPERATOR_NAME = "${HANDLER_TELEPHONY_MANAGER}.getNetworkOperatorName"
const val METHOD_GET_SIM_CARRIER_ID = "${HANDLER_TELEPHONY_MANAGER}.getSimCarrierId"
const val METHOD_GET_DEVICE_ID = "${HANDLER_TELEPHONY_MANAGER}.getDeviceId"
//const val METHOD_

const val METHOD_SHOW = "show"

const val PARAM_NAME = "name"
const val PARAM_PROCESS_NAME = "processName"
const val PARAM_PACKAGE_NAME = "packageName"
const val PARAM_CLASS_NAME = "className"
const val PARAM_FLAGS = "flags"
const val PARAM_STREAM_TYPE = "streamType"
const val PARAM_VOLUME = "volume"
const val PARAM_MESSAGE = "message"
const val PARAM_ICON = "icon"
const val PARAM_UNBADGED_ICON = "unbadgedIcon"
const val PARAM_LABEL_RES = "labelRes"
const val PARAM_LOGO = "logo"
const val PARAM_BANNER = "banner"
const val PARAM_URI = "uri"
const val PARAM_USE_DEVICE_PROTECTED_STORAGE = "useDeviceProtectedStorage"
