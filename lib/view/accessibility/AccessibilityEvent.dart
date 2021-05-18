class AccessibilityEvent {
  static AccessibilityEvent? fromMap(Map? map) {
    if (map != null) {
      var instance = AccessibilityEvent();
      instance.eventType = map["eventType"];
      instance.packageName = map["packageName"];
      instance.className = map["className"];
      instance.eventTime = map["eventTime"];
      instance.recordCount = map["recordCount"];
      instance.windowChanges = map["windowChanges"];
      return instance;
    }
    return null;
  }

  int eventType = 0;
  String? packageName;
  String? className;
  int eventTime = 0;
  int recordCount = 0;
  int windowChanges = 0;

  static const int TYPE_WINDOWS_CHANGED = 4194304;
  static const int TYPE_WINDOW_CONTENT_CHANGED = 2048;
  static const int TYPE_WINDOW_STATE_CHANGED = 32;
}
