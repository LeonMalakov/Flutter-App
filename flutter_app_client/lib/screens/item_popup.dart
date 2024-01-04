import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_client/data/item_id.dart';
import 'package:flutter_app_client/screens/widgets/favorite_button.dart';

class ItemPopupArgs {
  final ItemId itemId;
  final Function(ItemId) onFavoriteClicked;

  const ItemPopupArgs({
    required this.itemId,
    required this.onFavoriteClicked,
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  Image.network(
                    "https://thumbs.dfs.ivi.ru/storage6/contents/8/8/84a1f2c0430452ab08f07c86eab477.jpg",
                    height: 400,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: FavoriteButton(
                      isFavorite: widget.args.itemId.value % 2 == 0,
                      onPressed: () {
                        widget.args.onFavoriteClicked(widget.args.itemId);
                      },
                      size: 50,
                    ),
                  ),
                ],
              )
            ),

            Text(
              "name ${widget.args.itemId.value}",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Крутой фильм про стетхема Гнев Человеческий. В этом крутом фильме увидишь как стетхем бьет всех и вся. Крутой фильм про стетхема Гнев Человеческий. В этом крутом фильме увидишь как стетхем бьет всех и вся. Крутой фильм про стетхема Гнев Человеческий. В этом крутом фильме увидишь как стетхем бьет всех и вся. Крутой фильм про стетхема Гнев Человеческий. В этом крутом фильме увидишь как стетхем бьет всех и вся. Крутой фильм про стетхема Гнев Человеческий. В этом крутом фильме увидишь как стетхем бьет всех и вся. Крутой фильм про стетхема Гнев Человеческий. В этом крутом фильме увидишь как стетхем бьет всех и вся. Крутой фильм про стетхема Гнев Человеческий. В этом крутом фильме увидишь как стетхем бьет всех и вся. ",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      )
    );
  }
}