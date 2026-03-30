import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/bookmark_cubit.dart';
import 'package:flutter_application_1/models/bookmark_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Adjust these imports to your project structure

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkCubit, BookmarkState>(
      builder: (context, state) {
        // Show a message if no exercises are bookmarked
        if (state.bookmarkedExercises.isEmpty) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Center(child: Text("No bookmarked exercises yet.")),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              shrinkWrap:
                  true, // Crucial: allows GridView to live inside a Column
              physics:
                  const NeverScrollableScrollPhysics(), // Let the parent scroll
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                crossAxisCount: 2,
                childAspectRatio: 0.70,
              ),
              itemCount: state.bookmarkedExercises.length,
              itemBuilder: (context, index) {
                final exercise = state.bookmarkedExercises[index];
                //* Main container starts here
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/exercise_details',
                      arguments: {
                        "title": exercise.title,
                        "subtitle": exercise.category,
                        "image": exercise.image,
                      }, //! Argumets passed here
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9ECF3),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Colors.grey.shade400,
                          spreadRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //* Image Section
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 184,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.asset(
                                  exercise.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            Positioned(
                              top: 8,
                              left: 8,
                              child: GestureDetector(
                                onTap: () {
                                  // Toggling here will remove it from the list
                                  context.read<BookmarkCubit>().toggleBookmark(
                                    exercise,
                                  );
                                },
                                child: const Icon(
                                  Icons.bookmark,
                                  size: 28,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),

                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 8),
                          visualDensity: const VisualDensity(vertical: -2),
                          title: Text(
                            exercise.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(exercise.category),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
