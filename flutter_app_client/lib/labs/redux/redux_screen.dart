import 'package:flutter/material.dart';
import 'package:flutter_app_client/labs/rgb_value.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'rgb_actions.dart';
import 'rgb_reducers.dart';

class ReduxScreen extends StatelessWidget {
  const ReduxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Store<RGBValue>(rgbReducer, initialState: RGBValue(0, 0, 0));

    return StoreProvider(
        store: store,
        child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                StoreConnector<RGBValue, RGBValue>(
                  converter: (store) => store.state,
                  builder: (context, state) {
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Container(
                            width: 100,
                            height: 100,
                            color: Color.fromRGBO(state.r, state.g, state.b, 1),
                          ),

                          Text(
                            '${state.r} ${state.g} ${state.b}', style: const TextStyle(fontSize: 24),
                          ),

                        ],
                      ),
                    );
                  },
                ),

                ElevatedButton(
                  onPressed: () {
                    store.dispatch(RGBActionAddR());
                  },
                  child: const Text('R+'),
                ),
                ElevatedButton(
                  onPressed: () {
                    store.dispatch(RGBActionAddG());
                  },
                  child: const Text('G+'),
                ),
                ElevatedButton(
                  onPressed: () {
                    store.dispatch(RGBActionAddB());
                  },
                  child: const Text('B+'),
                ),
              ],
            )
        )
    );
  }
}