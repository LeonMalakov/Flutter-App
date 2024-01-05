import '../data/item.dart';
import '../data/item_id.dart';

abstract interface class IRemoteApiRequester {
  Future getItemIdPage(int startIndex, int count, List<ItemId> outIds);

  Future getItems(List<ItemId> ids, List<Item> outItems);
}