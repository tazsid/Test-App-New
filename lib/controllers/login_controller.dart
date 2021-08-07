import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_app/common/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/common/app_exception.dart';
import 'package:test_app/common/constants.dart';
import 'package:test_app/common/utils.dart';
import 'package:test_app/models/login_model.dart';
import 'package:test_app/models/sign_up_model.dart';
import 'package:test_app/routes/routes.dart';

class LoginController extends GetxController {
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

  Future<dynamic> login(String type, String email, String ps) async {
    Utils.showLoader();

    String url = ApiUrls.login;

    Map data = {
      'type': type,
      'email': email,
      'ps': ps,
    };

    print(url + " req:");
    print((data));

    try {
      final http.Response response =
          await http.post(Uri.parse(url), body: data);

      return _returnResponseLogin(response);
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

  dynamic _returnResponseLogin(http.Response response) async {
    print(ApiUrls.signUp + " res:" + response.body.toString());

    LoginModel responseJson = LoginModel.fromJson(jsonDecode(response.body));

    switch (response.statusCode) {
      case 200:
        Get.back();

        if (responseJson.staus == 'true') {
          GetStorage().write(Constants.isLoggedIn, '1');
          GetStorage().write(Constants.img, responseJson.data?.img);
          GetStorage().write(Constants.baseUrl, responseJson.baseUrl);
          Get.toNamed(Routes.dashboard);
        } else
          Utils.showSnackbar(responseJson.message);

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
