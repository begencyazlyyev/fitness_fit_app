import 'exercise_model.dart';

class BookmarkState {
  final List<Exercise> bookmarkedExercises;

  BookmarkState({required this.bookmarkedExercises});

  // Initial state helper
  factory BookmarkState.initial() => BookmarkState(bookmarkedExercises: []);
}
