class Bundle {
  Map<String, dynamic?> _map = Map();

  Bundle();
  Bundle.fromBundle(Bundle bundle);
  Bundle.fromMap(Map? map) {
    if (map != null) {
      for (var item in map.entries) {
        _map[item.key] = item.value;
      }
    }
  }

  /// Returns the number of mappings contained in this Bundle.
  ///
  /// @return the number of mappings as an int.
  int size() {
    // unparcel();
    return _map.length;
  }

  /// Returns true if the mapping of this Bundle is empty, false otherwise.
  bool isEmpty() {
    // unparcel();
    return _map.isEmpty;
  }

  /// Removes all elements from the mapping of this Bundle.
  void clear() {
    // unparcel();
    _map.clear();
  }

  /// Returns true if the given key is contained in the mapping
  /// of this Bundle.
  ///
  /// @param key a String key
  /// @return true if the key is part of the mapping, false otherwise
  bool containsKey(String key) {
    // unparcel();
    return _map.containsKey(key);
  }

  /// Returns the entry with the given key as an object.
  ///
  /// @param key a String key
  /// @return an Object, or null
  dynamic get(String key) {
    // unparcel();
    return _map[key];
  }

  /// Removes any entry with the given key from the mapping of this Bundle.
  ///
  /// @param key a String key
  void remove(String key) {
    // unparcel();
    _map.remove(key);
  }

  /// Inserts all mappings from the given Map into this BaseBundle.
  ///
  /// @param map a Map
  void putAll(Map<String, dynamic?> map) {
    // unparcel();
    _map.addAll(map);
  }

  /// Returns a Set containing the Strings used as keys in this Bundle.
  ///
  /// @return a Set of String keys
  Set<String> keySet() {
    // unparcel();
    return _map.keys.toSet();
  }

  /// {@hide} */
  void putObject(String key, dynamic? value) {
    if (value == null) {
      putString(key, null);
    } else if (value is bool) {
      putBoolean(key, value);
    } else if (value is int) {
      putInt(key, value);
    } else if (value is double) {
      putDouble(key, value);
    } else if (value is String) {
      putString(key, value);
    } else if (value is List<bool>) {
      putBooleanArray(key, value);
    } else if (value is List<int>) {
      putIntArray(key, value);
    } else if (value is List<double>) {
      putDoubleArray(key, value);
    } else if (value is List<String>) {
      putStringArray(key, value);
    } else if (value is Bundle) {
      putBundle(key, value);
    } else {
      throw Exception("Unsupported type " + value.runtimeType.toString());
    }
  }

  /// Inserts a Boolean value into the mapping of this Bundle, replacing
  /// any existing value for the given key.  Either key or value may be null.
  ///
  /// @param key a String, or null
  /// @param value a boolean
  void putBoolean(String key, bool value) {
    // unparcel();
    _map[key] = value;
  }

  /// Inserts an int value into the mapping of this Bundle, replacing
  /// any existing value for the given key.
  ///
  /// @param key a String, or null
  /// @param value an int
  void putInt(String key, int value) {
    // unparcel();
    _map[key] = value;
  }

  /// Inserts a float value into the mapping of this Bundle, replacing
  /// any existing value for the given key.
  ///
  /// @param key a String, or null
  /// @param value a float
  void putFloat(String key, double value) {
    // unparcel();
    _map[key] = value;
  }

  /// Inserts a double value into the mapping of this Bundle, replacing
  /// any existing value for the given key.
  ///
  /// @param key a String, or null
  /// @param value a double
  void putDouble(String key, double value) {
    // unparcel();
    _map[key] = value;
  }

  /// Inserts a String value into the mapping of this Bundle, replacing
  /// any existing value for the given key.  Either key or value may be null.
  ///
  /// @param key a String, or null
  /// @param value a String, or null
  void putString(String key, String? value) {
    // unparcel();
    _map[key] = value;
  }

  /// Inserts an ArrayList<Integer> value into the mapping of this Bundle, replacing
  /// any existing value for the given key.  Either key or value may be null.
  ///
  /// @param key a String, or null
  /// @param value an ArrayList<Integer> object, or null
  void putIntegerArrayList(String key, List<int>? value) {
    putIntegerList(key, value);
  }

  void putIntegerList(String key, List<int>? value) {
    // unparcel();
    _map[key] = value;
  }

  /// Inserts an ArrayList<String> value into the mapping of this Bundle, replacing
  /// any existing value for the given key.  Either key or value may be null.
  ///
  /// @param key a String, or null
  /// @param value an ArrayList<String> object, or null
  void putStringArrayList(String key, List<String>? value) {
    putStringList(key, value);
  }

  void putStringList(String key, List<String>? value) {
    // unparcel();
    _map[key] = value;
  }

  /// Inserts a boolean array value into the mapping of this Bundle, replacing
  /// any existing value for the given key.  Either key or value may be null.
  ///
  /// @param key a String, or null
  /// @param value a boolean array object, or null
  void putBooleanArray(String key, List<bool> value) {
    putBooleanList(key, value);
  }

  void putBooleanList(String key, List<bool> value) {
    // unparcel();
    _map[key] = value;
  }

  /// Inserts an int array value into the mapping of this Bundle, replacing
  /// any existing value for the given key.  Either key or value may be null.
  ///
  /// @param key a String, or null
  /// @param value an int array object, or null
  void putIntArray(String key, List<int> value) {
    putIntList(key, value);
  }

  void putIntList(String key, List<int> value) {
    // unparcel();
    _map[key] = value;
  }

  /// Inserts a float array value into the mapping of this Bundle, replacing
  /// any existing value for the given key.  Either key or value may be null.
  ///
  /// @param key a String, or null
  /// @param value a float array object, or null
  void putFloatArray(String key, List<double> value) {
    putDoubleList(key, value);
  }

  void putFloatList(String key, List<double> value) {
    putDoubleList(key, value);
  }

  /// Inserts a double array value into the mapping of this Bundle, replacing
  /// any existing value for the given key.  Either key or value may be null.
  ///
  /// @param key a String, or null
  /// @param value a double array object, or null
  void putDoubleArray(String key, List<double> value) {
    putDoubleList(key, value);
  }

  void putDoubleList(String key, List<double> value) {
    // unparcel();
    _map[key] = value;
  }

  /// Inserts a String array value into the mapping of this Bundle, replacing
  /// any existing value for the given key.  Either key or value may be null.
  ///
  /// @param key a String, or null
  /// @param value a String array object, or null
  void putStringArray(String key, List<String> value) {
    // unparcel();
    putStringList(key, value);
  }

  /// Inserts a Bundle value into the mapping of this Bundle, replacing
  /// any existing value for the given key.  Either key or value may be null.
  ///
  /// @param key a String, or null
  /// @param value a Bundle object, or null
  void putBundle(String key, Bundle? value) {
    // unparcel();
    _map[key] = value;
  }

  /// Returns the value associated with the given key, or defaultValue if
  /// no mapping of the desired type exists for the given key.
  ///
  /// @param key a String
  /// @param defaultValue Value to return if key does not exist
  /// @return a boolean value
  bool getBoolean(String key, {bool defaultValue = false}) {
    // unparcel();
    var o = _map[key];
    if (o == null) {
      return defaultValue;
    }
    try {
      return o as bool;
    } catch (e) {
      // typeWarning(key, o, "Boolean", defaultValue, e);
      return defaultValue;
    }
  }

  /// Returns the value associated with the given key, or defaultValue if
  /// no mapping of the desired type exists for the given key.
  ///
  /// @param key a String
  /// @param defaultValue Value to return if key does not exist
  /// @return an int value
  int getInt(String key, {int defaultValue = 0}) {
    // unparcel();
    var o = _map[key];
    if (o == null) {
      return defaultValue;
    }
    try {
      return o as int;
    } catch (e) {
      // typeWarning(key, o, "Integer", defaultValue, e);
      return defaultValue;
    }
  }

  /// Returns the value associated with the given key, or defaultValue if
  /// no mapping of the desired type exists for the given key.
  ///
  /// @param key a String
  /// @param defaultValue Value to return if key does not exist
  /// @return a double value
  double getDouble(String key, {double defaultValue = 0.0}) {
    // unparcel();
    var o = _map[key];
    if (o == null) {
      return defaultValue;
    }
    try {
      return o as double;
    } catch (e) {
      // typeWarning(key, o, "Double", defaultValue, e);
      return defaultValue;
    }
  }

  double getFloat(String key, {double defaultValue = 0.0}) {
    return getDouble(key, defaultValue: defaultValue);
  }

  /// Returns the value associated with the given key, or defaultValue if
  /// no mapping of the desired type exists for the given key or if a null
  /// value is explicitly associated with the given key.
  ///
  /// @param key a String, or null
  /// @param defaultValue Value to return if key does not exist or if a null
  ///     value is associated with the given key.
  /// @return the String value associated with the given key, or defaultValue
  ///     if no valid String object is currently mapped to that key.
  String? getString(String key, {String? defaultValue}) {
    // unparcel();
    var o = _map[key];
    try {
      return o as String;
    } catch (e) {
      // typeWarning(key, o, "String", e);
      return defaultValue;
    }
  }

  /// Returns the value associated with the given key, or null if
  /// no mapping of the desired type exists for the given key or a null
  /// value is explicitly associated with the key.
  ///
  /// @param key a String, or null
  /// @return an ArrayList<String> value, or null

  List<int>? getIntegerArrayList(String key) {
    return getIntList(key);
  }

  List<int>? getIntegerList(String key) {
    return getIntList(key);
  }

  List<int>? getIntArray(String key) {
    return getIntList(key);
  }

  List<int>? getIntList(String key) {
    // unparcel();
    var o = _map[key];
    if (o == null) {
      return null;
    }
    try {
      return o as List<int>;
    } catch (e) {
      // typeWarning(key, o, "ArrayList<Integer>", e);
      return null;
    }
  }

  /// Returns the value associated with the given key, or null if
  /// no mapping of the desired type exists for the given key or a null
  /// value is explicitly associated with the key.
  ///
  /// @param key a String, or null
  /// @return an ArrayList<String> value, or null
  List<String>? getStringArrayList(String key) {
    return getStringList(key);
  }

  List<String>? getStringArray(String key) {
    return getStringList(key);
  }

  List<String>? getStringList(String key) {
    // unparcel();
    var o = _map[key];
    if (o == null) {
      return null;
    }

    try {
      return o as List<String>;
    } catch (e) {
      // typeWarning(key, o, "ArrayList<String>", e);
      return null;
    }
  }

  /// Returns the value associated with the given key, or null if
  /// no mapping of the desired type exists for the given key or a null
  /// value is explicitly associated with the key.
  ///
  /// @param key a String, or null
  /// @return a boolean[] value, or null
  List<bool>? getBooleanArray(String key) {
    return getBooleanList(key);
  }

  List<bool>? getBooleanList(String key) {
    // unparcel();
    var o = _map[key];
    if (o == null) {
      return null;
    }
    try {
      return o as List<bool>;
    } catch (e) {
      // typeWarning(key, o, "byte[]", e);
      return null;
    }
  }

  /// Returns the value associated with the given key, or null if
  /// no mapping of the desired type exists for the given key or a null
  /// value is explicitly associated with the key.
  ///
  /// @param key a String, or null
  /// @return a double[] value, or null

  List<double>? getFloatArray(String key) {
    return getDoubleList(key);
  }

  List<double>? getDoubleArray(String key) {
    return getDoubleList(key);
  }

  List<double>? getDoubleList(String key) {
    // unparcel();
    var o = _map[key];
    if (o == null) {
      return null;
    }
    try {
      return o as List<double>;
    } catch (e) {
      // typeWarning(key, o, "float[]", e);
      return null;
    }
  }

  Bundle? getBundle(String key) {
    // unparcel();
    var o = _map[key];
    if (o == null) {
      return null;
    }
    try {
      return o as Bundle;
    } catch (e) {
      // typeWarning(key, o, "Bundle", e);
      return null;
    }
  }

  Map toMap() {
    return _map;
  }
}
