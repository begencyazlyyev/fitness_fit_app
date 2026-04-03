import 'package:flutter_bloc/flutter_bloc.dart';

class KgCounterCubit extends Cubit<int> {
  KgCounterCubit() : super(0);

  void increment() {
    emit(state + 1);
  }

  void decrement() {
    if (state > 0) {
      emit(state - 1);
    }
  }

  void setValue(int value) => emit(value);
}
