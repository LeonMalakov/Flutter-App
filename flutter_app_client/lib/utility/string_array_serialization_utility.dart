import '../data/item_id.dart';

class StringArraySerializationUtility {
  static String serialize(List<ItemId> list) {
    if(list.isEmpty){
      return "";
    }

    String s = list[0].value.toString();
    for(int i = 1; i < list.length; i++){
      s += ",${list[i].value}";
    }

    return s;
  }

  static List<ItemId> deserialize(String string) {
    if(string.isEmpty){
      return [];
    }

    final List<String> strings = string.split(",");
    final List<ItemId> list = [];
    for(String s in strings){
      list.add(ItemId(int.parse(s)));
    }
    return list;
  }
}