import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../APIs/apis.dart';
import '../../../../Models/InstallarComperison/InstallarComparisonModel.dart';
import '../../../../Utilities/Colors/colors.dart';
import 'InstallarAllInstallations/installarAllInstallations.dart';

class InstallarsUI extends StatefulWidget {
  const InstallarsUI({super.key});

  @override
  State<InstallarsUI> createState() => _InstallarsUIState();
}

class _InstallarsUIState extends State<InstallarsUI> {
  List<InstallarComparisonModel> installarComperisonList = [];
  List<InstallarComparisonModel> searchInstallarComperisonList = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_InstallarComperison();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Installers',
          style: TextStyle(
              color: ColorsUtils.whiteColor, fontSize: _height * 0.023),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: RefreshIndicator(
        onRefresh: get_InstallarComperison,
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
                    : searchInstallarComperisonList.isEmpty
                        ? const Center(
                            child: Text(
                            "Data Not Found",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ))
                        : ListView.builder(
                            itemCount: searchInstallarComperisonList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InstallarAllInstallationsUI(
                                                installarComparisonList:
                                                    searchInstallarComperisonList[
                                                        index],
                                              ))).then(
                                      (value) => get_InstallarComperison());
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          searchInstallarComperisonList[index]
                                              .instalalr
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: _height * 0.015,
                                          ),
                                        ),
                                        Text(
                                          searchInstallarComperisonList[index]
                                              .installations
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: _height * 0.02,
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
      ),
    );
  }

  Future get_InstallarComperison() async {
    var response = await http.get(Uri.parse(InstallarComparison));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      installarComperisonList.clear();

      for (Map i in result) {
        installarComperisonList.add(InstallarComparisonModel.fromJson(i));
      }
      setState(() {
        searchInstallarComperisonList = List.from(installarComperisonList);
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void search(String query) {
    setState(() {
      searchInstallarComperisonList = installarComperisonList.where((category) {
        final customerNameMatches =
            category.instalalr?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        return customerNameMatches;
      }).toList();
    });
  }
}
