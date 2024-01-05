import 'package:flutter/material.dart';
import 'package:flutter_app_client/data/item.dart';
import 'package:flutter_app_client/data/item_id.dart';
import 'package:flutter_app_client/screens/item_popup.dart';
import 'package:flutter_app_client/screens/widgets/list_screen_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../globals.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  static const _pageSize = 20;

  final PagingController<int, Item> _pagingController = PagingController(firstPageKey: 0);

  //late final List<Item> _items;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
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

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await Globals.services.itemOperations.getItemPage(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Item>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Item>(
        itemBuilder: (context, item, index) => ListScreenItem(
          item: item,
          onFavoriteClicked: _onFavoriteClicked,
          onClicked: _onClicked,
        ),
      ),
    );

    /*return  ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListScreenItem(
            item: _items[index],
            onFavoriteClicked: _onFavoriteClicked,
            onClicked: _onClicked,
          );
        },
    );*/
  }
}