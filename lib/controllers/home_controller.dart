import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:test_app/common/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/common/app_exception.dart';
import 'package:test_app/common/utils.dart';
import 'package:test_app/database/database_helper.dart';
import 'package:test_app/models/all_data_model.dart';

class HomeController extends GetxController {
  final dbHelper = DatabaseHelper.instance;

  @override
  void onInit() {
    dbHelper.getAllData().then((value) {
      if (value.isEmpty) {
        getAllData();
      }
    });

    super.onInit();
  }

  Future<dynamic> getAllData() async {
    Utils.showLoader();

    String url = ApiUrls.getAllData;

    try {
      final http.Response response = await http.get(Uri.parse(url));

      return _returnResponseLogin(response);
    } on SocketException catch (_) {
      Get.back();
      Utils.showSnackbar('No Internet Connection');
      return;
    } catch (e) {
      Get.back();
      Utils.showSnackbar('Something went wrong');
    }
  }

  dynamic _returnResponseLogin(http.Response response) async {
    print(ApiUrls.getAllData + " res:" + response.body.toString());

    List<AllDataModel> responseJson = jsonDecode(response.body)
        .map((item) => AllDataModel.fromJson(item))
        .toList()
        .cast<AllDataModel>();

    switch (response.statusCode) {
      case 200:
        Get.back();

        await dbHelper.deleteAll(DatabaseHelper.tableData);

        for (var i = 0; i < responseJson.length; i++) {
          if (responseJson[i].cAddedByAdminUserId != null) {
            await dbHelper.insertData(responseJson[i]);
          }
        }

        return responseJson;
      case 400:
        Get.back();

        // Utils.showSnackbar(response.body);

        throw BadRequestException(response.body.toString());
      case 404:
        Get.back();

        // Utils.showSnackbar(responseJson.message);

        throw InvalidInputException(response.body.toString());
      case 401:
      case 403:
        Get.back();

        // Utils.showSnackbar(responseJson.message);

        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        Get.back();

        // Utils.showSnackbar(responseJson.message);

        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
