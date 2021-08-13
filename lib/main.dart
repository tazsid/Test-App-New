import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_app/common/colors.dart';
import 'package:test_app/routes/route_generator.dart';
import 'package:test_app/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await GetStorage.init();

    runApp(GetMaterialApp(
      title: 'Test App',
      theme: ThemeData(
          fontFamily: 'Karla', primaryColor: CustomColors.primaryColor),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      onGenerateRoute: RouteGenerator.generateRoute,
    ));
  });
}
