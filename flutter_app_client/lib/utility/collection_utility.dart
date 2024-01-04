import 'dart:collection';

class CollectionUtility {
  static Map invertMap(Map map) {
    return LinkedHashMap.fromEntries(map.entries.map((e) => MapEntry(e.value, e.key)));
  }
}