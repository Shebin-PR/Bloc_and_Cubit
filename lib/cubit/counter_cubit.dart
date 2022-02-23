import 'package:bloc/bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterStates(counterValue: 0));

  void increment() {
    emit(CounterStates(counterValue: state.counterValue + 1,wasIncremented: true));
  }

  void decrement() {
    emit(CounterStates(counterValue: state.counterValue - 1,wasIncremented: false));
  }
}
