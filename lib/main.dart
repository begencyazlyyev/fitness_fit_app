// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/bookmark_cubit.dart';
import 'package:flutter_application_1/cubit/kg_counter_cubit.dart';
import 'package:flutter_application_1/cubit/programs_cubit.dart';
import 'package:flutter_application_1/cubit/reps_counter_cubit.dart';
import 'package:flutter_application_1/cubit/sets_counter_cubit.dart';
import 'package:flutter_application_1/router/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BookmarkCubit()),
        BlocProvider(create: (context) => KgCounterCubit()),
        BlocProvider(create: (context) => RepsConterCubit()),
        BlocProvider(create: (context) => ProgramsCubit()),
        BlocProvider(create: (context) => SetsCounterCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: generateRoute,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFF1C2A3A),
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xFF1C2A3A), // main color
            onPrimary: Colors.white, // text/icons on primary
            secondary: Color(0xFF1C2A3A),
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.white,
            background: Colors.white,
            onBackground: Color(0xFF1C2A3A),
            surface: Colors.white,
            onSurface: Color(0xFF1C2A3A),
          ),

          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(backgroundColor: Color(0xFF1C2A3A)),
          ),
        ),
      ),
    );
  }
}
