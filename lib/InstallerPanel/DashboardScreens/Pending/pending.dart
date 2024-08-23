import 'dart:convert';

import 'package:american_electronics/InstallerPanel/DashboardScreens/Assigned/CustomerProfile/customerProfile.dart';
import 'package:american_electronics/Models/Pending/PendingModel.dart';
import 'package:american_electronics/Utilities/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../APIs/apis.dart';

class PendingUI extends StatefulWidget {
  const PendingUI({super.key});

  @override
  State<PendingUI> createState() => _PendingUIState();
}

class _PendingUIState extends State<PendingUI> {
  List<PendingModel> pendingList = [];
  String? colCode;
  bool loading = true;  // State variable to control the loading state

  @override
  void initState() {
    super.initState();
    getLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pending Applications',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: loading  // Show loader if loading is true
                  ? Center(child: CircularProgressIndicator())
                  : pendingList.isEmpty  // Show message if no data is available
                  ? Center(child: Text("No applications are pending"))
                  : ListView.builder(
                  itemCount: pendingList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomerProfileUI()));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    pendingList[index].cmp.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const Text(
                                    '  -  ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    pendingList[index].date.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                pendingList[index].customer.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                pendingList[index].mobile.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future Post_Pending() async {
    var response = await http.post(Uri.parse(Pending), body: {
      'FIntCod': colCode.toString(),
    });
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      pendingList.clear();
      for (Map i in result) {
        pendingList.add(PendingModel.fromJson(i));
      }
      setState(() {
        loading = false;  // Update loading state once data is fetched
      });
    } else {
      setState(() {
        loading = false;  // Update loading state in case of an error
      });
    }
  }

  getLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    colCode = sp.getString('colCode');
    setState(() {});
    Post_Pending();
  }
}

