// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:flutter_application_1/cubit/complited_exercise_cubit.dart';
import 'package:flutter_application_1/cubit/programs_cubit.dart';
import 'package:flutter_application_1/models/programs_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProgramsPage extends StatefulWidget {
  const ProgramsPage({super.key});

  @override
  State<ProgramsPage> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage> {
  int daysIndex = 0;
  int todayIndex = 0;
  late List<DateTime> currentWeek;

  @override
  void initState() {
    super.initState();
    _generateAndSelectCurrentWeek();
  }

  void _generateAndSelectCurrentWeek() {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    final DateTime monday = today.subtract(Duration(days: today.weekday - 1));

    currentWeek = List.generate(7, (i) => monday.add(Duration(days: i)));

    todayIndex = currentWeek.indexWhere(
      (d) =>
          d.year == today.year && d.month == today.month && d.day == today.day,
    );

    daysIndex = todayIndex.clamp(0, 6);
  }

  String getWeekdayName(int weekday) {
    return ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(currentWeek.length, (index) {
                final DateTime date = currentWeek[index];
                final bool isSelected = daysIndex == index;
                final bool isToday = todayIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      daysIndex = index;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          getWeekdayName(date.weekday),
                          style: TextStyle(
                            color: isSelected ? Colors.blue : Colors.grey,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${date.day}",
                          style: TextStyle(
                            color: isSelected ? Colors.blue : Colors.black,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (isToday || isSelected)
                                ? Colors.blue
                                : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const Divider(color: Color(0xFFE5E7EB)),

            // ✅ Dynamic exercise count
            BlocBuilder<ProgramsCubit, Map<int, List<ProgramExercise>>>(
              builder: (context, programsMap) {
                final exercises = programsMap[daysIndex] ?? [];
                return Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                  child: Text(
                    "${exercises.length} exercises",
                    style: KTextStyle.solidBold,
                  ),
                );
              },
            ),

            // ✅ Dynamic exercise list
            BlocBuilder<ProgramsCubit, Map<int, List<ProgramExercise>>>(
              builder: (context, programsMap) {
                final exercises = programsMap[daysIndex] ?? [];

                if (exercises.isEmpty) {
                  return const Expanded(
                    child: Center(child: Text("No exercises for this day")),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final ex = exercises[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/exercise_detail',
                            arguments: {
                              "exercise": ex,
                              "dayIndex": daysIndex,
                              "exerciseIndex": index,
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: 15,
                                right: 15,
                                top: 8,
                                bottom: 8,
                              ),
                              width: double.infinity,
                              height: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    color: Colors.grey.withOpacity(0.6),
                                    offset: Offset(0, 2),
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: <Widget>[
                                  // Image Container
                                  Container(
                                    margin: EdgeInsets.all(8),
                                    width: 110,
                                    height: 110,
                                    color: Colors.grey,
                                    child: Image.asset(
                                      ex.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Gap(10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          ex.title,
                                          style: KTextStyle.fitStyle.copyWith(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: 5,
                                          ),
                                          height: 2,
                                          width: 210,
                                          color: Color(0xFFE5E7EB),
                                        ),
                                        Text(
                                          ex.category,
                                          style: KTextStyle.fitnessStyle
                                              .copyWith(fontSize: 16),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 8.0,
                                              ),
                                              child: Text("${ex.kg} /kg"),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 8.0,
                                              ),
                                              child: Text(":"),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 8.0,
                                              ),
                                              child: Text("${ex.reps} /reps"),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 8.0,
                                              ),
                                              child: Text(":"),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 8.0,
                                              ),
                                              child: Text("${ex.sets} /sets"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //! Status Indicator
                            BlocBuilder<CompletedExerciseCubit, Set<String>>(
                              builder: (context, state) {
                                final isCompleted = state.contains(
                                  '$daysIndex-$index',
                                );
                                return Positioned(
                                  top: 20,
                                  right: 40,

                                  child: isCompleted
                                      ? Container(
                                          width: 34,
                                          height: 15,
                                          alignment: Alignment
                                              .centerLeft, // ← add this to position dot
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                            color: Color(
                                              0xFF219653,
                                            ).withOpacity(0.2),
                                          ),
                                          child: Center(
                                            child: Container(
                                              width: 6,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFF4D9B91),
                                              ),
                                            ),
                                          ),
                                        )
                                      // Second Container
                                      : Container(
                                          width: 34,
                                          height: 15,
                                          alignment: Alignment
                                              .centerLeft, // ← add this to position dot
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                            color: Color(
                                              0xFFFBA13A,
                                            ).withOpacity(0.2),
                                          ),
                                          child: Center(
                                            child: Container(
                                              width: 6,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFFFBA13A),
                                              ),
                                            ),
                                          ),
                                        ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
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
