import 'package:flutter/material.dart';

import '../../../Utilities/Colors/colors.dart';

class DashboardUI extends StatefulWidget {
  const DashboardUI({super.key});

  @override
  State<DashboardUI> createState() => _DashboardUIState();
}

class _DashboardUIState extends State<DashboardUI> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.appcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  shadowColor: ColorsUtils.lightblueColor,
                  borderRadius: BorderRadius.circular(5),
                  color: ColorsUtils.lightblueColor,
                  borderOnForeground: true,
                  elevation: 5,
                  child: SizedBox(
                    height: h * 0.08,
                    width: w * 0.3,
                    child: Column(
                      children: [
                        Text(
                          'Assigned',
                          style: TextStyle(
                              fontSize: 16,
                              color: ColorsUtils.whiteColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Divider(
                          color: ColorsUtils.blackColor,
                        ),
                        Text(
                          '55',
                          style: TextStyle(
                              fontSize: 16,
                              color: ColorsUtils.whiteColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: h * 0.5,
                  width: w * 0.3,
                  child: Column(

                    children: [
                      Container(
                        height: h * 0.04,
                        decoration: BoxDecoration(
                            color: ColorsUtils.lightblueColor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                          border: Border.all(color: ColorsUtils.blackColor)
                        ),

                        child: Center(child: Text('Installed', style: TextStyle(
                            fontSize: 16,
                            color: ColorsUtils.whiteColor,
                            fontWeight: FontWeight.bold),),),
                      ),
                      Container(
                        height: h * 0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5)),
                            border: Border.all(color: ColorsUtils.blackColor)
                        ),
                        child: Center(child: Text('53' ,style: TextStyle(
                            fontSize: 53,

                            fontWeight: FontWeight.w500),)),)
                    ],
                  ),
                ),
                Material(
                  shadowColor: ColorsUtils.lightblueColor,
                  borderRadius: BorderRadius.circular(5),
                  color: ColorsUtils.lightblueColor,
                  borderOnForeground: true,
                  elevation: 5,
                  child: SizedBox(
                    height: h * 0.08,
                    width: w * 0.3,
                    child: Column(
                      children: [
                        Text(
                          'Pending',
                          style: TextStyle(
                              fontSize: 16,
                              color: ColorsUtils.whiteColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Divider(
                          color: ColorsUtils.blackColor,
                        ),
                        Text(
                          '2',
                          style: TextStyle(
                              fontSize: 16,
                              color: ColorsUtils.whiteColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
