import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home_page.dart';
import 'package:flutter_application_1/view/pages/programs_page/programs_page.dart';
import 'package:flutter_application_1/view/pages/training_page/add_exercise_page.dart';
import 'package:flutter_application_1/view/pages/training_page/exercise_details.dart';
import 'package:flutter_application_1/view/pages/training_page/selectprogram_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const HomePage());
    //* Add Exercise page - Animated

    case '/add_exercise':
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddExercisePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeOut;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );

    //* Exercise details page
    case '/exercise_details':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ExerciseDetails(),
      );

    //* Program Selection page
    case '/select_program':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ProgramSelectionPage(),
      );

    //* Programs page
    case '/programs_page':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ProgramsPage(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text('No route found'))),
      );
  }
}
