import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/chart_widget.dart';
import 'package:flutter_application_1/cubit/complited_exercise_cubit.dart';
import 'package:flutter_application_1/cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/components/resolt_indicator_widget.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:gap/gap.dart';

List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
final List<int> total = [5, 5, 5, 5, 5, 5, 5];

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  int _completedForDay(Set<String> state, int dayIndex) {
    return state.where((key) => key.startsWith('$dayIndex-')).length;
  }

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;
    final user = userState.users.isNotEmpty ? userState.users.last : null;

    return BlocBuilder<CompletedExerciseCubit, Set<String>>(
      builder: (context, completedState) {
        final List<int> completed = List.generate(
          days.length,
          (i) => _completedForDay(completedState, i),
        );

        final int todayIndex = DateTime.now().weekday - 1;

        final int totalWorkouts = total.reduce((a, b) => a + b);
        final int totalCompleted = completed.reduce((a, b) => a + b);
        final int totalUncompleted = totalWorkouts - totalCompleted;

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Gap(20),
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: user?.imagePath != null
                      ? FileImage(File(user!.imagePath!))
                      : const AssetImage("assets/images/profile.jpg")
                            as ImageProvider,
                ),
              ),
              const Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user != null ? "${user.name} ${user.surname}" : "Guest",
                    style: KTextStyle.fitStyle,
                  ),
                  const Gap(5),
                ],
              ),
              const Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  resolIndicator(totalWorkouts, "Workouts"),
                  resolIndicator(totalCompleted, "Completed"),
                  resolIndicator(totalUncompleted, "Uncompleted"),
                ],
              ),
              const Gap(20),
              Center(
                child: FilledButton.tonal(
                  style: FilledButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey[200],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/edit_profile');
                  },
                  child: const Text("Edit Profile"),
                ),
              ),
              const Gap(5),
              const Divider(color: Color(0xFFE5E7EB)),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 4),
                child: Text(
                  "This week",
                  style: KTextStyle.fitnessStyle.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),

              // ✅ Line Chart
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 12,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(10, 14, 10, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 240,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return CustomPaint(
                              size: Size(constraints.maxWidth, 240),
                              painter: WeeklyChartPainter(
                                completed: completed,
                                total: total,
                                days: days,
                                todayIndex: todayIndex,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
