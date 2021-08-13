import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/routes/routes.dart';
import 'package:test_app/views/home.dart';
import 'package:test_app/views/list_page.dart';
import 'package:test_app/views/maps.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
