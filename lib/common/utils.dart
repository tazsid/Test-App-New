import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

class Utils {
  static void showSnackbar(String text, [var bgColor]) {
    Get.rawSnackbar(
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        borderRadius: 0,
        messageText: Utils.textView(
            text: text,
            fontSize: 16,
            textColor: Colors.white,
            fontWeight: FontWeight.bold),
        backgroundColor: bgColor ?? Colors.grey.shade900);
  }

  static bool isValidEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(email);
  }

  static Widget textView(
      {var text, var fontSize, var textColor, var fontWeight, var textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: textColor, fontSize: fontSize, fontWeight: fontWeight),
    );
  }

  static Future<bool> isNetworkConnected() async {
    try {
      await InternetAddress.lookup('google.com');
      return true;
    } on SocketException catch (_) {
      Utils.showSnackbar('No Internet Connection', Colors.red);
      return false;
    } catch (e) {
      Utils.showSnackbar('No Internet Connection', Colors.red);
      return false;
    }
  }
}
