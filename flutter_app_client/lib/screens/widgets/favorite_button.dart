import 'package:flutter/material.dart';

import '../../constants/layout_constants.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final Function() onPressed;
  final double size;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      color: LayoutConstants.favoriteIconColor,
      iconSize: size,
      onPressed: onPressed,
    );
  }
}