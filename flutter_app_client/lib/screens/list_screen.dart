import 'package:flutter/material.dart';
import 'package:flutter_app_client/data/item.dart';

import '../globals.dart';
import 'base_list_screen.dart';

class ListScreen extends BaseListScreen {
  const ListScreen({super.key});

  @override
  State<BaseListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends BaseListScreenState {
  @override
  Future<List<Item>> getItemPage(int pageKey, int pageSize) {
    return Globals.services.itemOperations.getItemPage(pageKey, pageSize);
  }
}