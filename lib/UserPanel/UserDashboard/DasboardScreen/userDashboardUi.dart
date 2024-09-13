import 'dart:convert';
import 'dart:math' as math;
import 'package:american_electronics/UserPanel/UserDashboard/UnassignedInstallation/unassignedInsatllation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../APIs/apis.dart';
import '../../../LoginPages/loginscreen.dart';
import '../../../Models/UserInstallationStatus/UserInstallationStatusModel.dart';
import '../../../Utilities/Colors/colors.dart';

class UserDashboardUI extends StatefulWidget {
  const UserDashboardUI({super.key});

  @override
  State<UserDashboardUI> createState() => _UserDashboardUIState();
}

class _UserDashboardUIState extends State<UserDashboardUI> {
  List<UserInstallationStatusModel> userInstallationStatusList = [];
  String? name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_InstallationStatus();
    getLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Subtract 2 days from the current date
    DateTime dateMinusTwo = currentDate.subtract(Duration(days: 2));

    // Format the date and day name
    String formattedDate = DateFormat('dd').format(dateMinusTwo);
    String dayName = DateFormat('EE').format(dateMinusTwo);

    //   return Text(
    //     '$formattedDate ($dayName)',
    //     style: TextStyle(fontSize: 24),
    //   );
    // }
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const LoginUI()));
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: get_InstallationStatus,
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
                                                UserUnassignedInstallationUI()));
                                  },
                                  child: Material(
                                    borderRadius: BorderRadius.circular(5),
                                    elevation: 10,
                                    shadowColor: Color(0xffC4E4FF),
                                    child: Container(
                                      height: _height * 0.06,
                                      width: _width * 0.43,
                                      decoration: BoxDecoration(
                                        // color: Color(0xffC4E4FF),
                                        gradient: LinearGradient(colors: [
                                          ColorsUtils.whiteColor,
                                          ColorsUtils.lightblueColor
                                        ]),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: _width * 0.03,
                                          ),
                                          Container(
                                            width: _width * 0.22,
                                            child: Text(
                                              'UnAssigned',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: Colors.black,
                                            thickness: 1,
                                          ),
                                          Text(
                                            userInstallationStatusList[index]
                                                    .unassigned
                                                    .toString() ??
                                                '0',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> ExpenseUI()));
                                  },
                                  child: Material(
                                    borderRadius: BorderRadius.circular(5),
                                    elevation: 10,
                                    shadowColor: Color(0xffC4E4FF),
                                    child: Container(
                                      height: _height * 0.06,
                                      width: _width * 0.43,
                                      decoration: BoxDecoration(
                                        // color: Color(0xffC4E4FF),
                                        gradient: LinearGradient(colors: [
                                          ColorsUtils.whiteColor,
                                          ColorsUtils.lightblueColor
                                        ]),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: _width * 0.03,
                                          ),
                                          Container(
                                            width: _width * 0.22,
                                            child: Text(
                                              'Pending',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: Colors.black,
                                            thickness: 1,
                                          ),
                                          Text(
                                            userInstallationStatusList[index]
                                                    .pending
                                                    .toString() ??
                                                '0',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: _height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> ExpenseUI()));
                                  },
                                  child: Material(
                                    borderRadius: BorderRadius.circular(5),
                                    elevation: 10,
                                    shadowColor: Color(0xffC4E4FF),
                                    child: Container(
                                      height: _height * 0.06,
                                      width: _width * 0.43,
                                      decoration: BoxDecoration(
                                        // color: Color(0xffC4E4FF),
                                        gradient: LinearGradient(colors: [
                                          ColorsUtils.whiteColor,
                                          ColorsUtils.lightblueColor
                                        ]),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: _width * 0.03,
                                          ),
                                          Container(
                                            width: _width * 0.22,
                                            child: Text(
                                              'Installed',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: Colors.black,
                                            thickness: 1,
                                          ),
                                          Text(
                                            userInstallationStatusList[index]
                                                    .installed
                                                    .toString() ??
                                                '0',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> ClosedInstallationUI()));
                                  },
                                  child: Material(
                                    borderRadius: BorderRadius.circular(5),
                                    elevation: 10,
                                    shadowColor: Color(0xffC4E4FF),
                                    child: Container(
                                      height: _height * 0.06,
                                      width: _width * 0.43,
                                      decoration: BoxDecoration(
                                        // color: Color(0xffC4E4FF),
                                        gradient: LinearGradient(colors: [
                                          ColorsUtils.whiteColor,
                                          ColorsUtils.lightblueColor
                                        ]),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: _width * 0.03,
                                          ),
                                          Container(
                                            width: _width * 0.22,
                                            child: Text(
                                              'Closed',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: Colors.black,
                                            thickness: 1,
                                          ),
                                          Text(
                                            userInstallationStatusList[index]
                                                    .closed
                                                    .toString() ??
                                                '0',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: _height * 0.02,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7.0),
                              child: InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => CanceledInstallationUI()));
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(5),
                                  elevation: 10,
                                  shadowColor: Color(0xffC4E4FF),
                                  child: Container(
                                    height: _height * 0.06,
                                    width: _width * 0.43,
                                    decoration: BoxDecoration(
                                      // color: Color(0xffC4E4FF),
                                      gradient: LinearGradient(colors: [
                                        ColorsUtils.whiteColor,
                                        ColorsUtils.lightblueColor
                                      ]),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: _width * 0.03,
                                        ),
                                        Container(
                                          width: _width * 0.22,
                                          child: Text(
                                            'Canceled',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1,
                                        ),
                                        Text(
                                          userInstallationStatusList[index]
                                                  .cancelled
                                                  .toString() ??
                                              '0',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
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
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 10.0),
                            //   child: Text(
                            //     'Pending Complains',
                            //     style: TextStyle(
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.bold,
                            //         fontStyle: FontStyle.italic),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: _height * 0.02,
                            // ),
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
                                  Container(
                                    height: _height * 0.04,
                                    width: _width * 0.17,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                        color: Color(0xff6EACDA)

                                    ),
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
                                  Container(
                                    height: _height * 0.04,
                                    width: _width * 0.17,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                        color: Color(0xff6EACDA)

                                    ),
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
                                  Container(
                                    height: _height * 0.04,
                                    width: _width * 0.17,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                        color: Color(0xff6EACDA)

                                    ),
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
                                  Container(
                                    height: _height * 0.04,
                                    width: _width * 0.17,
                                    decoration: BoxDecoration(
                                        color: Color(0xff6EACDA),
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
                                  Container(
                                    height: _height * 0.04,
                                    width: _width * 0.17,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                        color: Color(0xff6EACDA)
                                    ),
                                    child: Center(
                                      child: Text(
                                        userInstallationStatusList[index]
                                                .instalaltionOne
                                                .toString() ??
                                            '0',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: _height * 0.04,
                                    width: _width * 0.17,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Color(0xff6EACDA)
                                    ),
                                    child: Center(
                                      child: Text(
                                        userInstallationStatusList[index]
                                                .instalaltionTwo
                                                .toString() ??
                                            '0',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: _height * 0.04,
                                    width: _width * 0.17,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                        color: Color(0xff6EACDA)

                                    ),
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
                                  Container(
                                    height: _height * 0.04,
                                    width: _width * 0.17,
                                    decoration: BoxDecoration(
                                        color: Color(0xff6EACDA),
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
              }),
        ));
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

  getLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    name = sp.getString('userName');
    setState(() {});
  }
}
