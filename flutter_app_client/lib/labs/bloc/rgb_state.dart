import 'package:flutter_app_client/labs/rgb_value.dart';

abstract class RGBState {
  const RGBState();
}

class RGBInitial extends RGBState {
  const RGBInitial();
}

class RGBActive extends RGBState {
  final RGBValue value;

  const RGBActive(this.value);
}