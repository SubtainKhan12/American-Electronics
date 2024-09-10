import 'dart:convert';

import 'package:american_electronics/AdminPanel/DrawerUi/Drawer.dart';
import 'package:american_electronics/Models/AdminInstallationStatus/AdminInstallationStatusModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../APIs/apis.dart';
import '../../../LoginPages/loginscreen.dart';
import '../../../Utilities/Colors/colors.dart';
import '../CanceledInstallation/canceledInstallation.dart';
import '../ClosedInstallation/closedInstallation.dart';
import '../UnassignedInstallation/unassignedInsatllation.dart';

class AdminDashboardUI extends StatefulWidget {
  const AdminDashboardUI({super.key});

  @override
  State<AdminDashboardUI> createState() => _AdminDashboardUIState();
}

class _AdminDashboardUIState extends State<AdminDashboardUI> {
  List<AdminInstallationStatusModel> adminInstallationStatusList = [];
  String? name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_InstallationStatus();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello ${name.toString().trim()}',
          style: TextStyle(color: ColorsUtils.whiteColor,fontSize: 18),
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
      drawer: AdminDrawerUI(),
      body: RefreshIndicator(
        onRefresh: get_InstallationStatus,
        child: ListView.builder(
            itemCount: adminInstallationStatusList.length,
            itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => AssignedUI()));
                      },
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        // surfaceTintColor: Colors.blue,
                        shadowColor: Colors.white,
                        child: Container(
                          height: _height * 0.15,
                          width: _width * 0.3,
                          child: Column(
                            children: [
                              Container(
                                height: _height * 0.05,
                                decoration: BoxDecoration(
                                    color: ColorsUtils.lightblueColor,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    border:
                                    Border.all(color: ColorsUtils.greyColor)),
                                child: Center(
                                  child: Text(
                                    'Assigned',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: ColorsUtils.whiteColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                height: _height * 0.1,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5)),
                                    border:
                                    Border.all(color: ColorsUtils.greyColor)),
                                child: Center(
                                    child: Text(
                                      '40',
                                      // installerStatusList?.assigned.toString() ?? '0',
                                      style: TextStyle(
                                          fontSize: 53,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade400),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => InstalledUI()));
                      },
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        // surfaceTintColor: Colors.blue,
                        shadowColor: Colors.white,
                        child: Container(
                          height: _height * 0.15,
                          width: _width * 0.3,
                          child: Column(
                            children: [
                              Container(
                                height: _height * 0.05,
                                decoration: BoxDecoration(
                                    color: ColorsUtils.lightblueColor,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    border:
                                    Border.all(color: ColorsUtils.greyColor)),
                                child: Center(
                                  child: Text(
                                    'Installed',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: ColorsUtils.whiteColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                height: _height * 0.1,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5)),
                                    border:
                                    Border.all(color: ColorsUtils.greyColor)),
                                child: Center(
                                    child: Text(
                                      adminInstallationStatusList[index]
                                          .installed
                                          .toString().trim()  == 'null'?
                                          '0': adminInstallationStatusList[index]
                                          .installed
                                          .toString().trim(),
                                      style: TextStyle(
                                          fontSize: 53,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade400),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => PendingUI()));
                      },
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        // surfaceTintColor: Colors.blue,
                        shadowColor: Colors.white,
                        child: Container(
                          height: _height * 0.15,
                          width: _width * 0.3,
                          child: Column(
                            children: [
                              Container(
                                height: _height * 0.05,
                                decoration: BoxDecoration(
                                    color: ColorsUtils.lightblueColor,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    border:
                                    Border.all(color: ColorsUtils.greyColor)),
                                child: Center(
                                  child: Text(
                                    'Pending',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: ColorsUtils.whiteColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                height: _height * 0.1,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5)),
                                    border:
                                    Border.all(color: ColorsUtils.greyColor)),
                                child: Center(
                                    child: Text(
                                      adminInstallationStatusList[index]
                                          .pending
                                          .toString()
                                          .trim() ??
                                          '0',
                                      style: TextStyle(
                                          fontSize: 53,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade400),
                                    )),
                              )
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> UnassignedInstallationUI()));
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: _width * 0.03,
                              ),
                              Container(
                                width: _width * 0.22,
                                child: Text(
                                  'UnAssigned',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              Text(
                                adminInstallationStatusList[index]
                                    .unassigned
                                    .toString() ??
                                    '0',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: _width * 0.03,
                              ),
                              Container(
                                width: _width * 0.22,
                                child: Text(
                                  'Pending',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              Text(
                                adminInstallationStatusList[index].pending.toString() ??
                                    '0',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: _width * 0.03,
                              ),
                              Container(
                                width: _width * 0.22,
                                child: Text(
                                  'Installed',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              Text(
                                adminInstallationStatusList[index]
                                    .installed
                                    .toString() ??
                                    '0',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ClosedInstallationUI()));
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: _width * 0.03,
                              ),
                              Container(
                                width: _width * 0.22,
                                child: Text(
                                  'Closed',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              Text(
                                adminInstallationStatusList[index].closed.toString() ??
                                    '0',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
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
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CanceledInstallationUI()));
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: _width * 0.03,
                            ),
                            Container(
                              width: _width * 0.22,
                              child: Text(
                                'Canceled',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                            Text(
                              adminInstallationStatusList[index].cancelled.toString() ??
                                  '0',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Pending Complains',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      ColorsUtils.lightblueColor,
                      ColorsUtils.orangeCrystal,
                      // ColorsUtils.blackColor,
                    ]),
                  ),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      '2 Days',
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorsUtils.whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      adminInstallationStatusList[index].twoDays.toString() ?? '0',
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorsUtils.whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: ColorsUtils.whiteColor,
                    ),
                    onTap: () {
                      // Navigate to user profile page
                    },
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      ColorsUtils.lightblueColor,
                      ColorsUtils.orangeCrystal,
                      // ColorsUtils.blackColor,
                    ]),
                  ),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      '5 Days',
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorsUtils.whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      adminInstallationStatusList[index].fiveDays.toString() ?? '0',
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorsUtils.whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: ColorsUtils.whiteColor,
                    ),
                    onTap: () {
                      // Navigate to user profile page
                    },
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      ColorsUtils.lightblueColor,
                      ColorsUtils.orangeCrystal,
                      // ColorsUtils.blackColor,
                    ]),
                  ),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      '7 Days',
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorsUtils.whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      adminInstallationStatusList[index].sevenDays.toString() ?? '0',
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorsUtils.whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: ColorsUtils.whiteColor,
                    ),
                    onTap: () {
                      // Navigate to user profile page
                    },
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      ColorsUtils.lightblueColor,
                      ColorsUtils.orangeCrystal,
                      // ColorsUtils.blackColor,
                    ]),
                  ),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      '7 Days +',
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorsUtils.whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      adminInstallationStatusList[index].sevenDaysPlus.toString() ??
                          '0',
                      style: TextStyle(
                          fontSize: 14,
                          color: ColorsUtils.whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: ColorsUtils.whiteColor,
                    ),
                    onTap: () {
                      // Navigate to user profile page
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      )
    );
  }

  Future get_InstallationStatus() async {
    var response = await http.get(Uri.parse(InstallationStatus));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      adminInstallationStatusList.clear();

      for (Map i in result) {
        adminInstallationStatusList
            .add(AdminInstallationStatusModel.fromJson(i));
      }
      setState(() {});
    } else {}
  }
  getLoginInfo()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    name = sp.getString('userName');
    setState(() {
    });
  }
}
