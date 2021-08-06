import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/routes/routes.dart';
import 'package:test_app/views/sign_up.dart';
import 'package:test_app/views/login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return CupertinoPageRoute(builder: (context) => const Login());
      case Routes.signup:
        return CupertinoPageRoute(
            settings: settings, builder: (context) => const Signup());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(child: Text('Error')));
    });
  }
}