import 'item_id.dart';

class Item {
  final ItemId id;
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  bool isFavorite = false;

  Item({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
  });
}