import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedExerciseCubit extends Cubit<Set<String>> {
  CompletedExerciseCubit() : super({});

  // Creates a unique key per exercise
  String _key(int dayIndex, int exerciseIndex) => '$dayIndex-$exerciseIndex';

  void markCompleted(int dayIndex, int exerciseIndex) {
    emit({...state, _key(dayIndex, exerciseIndex)});
  }

  bool isCompleted(int dayIndex, int exerciseIndex) {
    return state.contains(_key(dayIndex, exerciseIndex));
  }

  void unmarkCompleted(int dayIndex, int exerciseIndex) {
    emit({...state}..remove('$dayIndex-$exerciseIndex'));
  }
}
