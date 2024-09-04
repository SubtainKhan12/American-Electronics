import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../APIs/apis.dart';

import '../../../Models/UnassignedInstallation/UnassignedInstallationModel.dart';
import '../../../Utilities/Colors/colors.dart';

class UnassignedInstallationUI extends StatefulWidget {
  const UnassignedInstallationUI({super.key});

  @override
  State<UnassignedInstallationUI> createState() => _UnassignedInstallationUIState();
}

class _UnassignedInstallationUIState extends State<UnassignedInstallationUI> {
  List<UnassignedInstallationModel> unassignedInstallationList = [];
  List<UnassignedInstallationModel> searchunassignedInstallation = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_UnassignedInstallation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Unassigned Installation',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: RefreshIndicator(
        onRefresh: get_UnassignedInstallation,
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
                    : searchunassignedInstallation.isEmpty
                    ? const Center(
                    child: Text(
                      "Data Not Found",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ))
                    : ListView.builder(
                    itemCount: searchunassignedInstallation.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        searchunassignedInstallation[
                                        index]
                                            .ttrnnum
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.blue,
                                            fontWeight:
                                            FontWeight.bold),
                                      ),
                                      Text(
                                        ' - ',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.bold),
                                      ),
                                      Text(
                                        searchunassignedInstallation[
                                        index]
                                            .ttrndat
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    searchunassignedInstallation[index]
                                        .tcstnam
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    searchunassignedInstallation[index]
                                        .tmobnum
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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

  Future get_UnassignedInstallation() async {
    var response = await http.get(Uri.parse(UnassignedInstallations));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      unassignedInstallationList.clear();

      for (Map i in result) {
        unassignedInstallationList.add(UnassignedInstallationModel.fromJson(i));
        // print(result);
      }
      setState(() {
        loading = false;
        searchunassignedInstallation = List.from(unassignedInstallationList);
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void search(String query) {
    setState(() {
      searchunassignedInstallation = unassignedInstallationList.where((category) {
        final customerNameMatches =
            category.tcstnam?.toLowerCase().contains(query.toLowerCase()) ??
                false;

        return customerNameMatches;
      }).toList();
    });
  }
}
