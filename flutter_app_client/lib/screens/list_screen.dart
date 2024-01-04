import 'package:flutter/material.dart';
import 'package:flutter_app_client/data/item.dart';
import 'package:flutter_app_client/data/item_id.dart';
import 'package:flutter_app_client/screens/item_popup.dart';
import 'package:flutter_app_client/screens/widgets/list_screen_item.dart';

import '../globals.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late final List<Item> _items;

  _ListScreenState() {
     _items = Globals.services.itemCollection.getAll();
  }

  void _onFavoriteClicked(ItemId id) {
    setState(() {
      Globals.services.itemOperations.toggleFavorite(id);
    });
  }

  void _onClicked(ItemId id) {
    final item = Globals.services.itemCollection.get(id);

    if(item == null) {
      return;
    }

    Globals.services.screen.openPopup(
        context,
        Globals.factories.itemPopup.create(ItemPopupArgs(
            item: item
        ))
    );
  }

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListScreenItem(
            item: _items[index],
            onFavoriteClicked: _onFavoriteClicked,
            onClicked: _onClicked,
          );
        },
    );
  }
}