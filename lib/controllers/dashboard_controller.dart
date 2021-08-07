import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:test_app/common/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/common/app_exception.dart';
import 'package:test_app/common/utils.dart';
import 'package:test_app/models/all_job_model.dart';
import 'package:test_app/models/sign_up_model.dart';

class DashboardController extends GetxController {
  var selectedVal = 0.obs;
  var isLoading = false.obs;

  var allJobData = <AllJobModelData>[].obs;

  @override
  void onInit() {
    allJobs();
    super.onInit();
  }

  Future<dynamic> allJobs() async {
    isLoading.value = true;

    String url = ApiUrls.allJob;

    Map data = {
      'affiliation': 'affiliation',
      'name': 'test',
    };

    print(url + " req:");
    print((data));

    try {
      final http.Response response =
          await http.post(Uri.parse(url), body: data);

      return _returnResponseAllJob(response);
    } on SocketException catch (_) {
      isLoading.value = false;
      Utils.showSnackbar('No Internet Connection');
      return;
    } catch (e) {
      isLoading.value = false;
      print(e);
      Utils.showSnackbar('Something went wrong');
    }
  }

  dynamic _returnResponseAllJob(http.Response response) async {
    print(ApiUrls.allJob + " res:" + response.body.toString());

    AllJobModel responseJson = AllJobModel.fromJson(jsonDecode(response.body));

    switch (response.statusCode) {
      case 200:
        isLoading.value = false;

        allJobData.assignAll(responseJson.data);

        return responseJson;
      case 400:
        isLoading.value = false;

        Utils.showSnackbar(responseJson.message);

        throw BadRequestException(response.body.toString());
      case 404:
        isLoading.value = false;

        Utils.showSnackbar(responseJson.message);

        throw InvalidInputException(response.body.toString());
      case 401:
      case 403:
        isLoading.value = false;

        Utils.showSnackbar(responseJson.message);

        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        isLoading.value = false;

        Utils.showSnackbar(responseJson.message);

        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
