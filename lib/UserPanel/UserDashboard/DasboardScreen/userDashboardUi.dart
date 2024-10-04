import 'dart:convert';
import 'dart:math' as math;
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../APIs/apis.dart';
import '../../../LoginPages/loginscreen.dart';
import '../../../Models/InstallarComperison/InstallarComparisonModel.dart';
import '../../../Models/MonthlyInstallationStatus/MonthlyInstallationStatusModel.dart';
import '../../../Models/UserInstallationStatus/UserInstallationStatusModel.dart';
import '../../../SplashScreen/splashScreen.dart';
import '../../../Utilities/Colors/colors.dart';
import '../../../Utilities/Snackbar/snackbar.dart';
import '../DrawerUi/Drawer.dart';
import '../InstallarComparison/installarComperison.dart';
import 'CanceledInstallation/canceledInstallation.dart';
import 'ClosedInstallation/closedInstallation.dart';
import 'InstalledInstallation/installedInstallation.dart';
import 'UnassignedInstallation/unassignedInsatllation.dart';
import 'UserPendingInstallations/userPendingInstallation.dart';

class UserDashboardUI extends StatefulWidget {
  const UserDashboardUI({super.key});

  @override
  State<UserDashboardUI> createState() => _UserDashboardUIState();
}

class _UserDashboardUIState extends State<UserDashboardUI> {
  List<UserInstallationStatusModel> userInstallationStatusList = [];
  List<InstallarComparisonModel> installarComperisonList = [];
  List<MonthlyInstallationStatusModel> monthlyInstallationStatusList = [];
  Map<String, String> monthlyData = {};
  String? name;
  double tableFontSize = 14;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_InstallationStatus();
    get_MonthlyInstallationStatus();
    get_InstallarComperison();
    getLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current date
    // DateTime currentDate = DateTime.now();
    //
    // // Subtract 2 days from the current date
    // DateTime dateMinusTwo = currentDate.subtract(Duration(days: 2));
    //
    // // Format the date and day name
    // String formattedDate = DateFormat('dd').format(dateMinusTwo);
    // String dayName = DateFormat('EE').format(dateMinusTwo);

    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Hello ${name.toString().trim()}',
            style: TextStyle(color: ColorsUtils.whiteColor, fontSize: 18),
          ),
          backgroundColor: ColorsUtils.appcolor,
          iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
          actions: [
            IconButton(
                onPressed: () {
                  logout();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        drawer: AdminDrawerUI(),
        body: RefreshIndicator(
          onRefresh: () async {
            await get_InstallationStatus();
            await get_MonthlyInstallationStatus();
            await get_InstallarComperison();
          },
          child: ListView.builder(
              itemCount: userInstallationStatusList.length,
              itemBuilder: (context, index) {
                return userInstallationStatusList.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserUnassignedInstallationUI()))
                                        .then((value) {
                                      get_InstallationStatus();
                                      get_MonthlyInstallationStatus();
                                      get_InstallarComperison();
                                    });
                                  },
                                  child: Material(
                                    elevation: 10,
                                    color: ColorsUtils.whiteColor,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      height: _height * 0.05,
                                      width: _width * 0.45,
                                      decoration: BoxDecoration(),
                                      child: Row(
                                        children: [
                                          // First container with all borders
                                          Container(
                                            // height: _height * 0.08,
                                            width: _width * 0.29,
                                            decoration: BoxDecoration(
                                              color: ColorsUtils.appcolor,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  topLeft: Radius.circular(15)),
                                              // border: Border.all(color: Colors.deepPurple),
                                            ),
                                            child: Center(
                                                child: Text(
                                              'Unassigned',
                                              style: TextStyle(
                                                  color: ColorsUtils.whiteColor,
                                                  fontSize: 16),
                                            )),
                                          ),
                                          // Second container with no left border
                                          Container(
                                            height: _height * 0.1,
                                            width: _width * 0.15,
                                            decoration: BoxDecoration(
                                              color: ColorsUtils.whiteColor,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              border: Border(
                                                // top: BorderSide(color: ColorsUtils.blackColor),
                                                // right: BorderSide(color: ColorsUtils.blackColor),
                                                // bottom: BorderSide(color: ColorsUtils.blackColor),
                                                // No left border
                                                left: BorderSide.none,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                userInstallationStatusList[
                                                            index]
                                                        .unassigned
                                                        .toString() ??
                                                    '0',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CanceledInstallationUI()));
                                  },
                                  child: Material(
                                    elevation: 10,
                                    color: ColorsUtils.whiteColor,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      height: _height * 0.05,
                                      width: _width * 0.45,
                                      child: Row(
                                        children: [
                                          // First container with all borders
                                          Container(
                                            height: _height * 0.08,
                                            width: _width * 0.23,
                                            decoration: BoxDecoration(
                                              color: ColorsUtils.appcolor,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  topLeft: Radius.circular(15)),
                                              // border: Border.all(color: ColorsUtils.blackColor),
                                            ),
                                            child: Center(
                                                child: Text(
                                              'Cancelled',
                                              style: TextStyle(
                                                  color: ColorsUtils.whiteColor,
                                                  fontSize: 16),
                                            )),
                                          ),
                                          // Second container with no left border
                                          Container(
                                            height: _height * 0.1,
                                            width: _width * 0.15,
                                            decoration: BoxDecoration(
                                              color: ColorsUtils.whiteColor,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              border: Border(
                                                // top: BorderSide(color: ColorsUtils.blackColor),
                                                // right: BorderSide(color: ColorsUtils.blackColor),
                                                // bottom: BorderSide(color: ColorsUtils.blackColor),
                                                // No left border
                                                left: BorderSide.none,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                userInstallationStatusList[
                                                            index]
                                                        .cancelled
                                                        .toString() ??
                                                    '0',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: _height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserPendingInstallationUI()));
                                  },
                                  child: Material(
                                    elevation: 10,
                                    color: ColorsUtils.whiteColor,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      height: _height * 0.05,
                                      width: _width * 0.45,
                                      child: Row(
                                        children: [
                                          // First container with all borders
                                          Container(
                                            height: _height * 0.08,
                                            width: _width * 0.29,
                                            decoration: BoxDecoration(
                                              color: ColorsUtils.appcolor,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  topLeft: Radius.circular(15)),
                                              // border: Border.all(color: ColorsUtils.blackColor),
                                            ),
                                            child: Center(
                                                child: Text(
                                              'Pending',
                                              style: TextStyle(
                                                  color: ColorsUtils.whiteColor,
                                                  fontSize: 16),
                                            )),
                                          ),
                                          // Second container with no left border
                                          Container(
                                            height: _height * 0.1,
                                            width: _width * 0.15,
                                            decoration: BoxDecoration(
                                              color: ColorsUtils.whiteColor,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              border: Border(
                                                // top: BorderSide(color: ColorsUtils.blackColor),
                                                // right: BorderSide(color: ColorsUtils.blackColor),
                                                // bottom: BorderSide(color: ColorsUtils.blackColor),
                                                // No left border
                                                left: BorderSide.none,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                userInstallationStatusList[
                                                            index]
                                                        .pending
                                                        .toString() ??
                                                    '0',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ClosedInstallationUI()));
                                  },
                                  child: Material(
                                    elevation: 10,
                                    color: ColorsUtils.whiteColor,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      height: _height * 0.05,
                                      width: _width * 0.45,
                                      child: Row(
                                        children: [
                                          // First container with all borders
                                          Container(
                                            height: _height * 0.08,
                                            width: _width * 0.23,
                                            decoration: BoxDecoration(
                                              color: ColorsUtils.appcolor,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  topLeft: Radius.circular(15)),
                                              // border: Border.all(color: ColorsUtils.blackColor),
                                            ),
                                            child: Center(
                                                child: Text(
                                              'Closed',
                                              style: TextStyle(
                                                  color: ColorsUtils.whiteColor,
                                                  fontSize: 16),
                                            )),
                                          ),
                                          // Second container with no left border
                                          Container(
                                            height: _height * 0.1,
                                            width: _width * 0.15,
                                            decoration: BoxDecoration(
                                              color: ColorsUtils.whiteColor,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              border: Border(
                                                // top: BorderSide(color: ColorsUtils.blackColor),
                                                // right: BorderSide(color: ColorsUtils.blackColor),
                                                // bottom: BorderSide(color: ColorsUtils.blackColor),
                                                // No left border
                                                left: BorderSide.none,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                userInstallationStatusList[
                                                            index]
                                                        .closed
                                                        .toString() ??
                                                    '0',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: _height * 0.01,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InstalledInstallationUI()));
                                },
                                child: Material(
                                  elevation: 10,
                                  color: ColorsUtils.whiteColor,
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    height: _height * 0.05,
                                    width: _width * 0.45,
                                    child: Row(
                                      children: [
                                        // First container with all borders
                                        Container(
                                          height: _height * 0.08,
                                          width: _width * 0.29,
                                          decoration: BoxDecoration(
                                            color: ColorsUtils.appcolor,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                                topLeft: Radius.circular(15)),
                                            // border: Border.all(color: ColorsUtils.blackColor),
                                          ),
                                          child: Center(
                                              child: Text(
                                            'Installed',
                                            style: TextStyle(
                                                color: ColorsUtils.whiteColor,
                                                fontSize: 16),
                                          )),
                                        ),
                                        // Second container with no left border
                                        Container(
                                          height: _height * 0.1,
                                          width: _width * 0.15,
                                          decoration: BoxDecoration(
                                            color: ColorsUtils.whiteColor,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                            border: Border(
                                              // top: BorderSide(color: ColorsUtils.blackColor),
                                              // right: BorderSide(color: ColorsUtils.blackColor),
                                              // bottom: BorderSide(color: ColorsUtils.blackColor),
                                              // No left border
                                              left: BorderSide.none,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              userInstallationStatusList[index]
                                                      .installed
                                                      .toString() ??
                                                  '0',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: _height * 0.02,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationZ(
                                      math.pi / 4,
                                    ),
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(10),
                                      shadowColor: Colors.blue,
                                      child: Container(
                                        width: _width * 0.15,
                                        height: _height * 0.07,
                                        decoration: BoxDecoration(
                                            color: ColorsUtils.appcolor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: InkWell(
                                          splashColor: Colors.blueAccent,
                                          onTap: () {},
                                          child: Center(
                                            child: Transform(
                                              alignment: Alignment.center,
                                              transform: Matrix4.rotationZ(
                                                -math.pi / 4,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    userInstallationStatusList[
                                                                index]
                                                            .dayOne
                                                            .toString() ??
                                                        '0',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    userInstallationStatusList[
                                                                index]
                                                            .nameOne
                                                            .toString() ??
                                                        '0',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationZ(
                                      math.pi / 4,
                                    ),
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(10),
                                      shadowColor: Colors.blue,
                                      child: Container(
                                        width: _width * 0.15,
                                        height: _height * 0.07,
                                        decoration: BoxDecoration(
                                            color: ColorsUtils.appcolor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: InkWell(
                                          splashColor: Colors.blueAccent,
                                          onTap: () {},
                                          child: Center(
                                            child: Transform(
                                              alignment: Alignment.center,
                                              transform: Matrix4.rotationZ(
                                                -math.pi / 4,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    userInstallationStatusList[
                                                                index]
                                                            .dayTwo
                                                            .toString() ??
                                                        '0',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    userInstallationStatusList[
                                                                index]
                                                            .nameTwo
                                                            .toString() ??
                                                        '0',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationZ(
                                      math.pi / 4,
                                    ),
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(10),
                                      shadowColor: Colors.blue,
                                      child: Container(
                                        width: _width * 0.15,
                                        height: _height * 0.07,
                                        decoration: BoxDecoration(
                                            color: ColorsUtils.appcolor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: InkWell(
                                          splashColor: Colors.blueAccent,
                                          onTap: () {},
                                          child: Center(
                                            child: Transform(
                                              alignment: Alignment.center,
                                              transform: Matrix4.rotationZ(
                                                -math.pi / 4,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    userInstallationStatusList[
                                                                index]
                                                            .dAyThree
                                                            .toString() ??
                                                        '0',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    userInstallationStatusList[
                                                                index]
                                                            .nameThree
                                                            .toString() ??
                                                        '0',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationZ(
                                      math.pi / 4,
                                    ),
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(10),
                                      shadowColor: Colors.blue,
                                      child: Container(
                                        width: _width * 0.15,
                                        height: _height * 0.07,
                                        decoration: BoxDecoration(
                                            color: ColorsUtils.appcolor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: InkWell(
                                          splashColor: Colors.blueAccent,
                                          onTap: () {},
                                          child: Center(
                                            child: Transform(
                                              alignment: Alignment.center,
                                              transform: Matrix4.rotationZ(
                                                -math.pi / 4,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    userInstallationStatusList[
                                                                index]
                                                            .dayFour
                                                            .toString() ??
                                                        '0',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    userInstallationStatusList[
                                                                index]
                                                            .nameFour
                                                            .toString() ??
                                                        '0',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: _height * 0.02,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(7),
                                    child: Container(
                                      height: _height * 0.04,
                                      width: _width * 0.17,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.white),
                                      child: Center(
                                        child: Text(
                                          userInstallationStatusList[index]
                                                  .instalaltionOne
                                                  .toString() ??
                                              '0',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(7),
                                    child: Container(
                                      height: _height * 0.04,
                                      width: _width * 0.17,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.white),
                                      child: Center(
                                        child: Text(
                                          userInstallationStatusList[index]
                                                  .instalaltionTwo
                                                  .toString() ??
                                              '0',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(7),
                                    child: Container(
                                      height: _height * 0.04,
                                      width: _width * 0.17,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.white),
                                      child: Center(
                                        child: Text(
                                          userInstallationStatusList[index]
                                                  .instalaltionThree
                                                  .toString() ??
                                              '0',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(7),
                                    child: Container(
                                      height: _height * 0.04,
                                      width: _width * 0.17,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        // color: Color(0xff6EACDA),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Center(
                                        child: Text(
                                          userInstallationStatusList[index]
                                                  .instalaltionFour
                                                  .toString() ??
                                              '0',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: _height * 0.004,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(7),
                                    child: Container(
                                      height: _height * 0.04,
                                      width: _width * 0.17,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.white),
                                      child: Center(
                                        child: Text(
                                          userInstallationStatusList[index]
                                                  .closeOne
                                                  .toString() ??
                                              '0',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(7),
                                    child: Container(
                                      height: _height * 0.04,
                                      width: _width * 0.17,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.white),
                                      child: Center(
                                        child: Text(
                                          userInstallationStatusList[index]
                                                  .closeTwo
                                                  .toString() ??
                                              '0',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(7),
                                    child: Container(
                                      height: _height * 0.04,
                                      width: _width * 0.17,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.white),
                                      child: Center(
                                        child: Text(
                                          userInstallationStatusList[index]
                                                  .closeThree
                                                  .toString() ??
                                              '0',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(7),
                                    child: Container(
                                      height: _height * 0.04,
                                      width: _width * 0.17,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        // color: Color(0xff6EACDA),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Center(
                                        child: Text(
                                          userInstallationStatusList[index]
                                                  .closeFour
                                                  .toString() ??
                                              '0',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: _height * 0.01,
                            ),
                            installarComperisonList.length > 5
                                ? Material(
                                    elevation: 5,
                                    child: Column(children: [
                                      Table(
                                        border: TableBorder(
                                          verticalInside: BorderSide(
                                              width: 1, color: Colors.grey),
                                        ),
                                        columnWidths: const {
                                          0: FlexColumnWidth(0.85),
                                          1: FlexColumnWidth(0.15),
                                        },
                                        children: [
                                          // TableRow(
                                          //   // Header row
                                          //   decoration: BoxDecoration(
                                          //       color: Colors.indigo, border: Border.all(width: 0.5)),
                                          //   children: [
                                          //     TableCell(
                                          //       child: Center(
                                          //         child: Text('',
                                          //             textAlign: TextAlign.left,
                                          //             style: TextStyle(
                                          //                 fontSize: tableFontSize,
                                          //                 color: Colors.white,
                                          //                 fontWeight: FontWeight.bold)),
                                          //       ),
                                          //     ),TableCell(
                                          //       child: Center(
                                          //         child: Text('',
                                          //             textAlign: TextAlign.left,
                                          //             style: TextStyle(
                                          //                 fontSize: tableFontSize,
                                          //                 color: Colors.white,
                                          //                 fontWeight: FontWeight.bold)),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          for (var i = 0;
                                              i <
                                                  min(
                                                      5,
                                                      installarComperisonList
                                                              ?.length ??
                                                          0);
                                              i++)
                                            TableRow(
                                              // Header row
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color: Colors.grey)),
                                              children: [
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3.0, left: 5),
                                                    child: Text(
                                                        installarComperisonList![
                                                                i]
                                                            .instalalr
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontSize:
                                                              tableFontSize,
                                                        )),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3.0, right: 5),
                                                    child: Text(
                                                        installarComperisonList![
                                                                i]
                                                            .installations
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                          fontSize:
                                                              tableFontSize,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ]),
                                  )
                                : Container(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 3, left: 300.0),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InstallarComperisonUI(
                                                  installarComparison:
                                                      installarComperisonList,
                                                )));
                                  },
                                  child: Text(
                                    'More...',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: ColorsUtils.appcolor),
                                  )),
                            ),
                            Material(
                              elevation: 5,
                              child: Container(
                                height: _height * 0.25,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: BarChart(
                                    BarChartData(
                                      alignment: BarChartAlignment.spaceBetween,
                                      maxY: 3000,
                                      // Adjust this based on your data range
                                      barTouchData: BarTouchData(enabled: true),
                                      titlesData: FlTitlesData(
                                          show: true,
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: (double value,
                                                  TitleMeta meta) {
                                                const months = [
                                                  'Jan',
                                                  'Feb',
                                                  'Mar',
                                                  'Apr',
                                                  'May',
                                                  'Jun',
                                                  'Jul',
                                                  'Aug',
                                                  'Sep',
                                                  'Oct',
                                                  'Nov',
                                                  'Dec'
                                                ];
                                                return Text(
                                                    months[value.toInt()]);
                                              },
                                            ),
                                          ),
                                          leftTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: false,
                                              // Adjust interval as needed
                                              // getTitlesWidget: (double value, TitleMeta meta) {
                                              //   return Text(value.toInt().toString());
                                              // },
                                            ),
                                          ),
                                          rightTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                            showTitles: false,
                                          )),
                                          topTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                            showTitles: false,
                                          ))),
                                      borderData: FlBorderData(show: false),
                                      barGroups: _buildBarGroups(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              }),
        ));
  }

  List<BarChartGroupData> _buildBarGroups() {
    if (monthlyInstallationStatusList.isEmpty) return [];

    Map<String, dynamic> monthlyData =
        monthlyInstallationStatusList[0].toJson();
    List<String> months = monthlyData.keys.toList();
    List<int> values = monthlyData.values.map((e) => int.parse(e)).toList();

    return List.generate(months.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: values[index].toDouble(),
            color: ColorsUtils.appcolor,
            width: 18,
          ),
        ],
      );
    });
  }

  Future get_MonthlyInstallationStatus() async {
    var response = await http.get(Uri.parse(MonthlyInstallationStatus));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      monthlyInstallationStatusList.clear();

      for (Map i in result) {
        monthlyInstallationStatusList
            .add(MonthlyInstallationStatusModel.fromJson(i));
      }
      setState(() {});
    } else {}
  }

  Future get_InstallationStatus() async {
    var response = await http.get(Uri.parse(InstallationStatus));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      userInstallationStatusList.clear();

      for (Map i in result) {
        userInstallationStatusList.add(UserInstallationStatusModel.fromJson(i));
      }
      setState(() {});
    } else {}
  }

  Future get_InstallarComperison() async {
    var response = await http.get(Uri.parse(InstallarComparison));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      installarComperisonList.clear();

      for (Map i in result) {
        installarComperisonList.add(InstallarComparisonModel.fromJson(i));
      }
      setState(() {});
    } else {}
  }

  getLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    name = sp.getString('userName');
    setState(() {});
  }

  Future<void> logout() async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove(SplashScreenState.KEYLOGIN);

    sharedPref.remove('userType');

    // Navigate to the Login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginUI()),
      (Route<dynamic> route) => false,
    );
    Snackbar.showSnackBar(context, 'Logout Successfully', Colors.teal);
  }
}
