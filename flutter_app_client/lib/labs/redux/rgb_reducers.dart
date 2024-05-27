import 'package:flutter_app_client/labs/rgb_value.dart';

import 'rgb_actions.dart';

const int STEP = 16;

RGBValue rgbReducer(RGBValue state, dynamic action) {
  if (action is RGBActionAddR) {
    return RGBValue((state.r + STEP) % 256, state.g, state.b);
  } else if (action is RGBActionAddG) {
    return RGBValue(state.r, (state.g + STEP) % 256, state.b);
  } else if (action is RGBActionAddB) {
    return RGBValue(state.r, state.g, (state.b + STEP) % 256);
  }
  return state;
}