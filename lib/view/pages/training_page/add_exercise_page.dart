import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:flutter_application_1/cubit/bookmark_cubit.dart';
import 'package:flutter_application_1/models/bookmark_state.dart';
import 'package:flutter_application_1/models/exercise_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddExercisePage extends StatefulWidget {
  const AddExercisePage({super.key});

  @override
  State<AddExercisePage> createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  int selectedIndex = 0;

  final List<String> categoryImages = [
    "assets/svg/chest_b.svg",
    "assets/svg/back_b.svg",
    "assets/svg/biceps_b.svg",
    "assets/svg/triceps_b.svg",
    "assets/svg/shoulders_b.svg",
    "assets/svg/waist_b.svg",
    "assets/svg/neck_b.svg",
    "assets/svg/upper-arm_b.svg",
    "assets/svg/forearms_b.svg",
    "assets/svg/quadriceps_b.svg",
    "assets/svg/hamstrings_b.svg",
    "assets/svg/hips_b.svg",
    "assets/svg/calves_b.svg",
  ];

  final List<String> categories = [
    "Chest",
    "Back",
    "Biceps",
    "Triceps",
    "Shoulder",
    "Waist",
    "Neck",
    "Upper Arm",
    "Forearm",
    "Quadriceps",
    "Hamstrings",
    "Hips",
    "Calves",
  ];

  //* Temporary files

  final List<String> exerciseImages = [
    "assets/images/bench-press.jpg",
    "assets/images/lever-seated-fly.jpg",
    "assets/images/incline-bench-press.jpg",
  ];

  final List<String> exerciseTitles = [
    "Bench Press",
    "Lever Seated Fly",
    "Incline Bench Press",
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      int index = categories.indexOf(args);
      if (index != -1) {
        setState(() {
          selectedIndex = index;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final String categoryTitle =
    //     ModalRoute.of(context)?.settings.arguments as String? ?? "Unknown";
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        titleSpacing: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close, size: 30, color: Color(0xFF111928)),
        ),
        title: Text("Add Exersices", style: KTextStyle.titleStyle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categoryImages.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        border: selectedIndex == index
                            ? Border.all(color: Color(0xFF4B5563), width: 1.2)
                            : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                        categoryImages[index],
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const Divider(color: Color(0xFFE5E7EB)),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 4.0, bottom: 4.0),
            child: Text(
              "${categories[selectedIndex]} Exersices",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4B5563),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                crossAxisCount: 2,
                childAspectRatio: 0.70,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                final currentExercise = Exercise(
                  title: exerciseTitles[index % exerciseTitles.length],
                  category: categories[selectedIndex],
                  image: exerciseImages[index % exerciseImages.length],
                );

                return BlocBuilder<BookmarkCubit, BookmarkState>(
                  builder: (context, state) {
                    final isBookmarked = state.bookmarkedExercises.contains(
                      currentExercise,
                    );

                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/exercise_details',
                          arguments: {
                            "title": currentExercise.title,
                            "subtitle": currentExercise.category,
                            "image": currentExercise.image,
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE9ECF3),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              color: Colors.grey.shade400,
                              spreadRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //* inside image container
                            SizedBox(
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  AspectRatio(
                                    aspectRatio:
                                        195 /
                                        184, // keeps your original proportions
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: Image.asset(
                                        exerciseImages[index %
                                            exerciseImages.length],
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // The Bookmark Icon
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        context
                                            .read<BookmarkCubit>()
                                            .toggleBookmark(currentExercise);
                                      },
                                      child: Icon(
                                        isBookmarked
                                            ? Icons.bookmark
                                            : Icons.bookmark_outline,
                                        size: 28,
                                        color: isBookmarked
                                            ? Colors.black
                                            : Colors.black54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //* second content text
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 8),
                              visualDensity: VisualDensity(vertical: -2),
                              title: Text(
                                exerciseTitles[index % exerciseTitles.length],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(categories[selectedIndex]),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
