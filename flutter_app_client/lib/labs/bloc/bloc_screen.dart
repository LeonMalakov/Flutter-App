import 'package:flutter/material.dart';
import 'package:flutter_app_client/labs/bloc/rgb_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'rgb_bloc.dart';
import 'rgb_event.dart';

class BlocScreen extends StatelessWidget {
  const BlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = RGBBloc();

    return BlocProvider(
        create: (context) => counterBloc,
        child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                BlocBuilder<RGBBloc, RGBState>(
                  builder: (context, state) {
                    if(state is RGBInitial) {
                      return const Text('Начальное состояние', style: TextStyle(fontSize: 24));
                    } else if(state is RGBActive) {
                      return Container(
                        width: 100,
                        height: 100,
                        color: Color.fromRGBO(state.value.r, state.value.g, state.value.b, 1),
                      );
                    }
                    return const Text('Ошибка', style: TextStyle(fontSize: 24));
                  },
                ),

                BlocBuilder<RGBBloc, RGBState>(
                  builder: (context, state) {
                    if(state is RGBInitial) {
                      return const Text('Жми кнопки чтобы начать', style: TextStyle(fontSize: 24));
                    } else if(state is RGBActive) {
                      return Text('R: ${state.value.r}, G: ${state.value.g}, B: ${state.value.b}', style: const TextStyle(fontSize: 24));
                    }
                    return const Text('Ошибка', style: TextStyle(fontSize: 24));
                  },
                ),

                ElevatedButton(
                  onPressed: () {
                    counterBloc.add(RGBEventAddR());
                  },
                  child: const Text('R+'),
                ),
                ElevatedButton(
                  onPressed: () {
                    counterBloc.add(RGBEventAddG());
                  },
                  child: const Text('G+'),
                ),
                ElevatedButton(
                  onPressed: () {
                    counterBloc.add(RGBEventAddB());
                  },
                  child: const Text('B+'),
                ),
              ],
            )
        )
    );
  }
}