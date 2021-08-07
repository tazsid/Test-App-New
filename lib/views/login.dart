import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_app/common/colors.dart';
import 'package:test_app/common/size_config.dart';
import 'package:test_app/common/utils.dart';
import 'package:test_app/controllers/login_controller.dart';
import 'package:test_app/routes/routes.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  LoginController loginContoller;

  @override
  void dispose() {
    Get.delete<LoginController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    loginContoller = Get.put(LoginController());

    return WillPopScope(
      onWillPop: () {
        return Utils.onWillPop(context);
      },
      child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: SafeArea(
              child: GestureDetector(
            onTapUp: (e) {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            onTapCancel: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.05,
                    right: SizeConfig.screenWidth * 0.05),
                child: Column(
                  children: [
                    Center(
                        child: Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.screenHeight * 0.05,
                        bottom: SizeConfig.screenHeight * 0.05,
                      ),
                      child: Utils.textView(
                          text: 'Login',
                          fontSize: SizeConfig.blockSizeVertical * 3.2,
                          textColor: CustomColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center),
                    )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.05,
                          right: SizeConfig.screenWidth * 0.05,
                          bottom: SizeConfig.screenHeight * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              loginContoller.handleTypeChangeSeeker();
                            },
                            child: Row(
                              children: [
                                AbsorbPointer(
                                  child: Obx(
                                    () => Radio(
                                      value: 0,
                                      groupValue:
                                          loginContoller.selectedVal.value,
                                      onChanged: (val) {},
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      activeColor: CustomColors.primaryColor,
                                    ),
                                  ),
                                ),
                                Utils.textView(
                                    text: 'Seeker',
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 2.5,
                                    textColor: CustomColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              loginContoller.handleTypeChangeRecruiter();
                            },
                            child: Row(
                              children: [
                                AbsorbPointer(
                                  child: Obx(
                                    () => Radio(
                                      value: 1,
                                      groupValue:
                                          loginContoller.selectedVal.value,
                                      onChanged: (val) {},
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      activeColor: CustomColors.primaryColor,
                                    ),
                                  ),
                                ),
                                Utils.textView(
                                    text: 'Recruiter',
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 2.5,
                                    textColor: CustomColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Utils.textView(
                          text: 'Your Email',
                          fontSize: SizeConfig.blockSizeVertical * 2.0,
                          textColor: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: (text) {},
                      style: TextStyle(color: Colors.grey.shade600),
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey.shade500),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: CustomColors.primaryColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: CustomColors.primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.03,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Utils.textView(
                          text: 'Password',
                          fontSize: SizeConfig.blockSizeVertical * 2.0,
                          textColor: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _passwordTextController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      onChanged: (text) {},
                      style: TextStyle(color: Colors.grey.shade600),
                      decoration: InputDecoration(
                        counterText: '',
                        isDense: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey.shade500),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: CustomColors.primaryColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: CustomColors.primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.05,
                    ),
                    Container(
                      width: SizeConfig.screenWidth * 0.4,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.zero),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            elevation: MaterialStateProperty.all<double>(4),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80),
                            ))),
                        onPressed: () async {
                          if (_emailTextController.text.trim().isEmpty) {
                            Utils.showSnackbar('Enter Email');
                          } else if (!Utils.isValidEmail(
                              _emailTextController.text.trim())) {
                            Utils.showSnackbar('Enter Valid Email');
                          } else if (_passwordTextController.text
                              .trim()
                              .isEmpty) {
                            Utils.showSnackbar('Enter Password');
                          } else {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());

                            loginContoller.login(
                                loginContoller.selectedVal == 0
                                    ? 'seeker'
                                    : 'recruiter',
                                _emailTextController.text.trim(),
                                _passwordTextController.text.trim());
                          }
                        },
                        child: Ink(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                CustomColors.gradientStart,
                                CustomColors.gradientEnd
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(80.0)),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 45.0),
                            alignment: Alignment.center,
                            child: Utils.textView(
                                text: 'Login',
                                textAlign: TextAlign.center,
                                textColor: Colors.white,
                                fontSize: SizeConfig.blockSizeVertical * 2.5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Utils.textView(
                            text: 'Don\'t have an account?',
                            textColor: Colors.black,
                            fontSize: SizeConfig.blockSizeVertical * 2.2),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.01,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.signup);
                          },
                          child: Utils.textView(
                              text: 'Register',
                              textColor: CustomColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeVertical * 2.2),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ))),
    );
  }
}
