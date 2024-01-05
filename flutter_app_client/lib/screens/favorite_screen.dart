import 'package:flutter/material.dart';
import 'package:flutter_app_client/data/item.dart';

import '../globals.dart';
import 'base_list_screen.dart';

class FavoriteScreen extends BaseListScreen {
  const FavoriteScreen({super.key});

  @override
  State<BaseListScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends BaseListScreenState {
  @override
  void onViewUpdated() {
    double pos = scrollController.position.pixels;
    pagingController.refresh();
    scrollController.jumpTo(pos);
  }

  @override
  Future<List<Item>> getItemPage(int pageKey, int pageSize) {
    return Globals.services.itemOperations.getFavoriteItemPage(pageKey, pageSize);
  }
}