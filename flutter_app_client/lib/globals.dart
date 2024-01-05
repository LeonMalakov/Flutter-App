import 'package:flutter_app_client/services/auth_service.dart';
import 'package:flutter_app_client/services/boarding_service.dart';
import 'package:flutter_app_client/services/fake_remote_api_requester.dart';
import 'package:flutter_app_client/services/i_remote_api_requester.dart';
import 'package:flutter_app_client/services/item_collection_service.dart';
import 'package:flutter_app_client/services/item_operations_service.dart';
import 'package:flutter_app_client/services/screen_service.dart';

import 'factories/item_popup_factory.dart';

class Globals {
  static final services = Services();
  static final factories = Factories();
}

class Services {
  final auth = AuthService();
  final screen = ScreenService();
  final itemCollection = ItemCollectionService();
  final itemOperations = ItemOperationsService();
  final IRemoteApiRequester remoteApiRequester = FakeRemoteApiRequester();
  final boarding = BoardingService();
}

class Factories {
  final itemPopup = ItemPopupFactory();
}