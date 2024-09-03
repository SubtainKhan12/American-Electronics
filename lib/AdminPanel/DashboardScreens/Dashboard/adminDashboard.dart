import 'package:american_electronics/AdminPanel/DrawerUi/Drawer.dart';
import 'package:flutter/material.dart';

import '../../../LoginPages/loginscreen.dart';
import '../../../Utilities/Colors/colors.dart';

class AdminDashboardUI extends StatefulWidget {
  const AdminDashboardUI({super.key});

  @override
  State<AdminDashboardUI> createState() => _AdminDashboardUIState();
}

class _AdminDashboardUIState extends State<AdminDashboardUI> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(color: ColorsUtils.whiteColor),
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
      body: Padding(
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
                              '30',
                              // installerStatusList?.installed.toString() ?? '0',
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
                              '10',
                              // installerStatusList?.pending.toString() ?? '0',
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
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomersUI()));
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 10,
                    shadowColor: Color(0xffC4E4FF),
                    child: Container(
                      height: _height * 0.06,
                      width: _width * 0.4,
                      decoration: BoxDecoration(
                        color: Color(0xffC4E4FF),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: _width * 0.03,
                          ),
                          Image.asset(
                            'assets/install.png',
                            color: Colors.blueAccent,
                            height: 30,
                          ),
                          VerticalDivider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                          // SizedBox(width: 20,),
                          Text(
                            'AC Installation',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
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
                      width: _width * 0.4,
                      decoration: BoxDecoration(
                        color: Color(0xffC4E4FF),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: _width * 0.03,
                          ),
                          Image.asset(
                            'assets/location-pin.png',
                            color: Colors.green,
                            height: 30,
                          ),
                          VerticalDivider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                          // SizedBox(width: 20,),
                          Text(
                            'City',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Material(
                borderRadius: BorderRadius.circular(5),
                elevation: 10,
                shadowColor: Color(0xffC4E4FF),
                child: Container(
                  height: _height * 0.06,
                  width: _width * 0.4,
                  decoration: BoxDecoration(
                    color: Color(0xffC4E4FF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: _width * 0.03,
                      ),
                      Image.asset(
                        'assets/complaint.png',
                        color: Colors.red,
                        height: 30,
                      ),
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      // SizedBox(width: 20,),
                      Text(
                        'Item',
                        style:
                            TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
