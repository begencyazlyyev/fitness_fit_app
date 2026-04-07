// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button_widget.dart';
import 'package:flutter_application_1/components/selection_widget.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:flutter_application_1/components/textbutton_widget.dart';
import 'package:flutter_application_1/cubit/kg_counter_cubit.dart';
import 'package:flutter_application_1/cubit/programs_cubit.dart';
import 'package:flutter_application_1/cubit/reps_counter_cubit.dart';
import 'package:flutter_application_1/cubit/sets_counter_cubit.dart';
import 'package:flutter_application_1/data/notifiers.dart';
import 'package:flutter_application_1/models/programs_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

const double spaceGap = 40;

class ProgramSelectionPage extends StatelessWidget {
  const ProgramSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    final String category = args is Map && args["category"] != null
        ? args["category"]
        : "Not Found";

    final String image = (args is Map && args["image"] != null)
        ? args["image"]
        : "assets/placeholder.png";

    final String title = args is Map && args["title"] != null
        ? args["title"]
        : "Unknown";

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => KgCounterCubit()),
        BlocProvider(create: (_) => RepsConterCubit()),
        BlocProvider(create: (_) => SetsCounterCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.grey.withOpacity(0.6),
          scrolledUnderElevation: 1.5,
          centerTitle: true,
          title: Text("Program selection", style: KTextStyle.titleStyle),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                height: 310,
                child: Image.asset(image),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Builder(
                  builder: (context) {
                    final counterKg = context.watch<KgCounterCubit>().state;
                    final counterReps = context.watch<RepsConterCubit>().state;
                    final counterSets = context.watch<SetsCounterCubit>().state;
                    return Column(
                      children: [
                        //* Workout type
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Workout type",
                              style: KTextStyle.titleStyle.copyWith(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              category,
                              style: KTextStyle.titleStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Gap(spaceGap),
                        //* When lifting
                        SelectionWidget(
                          workout: "When lifting",
                          weight: counterKg,
                          type: "  kg  ",
                          arrowUp: () =>
                              context.read<KgCounterCubit>().increment(),
                          arrowDown: () =>
                              context.read<KgCounterCubit>().decrement(),
                        ),
                        Gap(spaceGap),
                        // Till I can do
                        SelectionWidget(
                          workout: "Till tired, I can do",
                          weight: counterReps,
                          type: "Reps",
                          arrowUp: () =>
                              context.read<RepsConterCubit>().increment(),
                          arrowDown: () =>
                              context.read<RepsConterCubit>().decrement(),
                        ),
                        Gap(spaceGap),
                        // Quantity of sets
                        SelectionWidget(
                          workout: "For each exercise",
                          weight: counterSets,
                          type: "Sets",
                          arrowUp: () {
                            context.read<SetsCounterCubit>().increment();
                          },
                          arrowDown: () {
                            context.read<SetsCounterCubit>().decrement();
                          },
                        ),
                        Gap(10),

                        Stack(
                          children: [
                            ButtonWidget(
                              paddingLeft: 0,
                              paddingRight: 0,
                              label: "Add to Programs",
                              onPressed: () {
                                if (counterKg == 0 ||
                                    counterReps == 0 ||
                                    counterSets == 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        counterKg == 0
                                            ? "Please set a weight (kg) before adding."
                                            : counterReps == 0
                                            ? "Please set the number of reps before adding."
                                            : "Please set the number of sets before adding.",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: const Color(0xFFEA4335),
                                      behavior: SnackBarBehavior.floating,
                                      duration: const Duration(seconds: 2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                  return; // Stop execution, don't add exercise
                                }

                                final exercise = ProgramExercise(
                                  title: title,
                                  category: category,
                                  image: image,
                                  kg: counterKg,
                                  reps: counterReps,
                                  sets: counterSets,
                                );

                                final today = DateTime.now().weekday - 1;
                                context.read<ProgramsCubit>().addExercise(
                                  today,
                                  exercise,
                                );
                              },
                            ),
                            Positioned(
                              top: 30,
                              right: 60,
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.white,
                                child: Center(
                                  child: Text(
                                    "${context.watch<ProgramsCubit>().state.values.fold(0, (sum, list) => sum + list.length)}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        ValueListenableBuilder(
                          valueListenable: selectedPageNotifier,
                          builder: (context, int selectedPage, child) {
                            return textbuttonWidget(() {
                              selectedPageNotifier.value = 1;
                              Navigator.of(
                                context,
                              ).popUntil((route) => route.isFirst);
                            }, "Go to Programs >");
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
