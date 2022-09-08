import 'package:flutter/material.dart';
import 'package:simple_todo_app/src/features/onboarding_screen/presentation/pages/onboarding_screen.dart';
import 'package:simple_todo_app/src/features/splash_screen/splash_view.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/layout/remind_me_layout.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/pages/insert_task_screen.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String remindMeLayoutRoute = '/remindMeLayout';
  static const String insertTaskRoute = '/insertTask';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (context) => OnboardingScreen());
      case Routes.remindMeLayoutRoute:
        return MaterialPageRoute(builder: (context) => const TodoLayout());
      case Routes.insertTaskRoute:
        return MaterialPageRoute(builder: (context) => InsertTaskScreen());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Undefined Route'),
        ),
        body: const Center(
          child: Text('Undefined Route'),
        ),
      ),
    );
  }
}
