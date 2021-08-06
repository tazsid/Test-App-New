import 'package:flutter/material.dart';
import 'package:test_app/common/colors.dart';
import 'package:test_app/common/size_config.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        backgroundColor: Colors.grey.shade500,
        body: SafeArea(
            child: Text('Login', style: TextStyle(color: Colors.black))));
  }
}
