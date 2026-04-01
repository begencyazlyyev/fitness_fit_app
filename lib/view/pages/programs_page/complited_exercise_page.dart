// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/completed_widget.dart';
import 'package:flutter_application_1/components/selection_widget.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:flutter_application_1/cubit/complited_exercise_cubit.dart';
import 'package:flutter_application_1/cubit/programs_cubit.dart';
import 'package:flutter_application_1/models/programs_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ComplitedExercisePage extends StatelessWidget {
  const ComplitedExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    final ex = args["exercise"] as ProgramExercise;
    final int dayIndex = args["dayIndex"];
    final int exerciseIndex = args["exerciseIndex"];

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.grey.withOpacity(0.6),
        scrolledUnderElevation: 1.5,
        centerTitle: true,
        title: Text(ex.title, style: KTextStyle.titleStyle),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 310,
              child: Image.asset(ex.image),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Workout type",
                        style: KTextStyle.titleStyle.copyWith(fontSize: 18),
                      ),
                      Text(
                        ex.category,
                        style: KTextStyle.titleStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const Gap(40),
                  CompletedWidget(
                    workout: "When lifting",
                    weight: ex.kg,
                    type: "  kg  ",
                  ),
                  Gap(20),
                  CompletedWidget(
                    workout: "Till tired, I can do",
                    weight: ex.reps,
                    type: "Reps",
                  ),
                  Gap(20),

                  CompletedWidget(
                    workout: "For each exercise",
                    weight: ex.sets,
                    type: "Sets",
                  ),
                  Gap(20),

                  const Gap(40),

                  // ← changed both references below
                  BlocBuilder<CompletedExerciseCubit, Set<String>>(
                    builder: (context, state) {
                      final isCompleted = state.contains(
                        '$dayIndex-$exerciseIndex',
                      );

                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: isCompleted
                                ? Colors.white
                                : const Color(0xFF4D9B91),
                            disabledBackgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: isCompleted
                              ? null
                              : () {
                                  context
                                      .read<
                                        CompletedExerciseCubit
                                      >() // ← changed
                                      .markCompleted(dayIndex, exerciseIndex);
                                },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Gap(8),
                              Text(
                                isCompleted
                                    ? "Completed!"
                                    : "Mark as Completed",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isCompleted
                                      ? Color(0xFF02542D)
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const Gap(20),
                ],
              ),
            ),

            BlocBuilder<CompletedExerciseCubit, Set<String>>(
              builder: (context, state) {
                final isCompleted = state.contains('$dayIndex-$exerciseIndex');
                return Center(
                  child: isCompleted
                      ? TextButton(
                          onPressed: () {
                            context
                                .read<CompletedExerciseCubit>()
                                .unmarkCompleted(dayIndex, exerciseIndex);
                          },
                          child: Text(
                            "Unmark",
                            style: KTextStyle.solidText.copyWith(
                              color: Color(0xFF4285F4),
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            context.read<ProgramsCubit>().removeExercise(
                              dayIndex,
                              exerciseIndex,
                            );
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Delete",
                            style: KTextStyle.solidText.copyWith(
                              color: Color(0xFFEA4335),
                            ),
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
