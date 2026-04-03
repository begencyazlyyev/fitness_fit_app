// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/completed_widget.dart';
import 'package:flutter_application_1/components/selection_widget.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:flutter_application_1/cubit/complited_exercise_cubit.dart';
import 'package:flutter_application_1/cubit/kg_counter_cubit.dart';
import 'package:flutter_application_1/cubit/programs_cubit.dart';
import 'package:flutter_application_1/cubit/reps_counter_cubit.dart';
import 'package:flutter_application_1/cubit/sets_counter_cubit.dart';
import 'package:flutter_application_1/models/programs_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ComplitedExercisePage extends StatefulWidget {
  const ComplitedExercisePage({super.key});

  @override
  State<ComplitedExercisePage> createState() => _ComplitedExercisePageState();
}

class _ComplitedExercisePageState extends State<ComplitedExercisePage> {
  bool _isEditing = false;

  late final KgCounterCubit _kgCubit;
  late final RepsConterCubit _repsCubit;
  late final SetsCounterCubit _setsCubit;

  late ProgramExercise _ex;
  late int _dayIndex;
  late int _exerciseIndex;
  bool _argsInitialized = false;

  @override
  void initState() {
    super.initState();
    _kgCubit = KgCounterCubit();
    _repsCubit = RepsConterCubit();
    _setsCubit = SetsCounterCubit();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_argsInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments as Map;
      _ex = args["exercise"] as ProgramExercise;
      _dayIndex = args["dayIndex"];
      _exerciseIndex = args["exerciseIndex"];
      _argsInitialized = true;
    }
  }

  void _enterEditMode() {
    _kgCubit.setValue(_ex.kg);
    _repsCubit.setValue(_ex.reps);
    _setsCubit.setValue(_ex.sets);
    setState(() => _isEditing = true);
  }

  void _saveChanges() {
    final updated = ProgramExercise(
      title: _ex.title,
      category: _ex.category,
      image: _ex.image,
      kg: _kgCubit.state,
      reps: _repsCubit.state,
      sets: _setsCubit.state,
    );
    context.read<ProgramsCubit>().updateExercise(
      _dayIndex,
      _exerciseIndex,
      updated,
    );
    setState(() {
      _ex = updated;
      _isEditing = false;
    });
  }

  void _cancelEdit() {
    setState(() => _isEditing = false);
  }

  @override
  void dispose() {
    _kgCubit.close();
    _repsCubit.close();
    _setsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _kgCubit),
        BlocProvider.value(value: _repsCubit),
        BlocProvider.value(value: _setsCubit),
      ],
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.grey.withOpacity(0.6),
          scrolledUnderElevation: 1.5,
          centerTitle: true,
          title: Text(_ex.title, style: KTextStyle.titleStyle),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: IconButton(
                // ← greyed out while editing, active otherwise
                onPressed: _isEditing ? null : _enterEditMode,
                icon: Icon(
                  Icons.edit_note_sharp,
                  size: 35,
                  color: _isEditing ? Colors.grey.withOpacity(0.4) : null,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 310,
                child: Image.asset(_ex.image),
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
                          _ex.category,
                          style: KTextStyle.titleStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Gap(40),

                    // Kg row
                    _isEditing
                        ? BlocBuilder<KgCounterCubit, int>(
                            builder: (context, kg) => SelectionWidget(
                              workout: "When lifting",
                              weight: kg,
                              type: "  kg  ",
                              arrowUp: () => _kgCubit.increment(),
                              arrowDown: () => _kgCubit.decrement(),
                            ),
                          )
                        : CompletedWidget(
                            workout: "When lifting",
                            weight: _ex.kg,
                            type: "  kg  ",
                          ),
                    const Gap(20),

                    // Reps row
                    _isEditing
                        ? BlocBuilder<RepsConterCubit, int>(
                            builder: (context, reps) => SelectionWidget(
                              workout: "Till tired, I can do",
                              weight: reps,
                              type: "Reps",
                              arrowUp: () => _repsCubit.increment(),
                              arrowDown: () => _repsCubit.decrement(),
                            ),
                          )
                        : CompletedWidget(
                            workout: "Till tired, I can do",
                            weight: _ex.reps,
                            type: "Reps",
                          ),
                    const Gap(20),

                    // Sets row
                    _isEditing
                        ? BlocBuilder<SetsCounterCubit, int>(
                            builder: (context, sets) => SelectionWidget(
                              workout: "For each exercise",
                              weight: sets,
                              type: "Sets",
                              arrowUp: () => _setsCubit.increment(),
                              arrowDown: () => _setsCubit.decrement(),
                            ),
                          )
                        : CompletedWidget(
                            workout: "For each exercise",
                            weight: _ex.sets,
                            type: "Sets",
                          ),
                    const Gap(20),
                    const Gap(40),

                    // ← Bottom button: morphs between Mark as Completed and Save/Cancel
                    BlocBuilder<CompletedExerciseCubit, Set<String>>(
                      builder: (context, state) {
                        final isCompleted = state.contains(
                          '$_dayIndex-$_exerciseIndex',
                        );

                        if (_isEditing) {
                          return Column(
                            children: <Widget>[
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: isCompleted
                                        ? Colors.white
                                        : const Color(0xFF6495ED),
                                    disabledBackgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: _saveChanges,
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(20),
                              Center(
                                child: TextButton(
                                  onPressed: _cancelEdit,
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        // Normal mode — Mark as Completed
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
                                        .read<CompletedExerciseCubit>()
                                        .markCompleted(
                                          _dayIndex,
                                          _exerciseIndex,
                                        );
                                  },
                            child: Text(
                              isCompleted ? "Completed!" : "Mark as Completed",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isCompleted
                                    ? const Color(0xFF02542D)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const Gap(20),
                  ],
                ),
              ),

              // Unmark / Delete — hidden while editing
              if (!_isEditing)
                BlocBuilder<CompletedExerciseCubit, Set<String>>(
                  builder: (context, state) {
                    final isCompleted = state.contains(
                      '$_dayIndex-$_exerciseIndex',
                    );
                    return Center(
                      child: isCompleted
                          ? TextButton(
                              onPressed: () {
                                context
                                    .read<CompletedExerciseCubit>()
                                    .unmarkCompleted(_dayIndex, _exerciseIndex);
                              },
                              child: Text(
                                "Unmark",
                                style: KTextStyle.solidText.copyWith(
                                  color: const Color(0xFF4285F4),
                                ),
                              ),
                            )
                          : TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return AlertDialog(
                                      title: const Text("Delete Exercise"),
                                      content: const Text(
                                        "Are you sure you want to delete this exercise?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(dialogContext),
                                          child: const Text("No"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(dialogContext);
                                            context
                                                .read<ProgramsCubit>()
                                                .removeExercise(
                                                  _dayIndex,
                                                  _exerciseIndex,
                                                );
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Yes",
                                            style: TextStyle(
                                              color: Color(0xFFEA4335),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Delete",
                                style: KTextStyle.solidText.copyWith(
                                  color: const Color(0xFFEA4335),
                                ),
                              ),
                            ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
