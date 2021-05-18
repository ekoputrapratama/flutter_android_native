class ComponentName {
  String? packageName;
  String? className;
  ComponentName(this.packageName, this.className);

  static ComponentName? fromMap(Map? map) {
    if (map != null)
      return ComponentName(map["packageName"], map["className"]);
    else
      return null;
  }

  Map toMap() {
    var map = Map();
    map["packageName"] = packageName;
    map["className"] = className;
    return map;
  }
}
