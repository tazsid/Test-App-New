import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_app/common/colors.dart';
import 'package:test_app/common/size_config.dart';
import 'package:test_app/common/utils.dart';
import 'package:test_app/controllers/sign_up_controller.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _numberTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  SignupController signupContoller;

  @override
  void dispose() {
    Get.delete<SignupController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    signupContoller = Get.put(SignupController());

    return Scaffold(
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
                        text: 'Signup',
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
                            signupContoller.handleTypeChangeSeeker();
                          },
                          child: Row(
                            children: [
                              AbsorbPointer(
                                child: Obx(
                                  () => Radio(
                                    value: 0,
                                    groupValue:
                                        signupContoller.selectedVal.value,
                                    onChanged: (val) {},
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    activeColor: CustomColors.primaryColor,
                                  ),
                                ),
                              ),
                              Utils.textView(
                                  text: 'Seeker',
                                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                                  textColor: CustomColors.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            signupContoller.handleTypeChangeRecruiter();
                          },
                          child: Row(
                            children: [
                              AbsorbPointer(
                                child: Obx(
                                  () => Radio(
                                    value: 1,
                                    groupValue:
                                        signupContoller.selectedVal.value,
                                    onChanged: (val) {},
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    activeColor: CustomColors.primaryColor,
                                  ),
                                ),
                              ),
                              Utils.textView(
                                  text: 'Recruiter',
                                  fontSize: SizeConfig.blockSizeVertical * 2.5,
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
                        text: 'Your Name',
                        fontSize: SizeConfig.blockSizeVertical * 2.0,
                        textColor: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _nameTextController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {},
                    maxLength: 50,
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
                    height: SizeConfig.screenHeight * 0.03,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Utils.textView(
                        text: 'Your Number',
                        fontSize: SizeConfig.blockSizeVertical * 2.0,
                        textColor: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _numberTextController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    onChanged: (text) {},
                    maxLength: 10,
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
                    maxLength: 10,
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80),
                          ))),
                      onPressed: () async {
                        if (_emailTextController.text.trim().isEmpty) {
                          Utils.showSnackbar('Enter Email');
                        } else if (!Utils.isValidEmail(
                            _emailTextController.text.trim())) {
                          Utils.showSnackbar('Enter Valid Email');
                        } else if (_nameTextController.text.trim().isEmpty) {
                          Utils.showSnackbar('Enter Name');
                        } else if (_numberTextController.text.trim().isEmpty) {
                          Utils.showSnackbar('Enter Number');
                        } else if (_passwordTextController.text
                            .trim()
                            .isEmpty) {
                          Utils.showSnackbar('Enter Password');
                        } else {
                          FocusScope.of(context).requestFocus(new FocusNode());

                          signupContoller.signUp(
                              signupContoller.selectedVal == 0
                                  ? 'seeker'
                                  : 'recruiter',
                              _emailTextController.text.trim(),
                              _nameTextController.text.trim(),
                              _numberTextController.text.trim(),
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
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 45.0),
                          alignment: Alignment.center,
                          child: Utils.textView(
                              text: 'Sign up',
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
                          text: 'Already have an account?',
                          textColor: Colors.black,
                          fontSize: SizeConfig.blockSizeVertical * 2.2),
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Utils.textView(
                            text: 'Login',
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
        )));
  }
}
