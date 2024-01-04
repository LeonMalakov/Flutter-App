import 'package:flutter/cupertino.dart';
import 'package:flutter_app_client/app_layout.dart';

import '../screens/item_popup.dart';

class ItemPopupFactory {
  Widget create(ItemPopupArgs args) {
    return AppLayout(childWidget: ItemPopup(args: args));
  }
}