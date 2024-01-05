import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_client/globals.dart';
import 'package:flutter_app_client/screens/widgets/favorite_button.dart';

import '../data/item.dart';

class ItemPopupArgs {
  final Item item;

  const ItemPopupArgs({
    required this.item
  });
}

class ItemPopup extends StatefulWidget{
  final ItemPopupArgs args;

  const ItemPopup({
    super.key,
    required this.args,
  });

  @override
  State<StatefulWidget> createState() => _ItemPopupState();
}

class _ItemPopupState extends State<ItemPopup> {
  void _onFavoriteClicked() {
    setState(() {
      Globals.services.itemOperations.toggleFavorite(widget.args.item.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  Image.network(
                    widget.args.item.imageUrl,
                    height: 400,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: FavoriteButton(
                      isFavorite: Globals.services.itemCollection.isFavorite(widget.args.item.id),
                      onPressed: _onFavoriteClicked,
                      size: 50,
                    ),
                  ),
                ],
              )
            ),

            Text(
              widget.args.item.title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.args.item.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      )
    );
  }
}