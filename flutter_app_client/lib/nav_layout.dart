import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app_client/utility/collection_utility.dart';

import 'constants/app_constants.dart';
import 'constants/layout_constants.dart';
import 'app_layout.dart';
import 'globals.dart';

class NavLayout extends StatelessWidget {
  static const _screenRouteToIndexMap = {
    //RouteConstants.home: 0,
    RouteConstants.list: 0,
    RouteConstants.favorites: 1,
  };
  static final _indexToScreenRouteMap = CollectionUtility.invertMap(_screenRouteToIndexMap);

  final Widget childWidget;

  const NavLayout({Key? key, required this.childWidget}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return AppLayout(
        childWidget: childWidget,
        bottomWidget: BottomNavigationBar(
          items: const [
            /*BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Главная',
            ),*/
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Каталог',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Избранное',
            ),
          ],
          selectedItemColor: LayoutConstants.mainColor,
          currentIndex: _screenRouteToIndexMap[Globals.services.screen.getActiveScreen()] ?? 0,
          onTap: (index) {
            String? route = _indexToScreenRouteMap[index];

            if(route != null) {
              Globals.services.screen.moveScreen(context, route);
            }
          },
        )
    );
  }
}