import 'package:flutter_app_client/labs/bloc/states/bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events/bloc_event.dart';

class CounterBloc extends Bloc<BlocEvent, CounterState> {
  CounterBloc() : super(const CounterInitial(0)) {
    on<BlocEventA>((event, emit) {
      final newValue = state is CounterInitial ? (state as CounterInitial).value + 1 : 1;
      emit(CounterInitial(newValue));
    });

    on<BlocEventB>((event, emit) {
      final newValue = state is CounterInitial ? (state as CounterInitial).value - 1 : -1;
      emit(CounterInitial(newValue));
    });
  }
}