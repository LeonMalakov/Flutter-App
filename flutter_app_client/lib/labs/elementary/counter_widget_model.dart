import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'counter_model.dart';
import 'counter_widget.dart';

class CounterWidgetModel extends WidgetModel<CounterWidget, CounterModel> {
  final counterState = ValueNotifier<int>(0);

  CounterWidgetModel(CounterModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    counterState.value = model.counter;
  }

  void increment() {
    model.increment();
    counterState.value = model.counter;
  }

  void decrement() {
    model.decrement();
    counterState.value = model.counter;
  }
}

CounterWidgetModel createCounterWidgetModel(BuildContext context) {
  return CounterWidgetModel(CounterModel());
}