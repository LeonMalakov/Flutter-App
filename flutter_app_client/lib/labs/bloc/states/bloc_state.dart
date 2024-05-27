abstract class CounterState {
  const CounterState();
}

class CounterInitial extends CounterState {
  final int value;

  const CounterInitial(this.value);
}