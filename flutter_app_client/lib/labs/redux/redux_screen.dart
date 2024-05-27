import 'package:flutter/material.dart';
import 'package:flutter_app_client/globals.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'actions.dart';
import 'reducers.dart';

class ReduxScreen extends StatelessWidget {
  const ReduxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Store<int>(counterReducer, initialState: 0);

    return StoreProvider(
        store: store,
        child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StoreConnector<int, String>(
                  converter: (store) => store.state.toString(),
                  builder: (context, count) {
                    return Text(
                      'Счетчик: ${count}',
                      style: const TextStyle(fontSize: 24),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    store.dispatch(IncrementAction());
                  },
                  child: Text('+'),
                ),
                ElevatedButton(
                  onPressed: () {
                    store.dispatch(DecrementAction());
                  },
                  child: Text('-'),
                ),
              ],
            )
        )
    );
  }
}