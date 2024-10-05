import 'dart:convert';

import 'package:american_electronics/UserPanel/UserDashboard/DarwerPages/Installars/InstallarAllInstallations/InstallationsDetails/installationDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../../APIs/apis.dart';
import '../../../../../Models/InstallarAllInstallations/InstallarAllInstallationModel.dart';
import '../../../../../Models/InstallarComperison/InstallarComparisonModel.dart';
import '../../../../../Utilities/Colors/colors.dart';

class InstallarAllInstallationsUI extends StatefulWidget {
  InstallarComparisonModel installarComparisonList;

  InstallarAllInstallationsUI(
      {super.key, required this.installarComparisonList});

  @override
  State<InstallarAllInstallationsUI> createState() =>
      _InstallarAllInstallationsUIState();
}

class _InstallarAllInstallationsUIState
    extends State<InstallarAllInstallationsUI> {
  List<InstallarAllInstallationModel> installarAllInstallationList = [];
  List<InstallarAllInstallationModel> searchInstallarAllInstallationList = [];
  bool loading = true;

  String formatDate(String dateString) {
    DateTime parsedDate = DateTime.parse(dateString); // Parse the date string
    return DateFormat('dd-MM-yyyy').format(parsedDate); // Format the date
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    post_InstallarAllInstallations();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.installarComparisonList.instalalr.toString().trim()} Installation',
          style: TextStyle(
              color: ColorsUtils.whiteColor, fontSize: _height * 0.02),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: RefreshIndicator(
        onRefresh: post_InstallarAllInstallations,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  search(value);
                },
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
                child: loading
                    ? const Center(child: CircularProgressIndicator())
                    : searchInstallarAllInstallationList.isEmpty
                        ? Center(
                            child: Text(
                            "Data Not Found",
                            style: TextStyle(
                                fontSize: _height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ))
                        : ListView.builder(
                            itemCount:
                                searchInstallarAllInstallationList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InstallationDetailsUI(
                                                  installarAllInstallationList:
                                                      searchInstallarAllInstallationList[
                                                          index]))).then(
                                      (value) =>
                                          post_InstallarAllInstallations());
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: getStatusColor(
                                          searchInstallarAllInstallationList[
                                                  index]
                                              .status
                                              .toString()),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          searchInstallarAllInstallationList[
                                                                  index]
                                                              .cmp
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize:
                                                                _height * 0.017,
                                                            color: Color(
                                                                0xffF58634),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        Text(
                                                          '  -  ',
                                                          style: TextStyle(
                                                            fontSize:
                                                                _height * 0.017,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        Text(
                                                          formatDate(
                                                            searchInstallarAllInstallationList[
                                                                    index]
                                                                .date
                                                                .toString(),
                                                          ),
                                                          style: TextStyle(
                                                            fontSize:
                                                                _height * 0.017,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      searchInstallarAllInstallationList[
                                                              index]
                                                          .customer
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize:
                                                            _height * 0.013,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          searchInstallarAllInstallationList[
                                                                  index]
                                                              .mobile
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize:
                                                                _height * 0.013,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'I':
        return Colors.green;
      case 'P':
        return Colors.red;
      case 'C':
        return Colors.blue;
      default:
        return Colors.transparent; // Default if no match
    }
  }

  Future post_InstallarAllInstallations() async {
    var response = await http.post(Uri.parse(InstallarAllInstallations), body: {
      'FIntCod': widget.installarComparisonList.tintcod.toString().trim(),
    });
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      installarAllInstallationList.clear();

      for (Map i in result) {
        installarAllInstallationList
            .add(InstallarAllInstallationModel.fromJson(i));
      }
      setState(() {
        searchInstallarAllInstallationList =
            List.from(installarAllInstallationList);
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void search(String query) {
    setState(() {
      searchInstallarAllInstallationList =
          installarAllInstallationList.where((category) {
        final customerNameMatches =
            category.customer?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        final complainMatches =
            category.cmp?.toLowerCase().contains(query.toLowerCase()) ?? false;
        return customerNameMatches || complainMatches;
      }).toList();
    });
  }
}
