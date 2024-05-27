import 'package:flutter/material.dart';
import 'package:flutter_app_client/globals.dart';
import 'package:flutter_app_client/labs/bloc/states/bloc_state.dart';
import 'package:flutter_app_client/screens/widgets/auth_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'events/bloc_event.dart';

class BlocScreen extends StatelessWidget {
  const BlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = CounterBloc();

    return BlocProvider(
        create: (context) => counterBloc,
        child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<CounterBloc, CounterState>(
                  builder: (context, state) {
                    final value = state is CounterInitial ? state.value : 0;
                    return Text(
                      'Счетчик: ${value}',
                      style: const TextStyle(fontSize: 24),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    counterBloc.add(BlocEventA());
                  },
                  child: Text('+'),
                ),
                ElevatedButton(
                  onPressed: () {
                    counterBloc.add(BlocEventB());
                  },
                  child: Text('-'),
                ),
              ],
            )
        )
    );
  }
}