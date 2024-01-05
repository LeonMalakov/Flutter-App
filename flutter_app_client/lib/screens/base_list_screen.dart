import 'package:event/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_client/data/item.dart';
import 'package:flutter_app_client/data/item_id.dart';
import 'package:flutter_app_client/screens/item_popup.dart';
import 'package:flutter_app_client/screens/widgets/list_screen_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../globals.dart';

abstract class BaseListScreen extends StatefulWidget {
  const BaseListScreen({super.key});
}

abstract class BaseListScreenState extends State<BaseListScreen> {
  static const _pageSize = 20;

  final PagingController<int, Item> pagingController = PagingController(firstPageKey: 0);
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();

    Globals.services.itemCollection.onFavoriteChanged.subscribe(_onFavoriteChanged);
  }

  @override
  void dispose() {
    Globals.services.itemCollection.onFavoriteChanged.unsubscribe(_onFavoriteChanged);
    pagingController.dispose();
    super.dispose();
  }

  void _onFavoriteChanged(Value<ItemId>? id) {
    setState(() { });
    onViewUpdated();
  }

  void _onFavoriteClicked(ItemId id) {
    Globals.services.itemOperations.toggleFavorite(id);
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
      final newItems = await getItemPage(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Item>(
      pagingController: pagingController,
      scrollController: scrollController,
      builderDelegate: PagedChildBuilderDelegate<Item>(
        itemBuilder: (context, item, index) => ListScreenItem(
          item: item,
          isFavorite: Globals.services.itemCollection.isFavorite(item.id),
          onFavoriteClicked: _onFavoriteClicked,
          onClicked: _onClicked,
        ),
      ),
    );
  }

  void onViewUpdated() { }

  Future<List<Item>> getItemPage(int pageKey, int pageSize);
}