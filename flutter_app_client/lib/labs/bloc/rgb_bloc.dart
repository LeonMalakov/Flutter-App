import 'package:flutter_app_client/labs/bloc/rgb_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../rgb_value.dart';
import 'rgb_event.dart';

class RGBBloc extends Bloc<RGBEvent, RGBState> {
  static const int STEP = 16;

  RGBBloc() : super(const RGBInitial()) {

    on<RGBEventAddR>((event, emit) {
      final value = state is RGBActive ? (state as RGBActive).value : RGBValue(0, 0, 0);
      emit(RGBActive(RGBValue((value.r + STEP) % 256, value.g, value.b)));
    });

    on<RGBEventAddG>((event, emit) {
      final value = state is RGBActive ? (state as RGBActive).value : RGBValue(0, 0, 0);
      emit(RGBActive(RGBValue(value.r, (value.g + STEP) % 256, value.b)));
    });

    on<RGBEventAddB>((event, emit) {
      final value = state is RGBActive ? (state as RGBActive).value : RGBValue(0, 0, 0);
      emit(RGBActive(RGBValue(value.r, value.g, (value.b + STEP) % 256)));
    });
  }
}