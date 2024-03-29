import 'package:flutter/material.dart';
import 'package:flutter_app_client/screens/widgets/favorite_button.dart';

import '../../data/item.dart';
import '../../data/item_id.dart';

class ListScreenItem extends StatelessWidget {
  final Item item;
  final bool isFavorite;
  final Function(ItemId) onFavoriteClicked;
  final Function(ItemId) onClicked;

  const ListScreenItem({
    super.key,
    required this.item,
    required this.isFavorite,
    required this.onFavoriteClicked,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FavoriteButton(
        isFavorite: isFavorite,
        onPressed: () {
          onFavoriteClicked(item.id);
        },
        size: 30,
      ),
      title: Text(item.title),
      subtitle: Text(
        item.subtitle,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        softWrap: false,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        onClicked(item.id);
      },
    );
  }
}