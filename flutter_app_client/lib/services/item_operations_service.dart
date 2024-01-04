import 'package:flutter_app_client/globals.dart';

import '../data/item_id.dart';

class ItemOperationsService {
  void toggleFavorite(ItemId id) {
    final item = Globals.services.itemCollection.get(id);
    if(item == null) {
      return;
    }

    Globals.services.itemCollection.setIsFavorite(id, !item.isFavorite);

    // TODO: бэк.
  }
}