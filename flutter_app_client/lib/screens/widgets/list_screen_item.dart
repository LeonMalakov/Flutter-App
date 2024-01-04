import 'package:flutter/material.dart';
import 'package:flutter_app_client/screens/widgets/favorite_button.dart';

import '../../data/item_id.dart';

class ListScreenItem extends StatelessWidget {
  final ItemId id;
  final String title;
  final String subtitle;
  final Function(ItemId) onFavoriteClicked;
  final Function(ItemId) onClicked;

  const ListScreenItem({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.onFavoriteClicked,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FavoriteButton(
        isFavorite: id.value % 2 == 0,
        onPressed: () {
          onFavoriteClicked(id);
        },
        size: 30,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.more_vert),
      onTap: () {
        onClicked(id);
      },
    );
  }
}