import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:test_app/common/colors.dart';
import 'package:test_app/common/size_config.dart';
import 'package:test_app/common/utils.dart';
import 'package:test_app/routes/routes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () {
        return Utils.onWillPop(context);
      },
      child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          drawer: SafeArea(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 3.0,
                sigmaY: 3.0,
              ),
              child: Container(
                  // height: double.infinity,
                  color: Colors.white,
                  width: SizeConfig.screenWidth * 0.6,
                  child: Drawer(
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.08,
                          width: SizeConfig.screenHeight * 0.08,
                          child: Card(
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            elevation: 0,
                            child: CircleAvatar(
                              radius: SizeConfig.screenHeight * 0.08,
                              backgroundColor: Colors.grey.shade100,
                              child: CircleAvatar(
                                radius: SizeConfig.screenHeight * 0.032,
                                backgroundColor: Colors.grey[300],
                                backgroundImage:
                                    const AssetImage('assets/png/user.png'),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.maps);
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.04,
                                top: SizeConfig.screenHeight * 0.01,
                                bottom: SizeConfig.screenHeight * 0.01,
                                right: SizeConfig.screenWidth * 0.04),
                            child: Utils.textView(
                                text: 'Tracking',
                                textColor: Colors.blue.shade900,
                                fontSize: SizeConfig.blockSizeVertical * 3.0),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          body: Builder(builder: (context) {
            return SafeArea(
              child: Column(
                children: [
                  // height: AppBar().preferredSize.height * 1.5,
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.04,
                        top: SizeConfig.screenHeight * 0.01,
                        bottom: SizeConfig.screenHeight * 0.01,
                        right: SizeConfig.screenWidth * 0.04),
                    child: Row(children: [
                      Card(
                        elevation: 3,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: InkWell(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(Icons.menu_rounded,
                                color: Colors.blue.shade900),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.notifications_none_outlined,
                          color: Colors.blue.shade900),
                      SizedBox(
                        width: SizeConfig.screenHeight * 0.01,
                      ),
                      Icon(Icons.settings_outlined,
                          color: Colors.blue.shade900),
                      SizedBox(
                        width: SizeConfig.screenHeight * 0.01,
                      ),
                      SizedBox(
                          height: SizeConfig.screenHeight * 0.06,
                          width: SizeConfig.screenHeight * 0.06,
                          child: Card(
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            elevation: 0,
                            child: CircleAvatar(
                              radius: SizeConfig.screenHeight * 0.06,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: SizeConfig.screenHeight * 0.023,
                                backgroundColor: Colors.grey[300],
                                backgroundImage:
                                    const AssetImage('assets/png/user.png'),
                              ),
                            ),
                          )),
                    ]),
                  ),
                  Expanded(
                      child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          margin: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.04,
                              bottom: SizeConfig.screenWidth * 0.04,
                              right: SizeConfig.screenWidth * 0.04),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Image.asset(
                                    'assets/png/cover.png',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: SizeConfig.screenHeight * 0.13,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.screenWidth * 0.04,
                                          top: SizeConfig.screenHeight * 0.1),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height:
                                                SizeConfig.screenHeight * 0.08,
                                            width:
                                                SizeConfig.screenHeight * 0.08,
                                            child: Card(
                                              shape: const CircleBorder(),
                                              clipBehavior: Clip.antiAlias,
                                              elevation: 0,
                                              child: CircleAvatar(
                                                radius:
                                                    SizeConfig.screenHeight *
                                                        0.08,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius:
                                                      SizeConfig.screenHeight *
                                                          0.032,
                                                  backgroundColor:
                                                      Colors.grey[300],
                                                  backgroundImage:
                                                      const AssetImage(
                                                          'assets/png/user.png'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // SizedBox(
                                          //     width:
                                          //         SizeConfig.screenHeight * 0.01),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: SizeConfig.screenHeight *
                                                    0.01,
                                                left: SizeConfig.screenHeight *
                                                    0.01,
                                                right: SizeConfig.screenHeight *
                                                    0.01),
                                            child: Column(
                                              children: [
                                                Utils.textView(
                                                    text: 'Marvin Steward',
                                                    textColor:
                                                        Colors.blue.shade900,
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        2.0,
                                                    fontWeight: FontWeight.bold)
                                              ],
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              )
                            ],
                          )))
                ],
              ),
            );
          })),
    );
  }
}
