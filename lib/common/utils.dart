import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_app/common/colors.dart';

class Utils {
  static void showSnackbar(String text, [var bgColor]) {
    Get.rawSnackbar(
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        borderRadius: 0,
        messageText: Utils.textView(
            text: text,
            fontSize: 16.0,
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

  static Future<bool> onWillPop(context) async {
    return (await showDialog(
            context: context,
            builder: (context) => Dialog(
                insetPadding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 5,
                backgroundColor: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Utils.textView(
                                text: 'Do you want to exit the app?',
                                fontSize: 17.0,
                                textColor: Colors.black,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: 5, top: 10, left: 5),
                                    child: RaisedButton(
                                      elevation: 10,
                                      highlightElevation: 0,
                                      onPressed: () {
                                        SystemChannels.platform.invokeMethod(
                                            'SystemNavigator.pop');
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0)),
                                      padding: const EdgeInsets.all(0.0),
                                      child: Ink(
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: <Color>[
                                              CustomColors.gradientStart,
                                              CustomColors.gradientEnd
                                            ],
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(80.0)),
                                        ),
                                        child: Container(
                                          constraints: const BoxConstraints(
                                              minHeight:
                                                  45.0), // min sizes for Material buttons
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Yes',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 5, top: 10, right: 5),
                                    child: RaisedButton(
                                      elevation: 10,
                                      highlightElevation: 0,
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0)),
                                      padding: const EdgeInsets.all(0.0),
                                      child: Ink(
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(80.0)),
                                        ),
                                        child: Container(
                                          constraints: const BoxConstraints(
                                              minHeight: 45.0),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'No',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                )))) ??
        false;
  }

  static void showLoader() {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              color: CustomColors.primaryColor,
            ),
          ),
        ],
      ),
    );

    Get.generalDialog(
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return StatefulBuilder(
          builder: (context, setState) => Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: Container(
                  alignment: Alignment.center,
                  child: WillPopScope(
                      onWillPop: () async {
                        return false;
                      },
                      child: alert)),
            ),
          ),
        );
      },
    );
  }
}
