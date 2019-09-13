class DataProvider {
  Map<String, List> map = {};

  bool add(String key, List value) {
    if (map.containsKey(key)) {
      return false;
    }

    map[key]= value;
    return true;
  }

  List<T> get<T>(String key) {
    var value = map[key];
    return value;
  }
}
