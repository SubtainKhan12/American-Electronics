import 'dart:convert';

import 'package:american_electronics/Models/CancelledInstallations/CancledInstallationModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../APIs/apis.dart';
import '../../../Utilities/Colors/colors.dart';

class CanceledInstallationUI extends StatefulWidget {
  const CanceledInstallationUI({super.key});

  @override
  State<CanceledInstallationUI> createState() => _CanceledInstallationUIState();
}

class _CanceledInstallationUIState extends State<CanceledInstallationUI> {
  List<CancledInstallationModel> canceledInstallationList = [];
  List<CancledInstallationModel> searchCanceledInstallation = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_CanceledInstallation();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Canceled Installation',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: RefreshIndicator(
        onRefresh: get_CanceledInstallation,
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
                    : searchCanceledInstallation.isEmpty
                        ? const Center(
                            child: Text(
                            "Data Not Found",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ))
                        : ListView.builder(
                            itemCount: searchCanceledInstallation.length,
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
                                                searchCanceledInstallation[
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
                                                searchCanceledInstallation[
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
                                            searchCanceledInstallation[index]
                                                .tcstnam
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                searchCanceledInstallation[index]
                                                    .tmobnum
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(width: _width * 0.02),
                                              Text(
                                                searchCanceledInstallation[index]
                                                            .tcmpsts
                                                            .toString() ==
                                                        "C"
                                                    ? 'Canceled'
                                                    : searchCanceledInstallation[
                                                            index]
                                                        .tcmpsts
                                                        .toString(),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.red),
                                              ),
                                            ],
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

  Future get_CanceledInstallation() async {
    var response = await http.get(Uri.parse(CancelledInstallations));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      canceledInstallationList.clear();
      for (Map i in result) {
        canceledInstallationList.add(CancledInstallationModel.fromJson(i));
        // print(result);
      }
      setState(() {
        loading = false;
        searchCanceledInstallation = List.from(canceledInstallationList);
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void search(String query) {
    setState(() {
      searchCanceledInstallation = canceledInstallationList.where((category) {
        final customerNameMatches =
            category.tcstnam?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        return customerNameMatches;
      }).toList();
    });
  }
}
