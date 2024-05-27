import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_client/globals.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'counter_widget_model.dart';

class CounterWidget extends ElementaryWidget<CounterWidgetModel> {
  const CounterWidget({Key? key}) : super(createCounterWidgetModel, key: key);

  @override
  Widget build(CounterWidgetModel wm) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          ValueListenableBuilder<int>(
            valueListenable: wm.counterState,
            builder: (context, counter, child) {
              return Text(
                '$counter',
                style: Theme.of(context).textTheme.headline4,
              );
            },
          ),
          ElevatedButton(
            onPressed: wm.increment,
            child: Text('+'),
          ),
          ElevatedButton(
            onPressed: wm.decrement,
            child: Text('-'),
          ),
        ],
      ),
    );
  }
}