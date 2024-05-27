import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import '../rgb_value.dart';
import 'rgb_model.dart';
import 'rgb_widget.dart';

class RGBBinder extends WidgetModel<RGBWidget, RGBModel> {
  final state = ValueNotifier<RGBValue>(RGBValue(0, 0, 0));

  RGBBinder(RGBModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    updateState();
  }

  void addR() {
    model.addR();
    updateState();
  }

  void addG() {
    model.addG();
    updateState();
  }

  void addB() {
    model.addB();
    updateState();
  }

  void updateState(){
    state.value = RGBValue(model.r, model.g, model.b);
  }
}

RGBBinder createCounterWidgetModel(BuildContext context) {
  return RGBBinder(RGBModel());
}