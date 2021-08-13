import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/common/colors.dart';
import 'package:test_app/common/size_config.dart';
import 'package:test_app/common/utils.dart';
import 'package:test_app/controllers/dashboard_controller.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DashboardController dashboardController;

  @override
  void dispose() {
    Get.delete<DashboardController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    dashboardController = Get.put(DashboardController());

    return WillPopScope(
      onWillPop: () {
        return Utils.onWillPop(context);
      },
      child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: GestureDetector(
            onTapUp: (e) {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            onTapCancel: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  alignment: Alignment.center,
                  height: AppBar().preferredSize.height * 1.5,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          CustomColors.gradientStart,
                          CustomColors.gradientEnd
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                        )
                      ]),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.03),
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                            right: SizeConfig.screenWidth * 0.03),
                        child: Icon(
                          Icons.search_sharp,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: SizeConfig.screenWidth * 0.03),
                        child: Icon(
                          Icons.sort_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => dashboardController.isLoading.value
                      ? Expanded(
                          child: Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color: CustomColors.primaryColor,
                              ),
                            ),
                          ),
                        )
                      : dashboardController.allJobData.isNotEmpty
                          ? Expanded(
                              child: Obx(() => ListView.builder(
                                  physics: BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  itemCount:
                                      dashboardController.allJobData.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          top: SizeConfig.screenHeight * 0.01),
                                      child: Card(
                                        margin: EdgeInsets.only(
                                          left: SizeConfig.screenWidth * 0.03,
                                          right: SizeConfig.screenWidth * 0.03,
                                        ),
                                        elevation: 5,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.0)),
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Utils.textView(
                                                  text: dashboardController
                                                      .allJobData[index]
                                                      .designation,
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical *
                                                      2.1,
                                                  textColor: Colors.black87,
                                                  fontWeight: FontWeight.bold),
                                              SizedBox(
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.01,
                                              ),
                                              Utils.textView(
                                                  text: 'Organization Name',
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical *
                                                      2.1,
                                                  textColor: Colors.black38,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      top: SizeConfig
                                                              .screenHeight *
                                                          0.015,
                                                    ),
                                                    padding: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .screenHeight *
                                                          0.005,
                                                      right: SizeConfig
                                                              .screenHeight *
                                                          0.005,
                                                      top: SizeConfig
                                                              .screenHeight *
                                                          0.002,
                                                      bottom: SizeConfig
                                                              .screenHeight *
                                                          0.002,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade400,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40)),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.calendar_today,
                                                          size: 10,
                                                          color: Colors.black38,
                                                        ),
                                                        SizedBox(
                                                          width: SizeConfig
                                                                  .screenWidth *
                                                              0.01,
                                                        ),
                                                        Utils.textView(
                                                            text:
                                                                dashboardController
                                                                    .allJobData[
                                                                        index]
                                                                    .exp,
                                                            fontSize: SizeConfig
                                                                    .blockSizeVertical *
                                                                1.5,
                                                            textColor:
                                                                Colors.black38,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.02,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      top: SizeConfig
                                                              .screenHeight *
                                                          0.015,
                                                    ),
                                                    padding: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .screenHeight *
                                                          0.005,
                                                      right: SizeConfig
                                                              .screenHeight *
                                                          0.005,
                                                      top: SizeConfig
                                                              .screenHeight *
                                                          0.002,
                                                      bottom: SizeConfig
                                                              .screenHeight *
                                                          0.002,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade400,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40)),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.pin_drop,
                                                          size: 10,
                                                          color: Colors.black38,
                                                        ),
                                                        SizedBox(
                                                          width: SizeConfig
                                                                  .screenWidth *
                                                              0.01,
                                                        ),
                                                        Utils.textView(
                                                            text:
                                                                dashboardController
                                                                    .allJobData[
                                                                        index]
                                                                    .jobLocation,
                                                            fontSize: SizeConfig
                                                                    .blockSizeVertical *
                                                                1.5,
                                                            textColor:
                                                                Colors.black38,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.01,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.info_outline,
                                                      color: Colors.black,
                                                      size: 20),
                                                  SizedBox(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.01,
                                                  ),
                                                  Utils.textView(
                                                      text: dashboardController
                                                          .allJobData[index]
                                                          .technology,
                                                      fontSize: SizeConfig
                                                              .blockSizeVertical *
                                                          2.0,
                                                      textColor: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
                            )
                          : Expanded(
                              child: Center(
                              child: Utils.textView(
                                  text: 'No Data Available!',
                                  fontSize: 25.0,
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                ),
              ],
            ),
          )),
    );
  }
}
