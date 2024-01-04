import 'package:flutter/material.dart';
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
  final List<String> items = List<String>.generate(10000, (i) => "Item $i");

  void _onFavoriteClicked(ItemId id) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item favorite clicked')),
    );
  }

  void _onClicked(ItemId id) {
    Globals.services.screen.openPopup(
        context,
        Globals.factories.itemPopup.create(ItemPopupArgs(
            itemId: id,
            onFavoriteClicked: _onFavoriteClicked
        ))
    );

    /*ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item clicked')),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListScreenItem(
            id: ItemId(index),
            title: 'Item ${items[index]}',
            subtitle: 'Tap on the heart icon to favorite',
            onFavoriteClicked: _onFavoriteClicked,
            onClicked: _onClicked,
          );
        },
    );
  }
}