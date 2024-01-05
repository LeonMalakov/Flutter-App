import 'package:flutter_app_client/data/item.dart';
import 'package:flutter_app_client/services/i_remote_api_requester.dart';

import '../data/item_id.dart';

class FakeRemoteApiRequester implements IRemoteApiRequester {
  @override
  Future getItemIdPage(int startIndex, int count, List<ItemId> outIds) async {
    await Future.delayed(const Duration(seconds: 1));

    if(startIndex >= 110){
      return [];
    }

    for(int i = startIndex; i < startIndex + count; i++){
      outIds.add(ItemId(i));
    }
  }

  @override
  Future getItems(List<ItemId> ids, List<Item> outItems) async {
    await Future.delayed(const Duration(seconds: 2));

    for(final id in ids){
      outItems.add(Item(
        id: id,
        title: 'Фильм ${id.value}',
        subtitle: 'Подзаголовок фильма ${id.value}',
        description: 'Описание фильма ${id.value}',
        imageUrl: 'https://thumbs.dfs.ivi.ru/storage6/contents/8/8/84a1f2c0430452ab08f07c86eab477.jpg',
        isFavorite: id.value % 2 == 0,
      ));
    }
  }
}