import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_app/database/database_helper.dart';
import 'package:test_app/models/all_data_model.dart';

class ListPageController extends GetxController {
  var allData = <AllDataModel>[].obs;

  var rateEditingContoller = <TextEditingController>[].obs;

  final dbHelper = DatabaseHelper.instance;

  @override
  void onInit() {
    allJobs();
    super.onInit();
  }

  Future<dynamic> allJobs() async {
    allData.addAll(await dbHelper.getAllData());

    for (var item in allData) {
      rateEditingContoller
          .add(TextEditingController(text: item.productRate.toString()));
    }
  }
}
