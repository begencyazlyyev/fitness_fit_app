import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home_page.dart';
import 'package:flutter_application_1/view/pages/onboarding_pages/choose_gender_page.dart';
import 'package:flutter_application_1/view/pages/onboarding_pages/create_accaunt.dart';
import 'package:flutter_application_1/view/pages/onboarding_pages/user_details.dart';
import 'package:flutter_application_1/view/pages/programs_page/complited_exercise_page.dart';
import 'package:flutter_application_1/view/pages/programs_page/programs_page.dart';
import 'package:flutter_application_1/view/pages/training_page/add_exercise_page.dart';
import 'package:flutter_application_1/view/pages/training_page/exercise_details.dart';
import 'package:flutter_application_1/view/pages/training_page/programselection_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const HomePage());

    case '/create_account':
      return MaterialPageRoute(builder: (_) => const CreateAccaunt());

    case '/user_details':
      return MaterialPageRoute(builder: (_) => const UserDetailsPage());
    case '/choose_gender':
      return MaterialPageRoute(builder: (_) => const ChooseGenderPage());

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

    case '/exercise_details':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ExerciseDetails(),
      );

    case '/select_program':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ProgramSelectionPage(),
      );

    case '/programs_page':
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ProgramsPage(),
      );

    case '/exercise_detail': // ← add this
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ComplitedExercisePage(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text('No route found'))),
      );
  }
}
