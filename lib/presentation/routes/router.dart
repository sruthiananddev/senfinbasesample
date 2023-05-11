import 'package:flutter/material.dart';
import 'package:senfin/presentation/Screens/Home.dart';
import 'package:senfin/presentation/Screens/signin.dart';
import 'package:senfin/presentation/Screens/spalshpage.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => SplashPage(),
        );
      case '/signin':
        return MaterialPageRoute(
          builder: (_) => SignInPage(),
        );
      case '/Home':
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR IN NAVIGATION'),
        ),
      );
    });
  }
}
