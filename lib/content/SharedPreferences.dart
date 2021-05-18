import 'dart:async';
import 'dart:ffi';

import 'package:android_native/android_native.dart';

const _GET_BOOLEAN = "SharedPreferences.getBoolean";
const _GET_INT = "SharedPreferences.getInt";
const _GET_STRING = "SharedPreferences.getString";
const _GET_FLOAT = "SharedPreferences.getFloat";
const _GET_ALL = "SharedPreferences.getAll";

const _PUT_BOOLEAN = "SharedPreferences.putBoolean";
const _PUT_INT = "SharedPreferences.putInt";
const _PUT_STRING = "SharedPreferences.putString";
const _PUT_FLOAT = "SharedPreferences.putFloat";

const String _PARAM_USE_DEVICE_PROTECTED_STORAGE = "useDeviceProtectedStorage";
const String _PARAM_NAME = "name";
const String _PARAM_KEY = "key";
const String _PARAM_MODE = "mode";
const String _PARAM_VALUE = "value";
const String _PARAM_DEFAULT_VALUE = "defaultValue";

class SharedPreferences extends AndroidNativeObject {
  final String _name;
  final int _mode;
  final bool prefetch;
  final useDeviceProtectedStorage;

  Map _preference = Map();
  bool _initialized = false;

  SharedPreferences(this._name, this._mode,
      {this.prefetch = false, this.useDeviceProtectedStorage = false}) {
    if (prefetch) {
      _init();
    }
  }

  Future _init() async {
    if (_initialized) return;

    var prefs = await _getAll();
    if (prefs != null) {
      _preference = prefs;
    }
    _initialized = true;
  }

  SharedPreferenceEditor edit() {
    return SharedPreferenceEditor(this);
  }

  FutureOr<bool> getBoolean(String key, {bool? defaultValue}) async {
    if (prefetch) {
      var value = _preference[key];

      if (value != null) {
        return value;
      } else if (value == null && defaultValue != null) {
        return defaultValue;
      }
    } else {
      var args = Map();
      args[_PARAM_NAME] = _name;
      args[_PARAM_MODE] = _mode;
      args[_PARAM_KEY] = key;
      args[_PARAM_DEFAULT_VALUE] = defaultValue;
      args[_PARAM_USE_DEVICE_PROTECTED_STORAGE] = useDeviceProtectedStorage;

      var result = await invokeMethod(_GET_BOOLEAN, args);
      if (result != null) return result as bool;
      if (result == null && defaultValue != null) return defaultValue;
    }

    return false;
  }

  FutureOr<int?> getInt(String key, {int? defaultValue}) async {
    if (prefetch) {
      var value = _preference[key];

      if (value != null) {
        return value;
      } else if (value == null && defaultValue != null) {
        return defaultValue;
      }
    } else {
      var args = Map();
      args[_PARAM_NAME] = _name;
      args[_PARAM_MODE] = _mode;
      args[_PARAM_KEY] = key;
      args[_PARAM_DEFAULT_VALUE] = defaultValue;
      args[_PARAM_USE_DEVICE_PROTECTED_STORAGE] = useDeviceProtectedStorage;

      var result = await invokeMethod(_GET_INT, args);
      if (result != null) return result as int?;
      if (result == null && defaultValue != null) return defaultValue;
    }
    return null;
  }

  FutureOr<String?> getString(String key, {String? defaultValue}) async {
    if (prefetch) {
      var value = _preference[key];

      if (value != null) {
        return value;
      } else if (value == null && defaultValue != null) {
        return defaultValue;
      }
    } else {
      var args = Map();
      args[_PARAM_NAME] = _name;
      args[_PARAM_MODE] = _mode;
      args[_PARAM_KEY] = key;
      args[_PARAM_DEFAULT_VALUE] = defaultValue;
      args[_PARAM_USE_DEVICE_PROTECTED_STORAGE] = useDeviceProtectedStorage;

      var result = await invokeMethod(_GET_STRING, args);
      if (result != null)
        return result as String;
      else if (result == null && defaultValue != null) return defaultValue;
    }
    return null;
  }

  FutureOr<double?> getFloat(String key, {double? defaultValue}) {
    return getDouble(key);
  }

  FutureOr<double?> getDouble(String key, {double? defaultValue}) async {
    if (prefetch) {
      var value = _preference[key];

      if (value != null) {
        return value;
      } else if (value == null && defaultValue != null) {
        return defaultValue;
      }
    } else {
      var args = Map();
      args[_PARAM_NAME] = _name;
      args[_PARAM_MODE] = _mode;
      args[_PARAM_KEY] = key;
      args[_PARAM_DEFAULT_VALUE] = defaultValue;
      args[_PARAM_USE_DEVICE_PROTECTED_STORAGE] = useDeviceProtectedStorage;

      var result = await invokeMethod(_GET_FLOAT, args);
      if (result != null) return result as double;
      if (result == null && defaultValue != null) return defaultValue;
    }

    return null;
  }

  Map getAll() {
    return _preference;
  }

  Future<Map?> _getAll() async {
    var args = Map();
    args[_PARAM_NAME] = _name;
    args[_PARAM_MODE] = _mode;
    args[_PARAM_USE_DEVICE_PROTECTED_STORAGE] = useDeviceProtectedStorage;
    return await invokeMethod<Map>(_GET_ALL, args);
  }
}

class SharedPreferenceEditor extends AndroidNativeObject {
  final SharedPreferences _self;
  final Map<String, dynamic> pref = Map();
  SharedPreferenceEditor(this._self);

  void apply() {
    for (var entry in pref.entries) {
      _self._preference[entry.key] = entry.value;
      var args = Map();
      args[_PARAM_NAME] = _self._name;
      args[_PARAM_MODE] = _self._mode;
      args[_PARAM_KEY] = entry.key;
      args[_PARAM_VALUE] = entry.value;
      args[_PARAM_USE_DEVICE_PROTECTED_STORAGE] =
          _self.useDeviceProtectedStorage;

      if (entry.value is int) {
        invokeMethod(_PUT_INT, args);
      } else if (entry.value is Float) {
        invokeMethod(_PUT_FLOAT, args);
      } else if (entry.value is String) {
        invokeMethod(_PUT_STRING, args);
      } else if (entry.value is bool) {
        invokeMethod(_PUT_BOOLEAN, args);
      }
    }
  }

  Future<bool> commit() async {
    var results = [];

    for (var entry in pref.entries) {
      bool? result;

      var args = Map();
      args[_PARAM_NAME] = _self._name;
      args[_PARAM_MODE] = _self._mode;
      args[_PARAM_KEY] = entry.key;
      args[_PARAM_VALUE] = entry.value;
      args[_PARAM_USE_DEVICE_PROTECTED_STORAGE] =
          _self.useDeviceProtectedStorage;

      if (entry.value is int) {
        result = await invokeMethod<bool>(_PUT_INT, args);
      } else if (entry.value is double) {
        result = await invokeMethod(_PUT_FLOAT, args);
      } else if (entry.value is String) {
        result = await invokeMethod(_PUT_STRING, args);
      } else if (entry.value is bool) {
        result = await invokeMethod(_PUT_BOOLEAN, args);
      }

      if (result != null) {
        results.add(result);
        if (result) _self._preference[entry.key] = entry.value;
      }
    }

    return !results.contains(false);
  }

  SharedPreferenceEditor putBoolean(String key, bool value) {
    pref[key] = value;
    return this;
  }

  SharedPreferenceEditor putInt(String key, int value) {
    pref[key] = value;
    return this;
  }

  SharedPreferenceEditor putString(String key, String value) {
    pref[key] = value;
    return this;
  }

  SharedPreferenceEditor putFloat(String key, double value) {
    pref[key] = value;
    return this;
  }
}
