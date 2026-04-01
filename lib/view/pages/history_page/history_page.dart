// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:flutter_application_1/cubit/complited_exercise_cubit.dart';
import 'package:flutter_application_1/cubit/programs_cubit.dart';
import 'package:flutter_application_1/models/programs_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final int selectedDayIndex = (_selectedDay ?? DateTime.now()).weekday - 1;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.grey.withOpacity(0.6),
                  offset: const Offset(0, 2),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
          ),
        ),
        Gap(10),
        // Exercise count
        BlocBuilder<ProgramsCubit, Map<int, List<ProgramExercise>>>(
          builder: (context, programsMap) {
            final exercises = programsMap[selectedDayIndex] ?? [];
            return Padding(
              padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${exercises.length} exercises",
                  style: KTextStyle.solidBold,
                ),
              ),
            );
          },
        ),

        // Exercise list
        BlocBuilder<ProgramsCubit, Map<int, List<ProgramExercise>>>(
          builder: (context, programsMap) {
            final exercises = programsMap[selectedDayIndex] ?? [];

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

                  // TODO changes here
                  return Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
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
                              offset: const Offset(0, 2),
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            // Image Container
                            Container(
                              margin: const EdgeInsets.all(8),
                              width: 110,
                              height: 110,
                              color: Colors.grey,
                              child: Image.asset(ex.image, fit: BoxFit.cover),
                            ),
                            Gap(10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    ex.title,
                                    style: KTextStyle.fitStyle.copyWith(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    height: 2,
                                    width: 210,
                                    color: const Color(0xFFE5E7EB),
                                  ),
                                  Text(
                                    ex.category,
                                    style: KTextStyle.fitnessStyle.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8.0,
                                        ),
                                        child: Text("${ex.kg} /kg"),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Text(":"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8.0,
                                        ),
                                        child: Text("${ex.reps} /reps"),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 8.0),
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
                      BlocBuilder<CompletedExerciseCubit, Set<String>>(
                        builder: (context, state) {
                          final isCompleted = state.contains(
                            '$selectedDayIndex-$index',
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
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color(0xFF219653).withOpacity(0.2),
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
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color(0xFFFBA13A).withOpacity(0.2),
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
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
