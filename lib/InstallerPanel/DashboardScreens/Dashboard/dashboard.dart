import 'dart:convert';
import 'package:american_electronics/InstallerPanel/DashboardScreens/Installed/installed.dart';
import 'package:american_electronics/LoginPages/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../APIs/apis.dart';
import '../../../Models/InstallerStatus/InstallarStatusModel.dart';
import '../../../SplashScreen/splashScreen.dart';
import '../../../Utilities/Colors/colors.dart';
import '../../../Utilities/Snackbar/snackbar.dart';
import '../Assigned/assigned.dart';
import '../Pending/pending.dart';

class DashboardUI extends StatefulWidget {
  const DashboardUI({super.key});

  @override
  State<DashboardUI> createState() => _DashboardUIState();
}

class _DashboardUIState extends State<DashboardUI> {
  InstallarStatusModel? installerStatusList;
  String? colCode, name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello ${name.toString().trim()}',
          style: TextStyle(color: ColorsUtils.whiteColor, fontSize: 18),
        ),
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
        backgroundColor: ColorsUtils.appcolor,
        actions: [
          IconButton(
              onPressed: () {
               logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: post_InstallarStatus,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AssignedUI()));
                      },
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        // surfaceTintColor: Colors.blue,
                        shadowColor: Colors.white,
                        child: Container(
                          height: h * 0.15,
                          width: w * 0.3,
                          child: Column(
                            children: [
                              Container(
                                height: h * 0.05,
                                decoration: BoxDecoration(
                                    color: ColorsUtils.lightblueColor,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    border: Border.all(
                                        color: ColorsUtils.greyColor)),
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
                                height: h * 0.1,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5)),
                                    border: Border.all(
                                        color: ColorsUtils.greyColor)),
                                child: Center(
                                    child: Text(
                                  installerStatusList?.assigned
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InstalledUI()));
                      },
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        // surfaceTintColor: Colors.blue,
                        shadowColor: Colors.white,
                        child: Container(
                          height: h * 0.15,
                          width: w * 0.3,
                          child: Column(
                            children: [
                              Container(
                                height: h * 0.05,
                                decoration: BoxDecoration(
                                    color: ColorsUtils.lightblueColor,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    border: Border.all(
                                        color: ColorsUtils.greyColor)),
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
                                height: h * 0.1,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5)),
                                    border: Border.all(
                                        color: ColorsUtils.greyColor)),
                                child: Center(
                                    child: Text(
                                  installerStatusList?.installed
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PendingUI()));
                      },
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        // surfaceTintColor: Colors.blue,
                        shadowColor: Colors.white,
                        child: Container(
                          height: h * 0.15,
                          width: w * 0.3,
                          child: Column(
                            children: [
                              Container(
                                height: h * 0.05,
                                decoration: BoxDecoration(
                                    color: ColorsUtils.lightblueColor,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    border: Border.all(
                                        color: ColorsUtils.greyColor)),
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
                                height: h * 0.1,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5)),
                                    border: Border.all(
                                        color: ColorsUtils.greyColor)),
                                child: Center(
                                    child: Text(
                                  installerStatusList?.pending
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future post_InstallarStatus() async {
    var response = await http.post(Uri.parse(InstallarStatus), body: {
      'FIntCod': colCode.toString(),
    });
    var result = jsonDecode(response.body);
    setState(() {
      installerStatusList = InstallarStatusModel.fromJson(result);
    });
  }

  getLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    colCode = sp.getString('colCode');
    name = sp.getString('userName');
    setState(() {});
    post_InstallarStatus();
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
