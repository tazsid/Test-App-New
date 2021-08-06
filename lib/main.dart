import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_app/routes/route_generator.dart';
import 'package:test_app/routes/routes.dart';

import 'common/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await GetStorage.init();

    runApp(GetMaterialApp(
      title: 'Test App',
      theme: ThemeData(fontFamily: 'Karla'),
      debugShowCheckedModeBanner: false,
      initialRoute: GetStorage().read(Constants.isLoggedIn) == null
          ? Routes.login
          : GetStorage().read(Constants.isLoggedIn) == '1'
              ? Routes.dashboard
              : Routes.login,
      onGenerateRoute: RouteGenerator.generateRoute,
    ));
  });
}
