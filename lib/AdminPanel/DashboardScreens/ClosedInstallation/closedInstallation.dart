import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../APIs/apis.dart';
import '../../../Models/ClosedInstallation/ClosedInstallationsModel.dart';
import '../../../Utilities/Colors/colors.dart';

class ClosedInstallationUI extends StatefulWidget {
  const ClosedInstallationUI({super.key});

  @override
  State<ClosedInstallationUI> createState() => _ClosedInstallationUIState();
}

class _ClosedInstallationUIState extends State<ClosedInstallationUI> {
  List<ClosedInstallationsModel> closedInstallationList = [];
  List<ClosedInstallationsModel> searchClosedInstallation = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_ClosedInstallation();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Closed Installation',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: RefreshIndicator(
        onRefresh: get_ClosedInstallation,
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
                    : searchClosedInstallation.isEmpty
                    ? const Center(
                    child: Text(
                      "Data Not Found",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ))
                    : ListView.builder(
                    itemCount: searchClosedInstallation.length,
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
                                        searchClosedInstallation[
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
                                        searchClosedInstallation[
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
                                    searchClosedInstallation[index]
                                        .tcstnam
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        searchClosedInstallation[index]
                                            .tmobnum
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(width: _width * 0.02,),
                                      Text(
                                        searchClosedInstallation[index]
                                            .tcmpsts
                                            .toString() ==
                                            "I"
                                            ? 'Installed'
                                            : searchClosedInstallation[
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

  Future get_ClosedInstallation() async {
    var response = await http.get(Uri.parse(ClosedInstallations));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      closedInstallationList.clear();

      for (Map i in result) {
        closedInstallationList.add(ClosedInstallationsModel.fromJson(i));
        // print(result);
      }
      setState(() {
        loading = false;
        searchClosedInstallation = List.from(closedInstallationList);
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void search(String query) {
    setState(() {
      searchClosedInstallation = closedInstallationList.where((category) {
        final customerNameMatches =
            category.tcstnam?.toLowerCase().contains(query.toLowerCase()) ??
                false;

        return customerNameMatches;
      }).toList();
    });
  }
}
