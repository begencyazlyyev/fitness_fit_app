import 'package:flutter_application_1/models/programs_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgramsCubit extends Cubit<Map<int, List<ProgramExercise>>> {
  ProgramsCubit() : super({});

  // dayIndex = 0 (Mon) to 6 (Sun)
  void addExercise(int dayIndex, ProgramExercise exercise) {
    final updated = Map<int, List<ProgramExercise>>.from(state);
    final dayList = List<ProgramExercise>.from(updated[dayIndex] ?? []);
    dayList.add(exercise);
    updated[dayIndex] = dayList;
    emit(updated);
  }

  List<ProgramExercise> getExercisesForDay(int dayIndex) {
    return state[dayIndex] ?? [];
  }

  void removeExercise(int dayIndex, int exerciseIndex) {
    final updated = Map<int, List<ProgramExercise>>.from(state);
    final list = List<ProgramExercise>.from(updated[dayIndex] ?? []);
    list.removeAt(exerciseIndex);
    updated[dayIndex] = list;
    emit(updated);
  }

  void updateExercise(
    int dayIndex,
    int exerciseIndex,
    ProgramExercise updated,
  ) {
    final newState = Map<int, List<ProgramExercise>>.from(state);
    final list = List<ProgramExercise>.from(newState[dayIndex] ?? []);
    list[exerciseIndex] = updated;
    newState[dayIndex] = list;
    emit(newState);
  }
}
