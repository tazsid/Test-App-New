import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/routes/routes.dart';
import 'package:test_app/views/dashboard.dart';
import 'package:test_app/views/home.dart';
import 'package:test_app/views/list_page.dart';
import 'package:test_app/views/maps.dart';
import 'package:test_app/views/sign_up.dart';
import 'package:test_app/views/login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return CupertinoPageRoute(builder: (context) => Login());
      case Routes.signup:
        return CupertinoPageRoute(
            settings: settings, builder: (context) => Signup());
      case Routes.dashboard:
        return CupertinoPageRoute(
            settings: settings, builder: (context) => Dashboard());
      case Routes.home:
        return CupertinoPageRoute(
            settings: settings, builder: (context) => Home());
      case Routes.maps:
        return CupertinoPageRoute(
            settings: settings, builder: (context) => Maps());
      case Routes.listPage:
        return CupertinoPageRoute(
            settings: settings, builder: (context) => ListPage());
      default:
      // return _errorRoute();
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
