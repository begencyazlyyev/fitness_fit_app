import 'package:flutter_application_1/models/bookmark_state.dart';
import 'package:flutter_application_1/models/exercise_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkState.initial());

  void toggleBookmark(Exercise exercise) {
    final currentList = List<Exercise>.from(state.bookmarkedExercises);

    if (currentList.contains(exercise)) {
      currentList.remove(exercise);
    } else {
      currentList.add(exercise);
    }

    emit(BookmarkState(bookmarkedExercises: currentList));
  }
}
