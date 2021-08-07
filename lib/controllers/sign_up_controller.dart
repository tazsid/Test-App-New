import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:test_app/common/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/common/app_exception.dart';
import 'package:test_app/common/utils.dart';
import 'package:test_app/models/sign_up_model.dart';

class SignupController extends GetxController {
  var selectedVal = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  handleTypeChangeSeeker() {
    selectedVal.value = 0;
  }

  handleTypeChangeRecruiter() {
    selectedVal.value = 1;
  }

  Future<dynamic> signUp(
      String type, String email, String name, String mno, String ps) async {
    Utils.showLoader();

    String url = ApiUrls.signUp;

    Map data = {
      'type': type,
      'email': email,
      'name': name,
      'mno': mno,
      'ps': ps,
    };

    print(url + " req:");
    print((data));

    try {
      final http.Response response =
          await http.post(Uri.parse(url), body: data);

      return _returnResponseSignUp(response);
    } on SocketException catch (_) {
      Get.back();
      Utils.showSnackbar('No Internet Connection');
      return;
    } catch (e) {
      Get.back();
      print(e);
      Utils.showSnackbar('Something went wrong');
    }
  }

  dynamic _returnResponseSignUp(http.Response response) async {
    print(ApiUrls.signUp + " res:" + response.body.toString());

    SignupModel responseJson = SignupModel.fromJson(jsonDecode(response.body));

    switch (response.statusCode) {
      case 200:
        Get.back();

        Utils.showSnackbar(responseJson.staus == 'true'
            ? 'Registration Successful!'
            : responseJson.message);

        return responseJson;
      case 400:
        Get.back();

        Utils.showSnackbar(responseJson.message);

        throw BadRequestException(response.body.toString());
      case 404:
        Get.back();

        Utils.showSnackbar(responseJson.message);

        throw InvalidInputException(response.body.toString());
      case 401:
      case 403:
        Get.back();

        Utils.showSnackbar(responseJson.message);

        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        Get.back();

        Utils.showSnackbar(responseJson.message);

        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
