import 'package:flutter_bloc/flutter_bloc.dart';

class RepsConterCubit extends Cubit<int> {
  RepsConterCubit() : super(0);

  void increment() {
    emit(state + 1);
  }

  void decrement() {
    if (state > 0) {
      emit(state - 1);
    }
  }
}
