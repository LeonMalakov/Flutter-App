import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../rgb_value.dart';
import 'rgb_binder.dart';

class RGBWidget extends ElementaryWidget<RGBBinder> {
  const RGBWidget({Key? key}) : super(createCounterWidgetModel, key: key);

  @override
  Widget build(RGBBinder wm) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ValueListenableBuilder<RGBValue>(
            valueListenable: wm.state,
            builder: (context, state, child) {
              return Container(
                width: 100,
                height: 100,
                color: Color.fromRGBO(state.r, state.g, state.b, 1),
              );
            },
          ),
          ValueListenableBuilder<RGBValue>(
            valueListenable: wm.state,
            builder: (context, state, child) {
              return Text(
                '${state.r} ${state.g} ${state.b}',
                style: Theme.of(context).textTheme.headline4,
              );
            },
          ),
          ElevatedButton(
            onPressed: wm.addR,
            child: const Text('R+'),
          ),
          ElevatedButton(
            onPressed: wm.addG,
            child: const Text('G+'),
          ),
          ElevatedButton(
            onPressed: wm.addB,
            child: const Text('B+'),
          ),
        ],
      ),
    );
  }
}