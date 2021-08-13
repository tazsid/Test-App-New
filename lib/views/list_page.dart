import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/common/colors.dart';
import 'package:test_app/common/size_config.dart';
import 'package:test_app/common/utils.dart';
import 'package:test_app/controllers/list_page_controller.dart';
import 'package:test_app/database/database_helper.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  ListPageController listPageController;

  @override
  void dispose() {
    Get.delete<ListPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    listPageController = Get.put(ListPageController());

    return WillPopScope(
      onWillPop: () {
        return Utils.onWillPop(context);
      },
      child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: SafeArea(
            child: GestureDetector(
              onTapUp: (e) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              onTapCancel: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: [
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
                            Get.back();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(Icons.arrow_back,
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
                  Obx(
                    () => listPageController.allData.isNotEmpty
                        ? Expanded(
                            child: Obx(() => ListView.builder(
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                itemCount: listPageController.allData.length,
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
                                                text: 'Product Id: ' +
                                                    listPageController
                                                        .allData[index]
                                                        .nProductUniqId
                                                        .toString(),
                                                fontSize: SizeConfig
                                                        .blockSizeVertical *
                                                    2.0,
                                                textColor: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                            SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  0.01,
                                            ),
                                            Utils.textView(
                                                text: 'State Id: ' +
                                                    listPageController
                                                        .allData[index]
                                                        .nStateUniqId
                                                        .toString(),
                                                fontSize: SizeConfig
                                                        .blockSizeVertical *
                                                    2.0,
                                                textColor: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                            SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  0.01,
                                            ),
                                            Utils.textView(
                                                text: 'State Name: ' +
                                                    listPageController
                                                        .allData[index]
                                                        .cStateName
                                                        .toString(),
                                                fontSize: SizeConfig
                                                        .blockSizeVertical *
                                                    2.0,
                                                textColor: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                            SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  0.01,
                                            ),
                                            Utils.textView(
                                                text: 'Effective From: ' +
                                                    listPageController
                                                        .allData[index]
                                                        .effectiveFrom
                                                        .toString(),
                                                fontSize: SizeConfig
                                                        .blockSizeVertical *
                                                    2.0,
                                                textColor: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                            SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  0.01,
                                            ),
                                            Utils.textView(
                                                text:
                                                    'Added By Admin User Id: ' +
                                                        listPageController
                                                            .allData[index]
                                                            .cAddedByAdminUserId
                                                            .toString(),
                                                fontSize: SizeConfig
                                                        .blockSizeVertical *
                                                    2.0,
                                                textColor: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                            SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  0.01,
                                            ),
                                            Utils.textView(
                                                text: 'Added Time: ' +
                                                    listPageController
                                                        .allData[index]
                                                        .addedTime
                                                        .toString(),
                                                fontSize: SizeConfig
                                                        .blockSizeVertical *
                                                    2.0,
                                                textColor: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                            SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  0.01,
                                            ),
                                            Row(
                                              children: [
                                                Utils.textView(
                                                    text: 'Product Rate: ',
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        2.0,
                                                    textColor: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                Container(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.18,
                                                    // height: constraints.maxWidth * 0.10,
                                                    margin:
                                                        const EdgeInsets.only(
                                                      bottom: 5,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: TextField(
                                                        controller:
                                                            listPageController
                                                                    .rateEditingContoller[
                                                                index],
                                                        textAlign:
                                                            TextAlign.center,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            InputDecoration(
                                                          counterText: '',
                                                          hintText: '0',
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400,
                                                                width: 2),
                                                          ),
                                                          focusedBorder:
                                                              const UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                width: 2,
                                                                color: CustomColors
                                                                    .primaryColor),
                                                          ),
                                                          border:
                                                              const UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                width: 2,
                                                                color: CustomColors
                                                                    .primaryColor),
                                                          ),
                                                        ))),
                                                const Spacer(),
                                                InkWell(
                                                    onTap: () async {
                                                      if (listPageController
                                                          .rateEditingContoller[
                                                              index]
                                                          .text
                                                          .trim()
                                                          .isEmpty) {
                                                        Utils.showSnackbar(
                                                            'Enter Product Rate');
                                                        return;
                                                      }

                                                      Map<String, dynamic> row =
                                                          {
                                                        DatabaseHelper.columnId:
                                                            listPageController
                                                                .allData[index]
                                                                .nProductUniqId,
                                                        DatabaseHelper
                                                                .columnStateId:
                                                            listPageController
                                                                .allData[index]
                                                                .nStateUniqId,
                                                        DatabaseHelper
                                                                .columnStateName:
                                                            listPageController
                                                                .allData[index]
                                                                .cStateName,
                                                        DatabaseHelper
                                                                .columnEffectiveFrom:
                                                            listPageController
                                                                .allData[index]
                                                                .effectiveFrom,
                                                        DatabaseHelper
                                                                .columnAddedByAdminId:
                                                            listPageController
                                                                .allData[index]
                                                                .cAddedByAdminUserId,
                                                        DatabaseHelper
                                                                .columnProductRate:
                                                            listPageController
                                                                .rateEditingContoller[
                                                                    index]
                                                                .text
                                                                .trim(),
                                                        DatabaseHelper
                                                                .columnAddedTime:
                                                            listPageController
                                                                .allData[index]
                                                                .addedTime,
                                                      };

                                                      await listPageController
                                                          .dbHelper
                                                          .update(
                                                              row,
                                                              DatabaseHelper
                                                                  .tableData,
                                                              DatabaseHelper
                                                                  .columnId);

                                                      Utils.showSnackbar(
                                                          'Data Saved Successfully');
                                                    },
                                                    child: Utils.textView(
                                                        text: 'Update',
                                                        fontSize: SizeConfig
                                                                .blockSizeVertical *
                                                            3.0,
                                                        textColor: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold))
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
            ),
          )),
    );
  }
}
