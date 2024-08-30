import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../APIs/apis.dart';
import '../../../../Models/GetComplain/GetComplainModel.dart';
import '../../../../Models/Pending/PendingModel.dart';
import '../../../../Utilities/Colors/colors.dart';
import '../../../../Utilities/Snackbar/snackbar.dart';
import 'VisitForm/pendingVisitFormUi.dart';

class PendingVisitScreen extends StatefulWidget {
  PendingModel pendingModel;

  PendingVisitScreen({super.key, required this.pendingModel});

  @override
  State<PendingVisitScreen> createState() => _PendingVisitScreenState();
}

class _PendingVisitScreenState extends State<PendingVisitScreen> {
  List<GetComplainModel> getComplainList = [];
  bool isLoading = true;
  bool isDataEmpty = false;

  @override
  void initState() {
    super.initState();
    Post_Complain();
  }

  @override
  Widget build(BuildContext context) {
    bool areAllVisitsCompleted = getComplainList.isNotEmpty &&
        getComplainList[0].date1 != null &&
        getComplainList[0].date2 != null &&
        getComplainList[0].date3 != null &&
        getComplainList[0].date4 != null &&
        getComplainList[0].remarks1 != null &&
        getComplainList[0].remarks2 != null &&
        getComplainList[0].remarks3 != null &&
        getComplainList[0].remarks4 != null;
    return RefreshIndicator(
      onRefresh: Post_Complain,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Visit',
            style: TextStyle(color: ColorsUtils.whiteColor),
          ),
          backgroundColor: ColorsUtils.appcolor,
          iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: isDataEmpty || areAllVisitsCompleted
              ? null
              : () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PendingVisitFormUI(
                                getComplainModel: getComplainList[0],
                              ))).then((value) => Post_Complain());
                },
          child: Icon(Icons.add),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : isDataEmpty
                ? Center(child: Text("No data available"))
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: ListView.builder(
                      itemCount: getComplainList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (getComplainList[index].date1 != null &&
                                  getComplainList[index].remarks1 != null)
                                SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getComplainList[index]
                                                .date1
                                                .toString()
                                                .trim(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            getComplainList[index]
                                                .remarks1
                                                .toString()
                                                .trim(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              if (getComplainList[index].date2 != null &&
                                  getComplainList[index].remarks2 != null)
                                SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getComplainList[index]
                                                .date2
                                                .toString()
                                                .trim(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            getComplainList[index]
                                                .remarks2
                                                .toString()
                                                .trim(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              if (getComplainList[index].date3 != null &&
                                  getComplainList[index].remarks3 != null)
                                SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getComplainList[index]
                                                .date3
                                                .toString()
                                                .trim(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            getComplainList[index]
                                                .remarks3
                                                .toString()
                                                .trim(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              if (getComplainList[index].date4 != null &&
                                  getComplainList[index].remarks4 != null)
                                SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getComplainList[index]
                                                .date4
                                                .toString()
                                                .trim(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            getComplainList[index]
                                                .remarks4
                                                .toString()
                                                .trim(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }

  Future Post_Complain() async {
    var response = await http.post(Uri.parse(GetComplain), body: {
      'FCmpNum': widget.pendingModel.cmp.toString(),
    });
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      getComplainList.clear();
      if (result.isEmpty) {
        setState(() {
          isLoading = false;
          isDataEmpty = true;
        });
      } else {
        for (Map i in result) {
          getComplainList.add(GetComplainModel.fromJson(i));
        }
        setState(() {
          isLoading = false;
          isDataEmpty = getComplainList.isEmpty;
        });
      }
    } else {
      setState(() {
        isLoading = false;
        isDataEmpty = true;
      });
    }
  }
}
