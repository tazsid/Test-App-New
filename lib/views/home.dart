import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:test_app/common/colors.dart';
import 'package:test_app/common/size_config.dart';
import 'package:test_app/common/utils.dart';
import 'package:test_app/controllers/home_controller.dart';
import 'package:test_app/routes/routes.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:permission_handler/permission_handler.dart'
    as permissionHandler;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  Location location;

  HomeController homeController;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    location = Location();

    checkGps();
  }

  checkGps() async {
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        Get.rawSnackbar(message: 'GPS needs to be enabled to use the app');

        checkGps();
        return;
      }
    }

    if (await permissionHandler.Permission.location.isPermanentlyDenied) {
      showPermissionDialog();
      return;
    } else if (!await permissionHandler.Permission.location.isGranted) {
      var status = await permissionHandler.Permission.location.request();

      if (!status.isGranted) {
        checkGps();
        return;
      }
    } else {
      location.changeSettings(accuracy: LocationAccuracy.high);
    }
  }

  showPermissionDialog() {
    showDialog(
        // barrierColor: CustomColors.transparentHeaderColor,
        context: context,
        builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding:
                  EdgeInsets.only(left: 20, top: 35, right: 20, bottom: 20),
              // margin: EdgeInsets.only(top: 45),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 5),
                        blurRadius: 5),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Utils.textView(
                      text:
                          'Please grant location and camera permissions to use the app',
                      fontSize: 17,
                      textColor: Colors.black,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center),
                  SizedBox(height: 35),
                  Container(
                    // margin:
                    //     const EdgeInsets.only(left: 20, bottom: 10, right: 20),
                    child: RaisedButton(
                        elevation: 5,
                        highlightElevation: 0,
                        padding: EdgeInsets.only(
                            top: 15, bottom: 15, left: 20, right: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: () async {
                          Get.back();
                          permissionHandler.openAppSettings();
                        },
                        color: CustomColors.primaryColor,
                        textColor: Colors.white,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SvgPicture.asset(
                              //   'assets/images/call.svg',
                              //   semanticsLabel: 'one',
                              //   height: 20,
                              //   color: Colors.white,
                              // ),
                              // SizedBox(width: 10),
                              Utils.textView(
                                  text: 'Allow Permissions',
                                  fontSize: 15,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold)
                            ])),
                  )
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    homeController = Get.put(HomeController());

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
                        Divider(color: Colors.grey.shade400),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.listPage);
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.04,
                                top: SizeConfig.screenHeight * 0.01,
                                bottom: SizeConfig.screenHeight * 0.01,
                                right: SizeConfig.screenWidth * 0.04),
                            child: Utils.textView(
                                text: 'List',
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
                          child: SingleChildScrollView(
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
                                            top:
                                                SizeConfig.screenHeight * 0.07),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height:
                                                      SizeConfig.screenHeight *
                                                          0.1,
                                                  width:
                                                      SizeConfig.screenHeight *
                                                          0.1,
                                                  child: Card(
                                                    shape: const CircleBorder(),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    elevation: 0,
                                                    child: CircleAvatar(
                                                      radius: SizeConfig
                                                              .screenHeight *
                                                          0.1,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: CircleAvatar(
                                                        radius: SizeConfig
                                                                .screenHeight *
                                                            0.04,
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
                                                      top: SizeConfig
                                                              .screenHeight *
                                                          0.07,
                                                      left: SizeConfig
                                                              .screenHeight *
                                                          0.01,
                                                      right: SizeConfig
                                                              .screenHeight *
                                                          0.01),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Utils.textView(
                                                          text:
                                                              'Marvin Steward',
                                                          textColor: Colors
                                                              .blue.shade900,
                                                          fontSize: SizeConfig
                                                                  .blockSizeVertical *
                                                              2.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      Utils.textView(
                                                          text: 'Model',
                                                          textColor: Colors
                                                              .grey.shade600,
                                                          fontSize: SizeConfig
                                                                  .blockSizeVertical *
                                                              1.6,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      SizedBox(
                                                        height: SizeConfig
                                                                .screenHeight *
                                                            0.01,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .facebook_outlined,
                                                              color: Colors.blue
                                                                  .shade800),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .screenWidth *
                                                                0.01,
                                                          ),
                                                          Icon(
                                                              Icons
                                                                  .biotech_rounded,
                                                              color:
                                                                  Colors.blue),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .screenWidth *
                                                                0.01,
                                                          ),
                                                          Icon(
                                                              Icons
                                                                  .linked_camera,
                                                              color: Colors.blue
                                                                  .shade900),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .screenWidth *
                                                                0.01,
                                                          ),
                                                          Icon(
                                                              Icons
                                                                  .insert_invitation,
                                                              color: Colors
                                                                  .orange
                                                                  .shade200),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  0.04,
                                            ),
                                            Row(
                                              children: [
                                                Utils.textView(
                                                    text: 'TAGS',
                                                    textColor:
                                                        Colors.blue.shade900,
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        2.2,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                SizedBox(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.01,
                                                ),
                                                Icon(Icons.info,
                                                    size: 20,
                                                    color:
                                                        Colors.blue.shade900),
                                              ],
                                            ),
                                            SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  0.01,
                                            ),
                                            Row(children: [
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.blue.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  padding: EdgeInsets.only(
                                                      top: SizeConfig.screenHeight *
                                                          0.006,
                                                      bottom: SizeConfig
                                                              .screenHeight *
                                                          0.006,
                                                      left: SizeConfig.screenWidth *
                                                          0.02,
                                                      right: SizeConfig.screenWidth *
                                                          0.02),
                                                  child: Utils.textView(
                                                      text: 'Makeup',
                                                      textColor:
                                                          Colors.blue.shade900,
                                                      fontSize: SizeConfig
                                                              .blockSizeVertical *
                                                          2.0,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                              SizedBox(
                                                width: SizeConfig.screenWidth *
                                                    0.01,
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.blue.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  padding: EdgeInsets.only(
                                                      top: SizeConfig.screenHeight *
                                                          0.006,
                                                      bottom: SizeConfig
                                                              .screenHeight *
                                                          0.006,
                                                      left: SizeConfig.screenWidth *
                                                          0.02,
                                                      right: SizeConfig.screenWidth *
                                                          0.02),
                                                  child: Utils.textView(
                                                      text: 'Beauty',
                                                      textColor:
                                                          Colors.blue.shade900,
                                                      fontSize: SizeConfig
                                                              .blockSizeVertical *
                                                          2.0,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                              SizedBox(
                                                width: SizeConfig.screenWidth *
                                                    0.01,
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.blue.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  padding: EdgeInsets.only(
                                                      top: SizeConfig.screenHeight *
                                                          0.006,
                                                      bottom: SizeConfig
                                                              .screenHeight *
                                                          0.006,
                                                      left: SizeConfig.screenWidth *
                                                          0.02,
                                                      right: SizeConfig.screenWidth *
                                                          0.02),
                                                  child: Utils.textView(
                                                      text: 'Model',
                                                      textColor:
                                                          Colors.blue.shade900,
                                                      fontSize: SizeConfig
                                                              .blockSizeVertical *
                                                          2.0,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                              SizedBox(
                                                width: SizeConfig.screenWidth *
                                                    0.01,
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.blue.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  padding: EdgeInsets.only(
                                                      top: SizeConfig.screenHeight *
                                                          0.006,
                                                      bottom: SizeConfig
                                                              .screenHeight *
                                                          0.006,
                                                      left: SizeConfig.screenWidth *
                                                          0.02,
                                                      right: SizeConfig.screenWidth *
                                                          0.02),
                                                  child: Utils.textView(
                                                      text: 'Actress',
                                                      textColor:
                                                          Colors.blue.shade900,
                                                      fontSize: SizeConfig
                                                              .blockSizeVertical *
                                                          2.0,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                            ]),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .screenHeight *
                                                        0.05),
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.2,
                                                child: PageView.builder(
                                                  controller: _pageController,
                                                  itemCount: 3,
                                                  pageSnapping: false,
                                                  physics:
                                                      const BouncingScrollPhysics(
                                                          parent:
                                                              AlwaysScrollableScrollPhysics()),
                                                  itemBuilder:
                                                      (context, int index) {
                                                    return getSlideView(index);
                                                  },
                                                )),
                                            SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  0.03,
                                            ),
                                            Utils.textView(
                                                text: 'Age Engagement Rate',
                                                textColor: Colors.blue.shade900,
                                                fontSize: SizeConfig
                                                        .blockSizeVertical *
                                                    2.2,
                                                fontWeight: FontWeight.bold),
                                            Row(
                                              children: [
                                                Container(
                                                  height:
                                                      SizeConfig.screenWidth *
                                                          0.4,
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.4,
                                                  child: ageChart(),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Card(
                                                            shape:
                                                                CircleBorder(),
                                                            color: Colors
                                                                .blue.shade900,
                                                            child: SizedBox(
                                                              height: 12,
                                                              width: 12,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .screenWidth *
                                                                0.02,
                                                          ),
                                                          Expanded(
                                                            child: Utils.textView(
                                                                text: '10-25:',
                                                                textColor: Colors
                                                                    .blue
                                                                    .shade900,
                                                                fontSize: SizeConfig
                                                                        .blockSizeVertical *
                                                                    2.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .screenWidth *
                                                                0.03,
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Utils.textView(
                                                                text: '45%',
                                                                textColor: Colors
                                                                    .blue
                                                                    .shade900,
                                                                fontSize: SizeConfig
                                                                        .blockSizeVertical *
                                                                    2.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Card(
                                                            shape:
                                                                CircleBorder(),
                                                            color: Colors
                                                                .red.shade400,
                                                            child: SizedBox(
                                                              height: 12,
                                                              width: 12,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .screenWidth *
                                                                0.02,
                                                          ),
                                                          Expanded(
                                                            child: Utils.textView(
                                                                text: '26-38:',
                                                                textColor: Colors
                                                                    .blue
                                                                    .shade900,
                                                                fontSize: SizeConfig
                                                                        .blockSizeVertical *
                                                                    2.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .screenWidth *
                                                                0.03,
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Utils.textView(
                                                                text: '30%',
                                                                textColor: Colors
                                                                    .blue
                                                                    .shade900,
                                                                fontSize: SizeConfig
                                                                        .blockSizeVertical *
                                                                    2.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Card(
                                                            shape:
                                                                CircleBorder(),
                                                            color: Colors
                                                                .cyan.shade200,
                                                            child: SizedBox(
                                                              height: 12,
                                                              width: 12,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .screenWidth *
                                                                0.02,
                                                          ),
                                                          Expanded(
                                                            child: Utils.textView(
                                                                text: '10-25:',
                                                                textColor: Colors
                                                                    .blue
                                                                    .shade900,
                                                                fontSize: SizeConfig
                                                                        .blockSizeVertical *
                                                                    2.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            width: SizeConfig
                                                                    .screenWidth *
                                                                0.03,
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Utils.textView(
                                                                text: '25%',
                                                                textColor: Colors
                                                                    .blue
                                                                    .shade900,
                                                                fontSize: SizeConfig
                                                                        .blockSizeVertical *
                                                                    2.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ))
                                  ],
                                )
                              ],
                            ),
                          )))
                ],
              ),
            );
          })),
    );
  }

  ageChart() {
    return charts.PieChart(_createData(),
        animate: false,
        defaultRenderer: new charts.ArcRendererConfig(
          strokeWidthPx: 0,
          arcWidth: 40,
        ));
  }

  static List<charts.Series<LinearSales, int>> _createData() {
    List<LinearSales> data = [
      new LinearSales(
          0, 25, charts.ColorUtil.fromDartColor(Colors.red.shade400)),
      new LinearSales(
          1, 45, charts.ColorUtil.fromDartColor(Colors.blue.shade900)),
      new LinearSales(
          2, 30, charts.ColorUtil.fromDartColor(Colors.cyan.shade200)),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        colorFn: (LinearSales sales, _) => sales.color,
        data: data,
        labelAccessorFn: (LinearSales row, _) => '${row.sales}',
      )
    ];
  }

  getSlideView(int index) {
    return Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(
            top: SizeConfig.screenWidth * 0.01,
            bottom: SizeConfig.screenWidth * 0.01,
            left: SizeConfig.screenWidth * 0.02,
            right: SizeConfig.screenWidth * 0.02),
        color: Colors.blue.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Container(
          padding: EdgeInsets.all(
            SizeConfig.screenHeight * 0.025,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: constraints.maxWidth,
                            child: Row(
                              children: [
                                Card(
                                  elevation: 2,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: InkWell(
                                    onTap: () {
                                      Scaffold.of(context).openDrawer();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(Icons.facebook_sharp,
                                          color: Colors.blue.shade900),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Utils.textView(
                                    text: '1k Views',
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 2.7,
                                    textColor: Colors.blue.shade800,
                                    fontWeight: FontWeight.bold),
                              ],
                            ),
                          ),
                        ]),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Utils.textView(
                            text: '4.2M',
                            fontSize: SizeConfig.blockSizeVertical * 3.0,
                            textColor: Colors.black,
                            fontWeight: FontWeight.bold),
                        Utils.textView(
                            text: 'Followers',
                            fontSize: SizeConfig.blockSizeVertical * 1.3,
                            textColor: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Utils.textView(
                            text: '90',
                            fontSize: SizeConfig.blockSizeVertical * 3.0,
                            textColor: Colors.black,
                            fontWeight: FontWeight.bold),
                        Utils.textView(
                            text: 'Reactions',
                            fontSize: SizeConfig.blockSizeVertical * 1.3,
                            textColor: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Utils.textView(
                            text: '345',
                            fontSize: SizeConfig.blockSizeVertical * 3.0,
                            textColor: Colors.black,
                            fontWeight: FontWeight.bold),
                        Utils.textView(
                            text: 'Comments',
                            fontSize: SizeConfig.blockSizeVertical * 1.3,
                            textColor: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class LinearSales {
  final int year;
  final double sales;
  final charts.Color color;

  LinearSales(this.year, this.sales, this.color);
}
