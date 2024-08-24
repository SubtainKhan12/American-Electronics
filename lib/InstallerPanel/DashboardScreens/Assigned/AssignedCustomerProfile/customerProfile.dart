import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:american_electronics/Utilities/Colors/colors.dart';
import '../../../../APIs/apis.dart';

import '../../../../Models/Assigned/AssignedModel.dart';
import '../../../../Models/GetComplain/GetComplainModel.dart';

class AssignedCustomerProfileUI extends StatefulWidget {
  AssignedModel assignedModel;

  AssignedCustomerProfileUI({super.key, required this.assignedModel});

  @override
  State<AssignedCustomerProfileUI> createState() =>
      _AssignedCustomerProfileUIState();
}

class _AssignedCustomerProfileUIState extends State<AssignedCustomerProfileUI> {
  List<GetComplainModel> getComplainList = [];
  String? colCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Post_Complain();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: getComplainList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: getComplainList.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Complain # : ',
                                  style: TextStyle(
                                      color: ColorsUtils.blackColor,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: getComplainList[index]
                                      .comp
                                      .toString()
                                      .trim(),
                                  style: TextStyle(
                                      color: ColorsUtils.blackColor,
                                      fontWeight: FontWeight.bold)),
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Date : ',
                                  style: TextStyle(
                                      color: ColorsUtils.blackColor,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: getComplainList[index]
                                      .date
                                      .toString()
                                      .trim(),
                                  style:
                                      TextStyle(color: ColorsUtils.blackColor)),
                            ]))
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: InputDecorator(
                              decoration: InputDecoration(
                                  labelText: 'Customer Information',
                                  labelStyle: TextStyle(
                                      color: ColorsUtils.appcolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  )),
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                            width: _width * 0.18,
                                            child: const Text(
                                              'Mobile#',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          width: _width * 0.02,
                                          child: const Text(
                                            ':',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            // width: _width * 0.25,
                                            child: Text(getComplainList[index]
                                                .mobile
                                                .toString()
                                                .trim()))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: _width * 0.18,
                                            child: const Text(
                                              'Customer',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          width: _width * 0.02,
                                          child: const Text(
                                            ':',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            // width: _width * 0.25,
                                            child: Flexible(
                                          child: Text(getComplainList[index]
                                              .customer
                                              .toString()
                                              .trim()),
                                        ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: _width * 0.18,
                                            child: const Text(
                                              'Address',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          width: _width * 0.02,
                                          child: const Text(
                                            ':',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            // width: _width * 0.25,
                                            child: Flexible(
                                          child: Text(getComplainList[index]
                                              .address1
                                              .toString()
                                              .trim()),
                                        ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: _width * 0.18,
                                            child: const Text(
                                              '',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          width: _width * 0.02,
                                          child: const Text(
                                            ':',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            // width: _width * 0.25,
                                            child: Flexible(
                                          child: Text(getComplainList[index]
                                              .address2
                                              .toString()
                                              .trim()),
                                        ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: _width * 0.18,
                                            child: const Text(
                                              'City',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          width: _width * 0.02,
                                          child: const Text(
                                            ':',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            // width: _width * 0.25,
                                            child: Flexible(
                                          child: Text(getComplainList[index]
                                              .city
                                              .toString()
                                              .trim()),
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: InputDecorator(
                              decoration: InputDecoration(
                                  labelText: 'Item Information',
                                  labelStyle: TextStyle(
                                      color: ColorsUtils.appcolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  )),
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: _width * 0.18,
                                            child: const Text(
                                              'Dealer',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          width: _width * 0.02,
                                          child: const Text(
                                            ':',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            // width: _width * 0.25,
                                            child: Flexible(
                                          child: Text(getComplainList[index]
                                              .dealer
                                              .toString()
                                              .trim()),
                                        ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: _width * 0.18,
                                            child: const Text(
                                              'Item',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          width: _width * 0.02,
                                          child: const Text(
                                            ':',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            // width: _width * 0.25,
                                            child: Flexible(
                                          child: Text(getComplainList[index]
                                              .item
                                              .toString()
                                              .trim()),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: _width * 0.18,
                                            child: const Text(
                                              'Serial No',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          width: _width * 0.02,
                                          child: const Text(
                                            ':',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            // width: _width * 0.25,
                                            child: Flexible(
                                          child: Text(getComplainList[index]
                                              .serialNo
                                              .toString()
                                              .trim()),
                                        ))
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          // height: _height * 0.14,
                          child: InputDecorator(
                              decoration: InputDecoration(
                                  labelText: 'Engineer Information',
                                  labelStyle: TextStyle(
                                      color: ColorsUtils.appcolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  )),
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: _width * 0.18,
                                            child: const Text(
                                              'Engineer',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          width: _width * 0.02,
                                          child: const Text(
                                            ':',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            // width: _width * 0.25,
                                            child: Flexible(
                                          child: Text(getComplainList[index]
                                              .installar
                                              .toString()
                                              .trim()),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: _width * 0.18,
                                            child: const Text(
                                              'Mobile No',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          width: _width * 0.02,
                                          child: const Text(
                                            ':',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            // width: _width * 0.25,
                                            child:
                                                 Flexible(child: Text(getComplainList[index]
                                                    .installarMobile
                                                    .toString()
                                                    .trim()))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: _width * 0.18,
                                            child: const Text(
                                              'Assign On',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          width: _width * 0.02,
                                          child: const Text(
                                            ':',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            // width: _width * 0.25,
                                            child: Flexible(
                                          child: Text(getComplainList[index]
                                              .assignedOn
                                              .toString()
                                              .trim()),
                                        ))
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          // height: _height * 0.14,
                          // color: Color(0xff9DBDFF),
                          child: InputDecorator(
                              decoration: InputDecoration(
                                  labelText: 'Engineer Visit',
                                  labelStyle: TextStyle(
                                      color: ColorsUtils.appcolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  )),
                              child: Column(
                                children: [
                                  if (getComplainList[index]
                                              .date1
                                              .toString()
                                              .trim() ==
                                          'null' &&
                                      getComplainList[index]
                                              .remarks1
                                              .toString()
                                              .trim() ==
                                          'null')
                                    Container()
                                  else
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: _width * 0.22,
                                              child: Flexible(
                                                  child: Text(
                                                getComplainList[index]
                                                            .date1
                                                            .toString()
                                                            .trim() ==
                                                        'null'
                                                    ? ''
                                                    : getComplainList[index]
                                                        .date1
                                                        .toString()
                                                        .trim(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ))),
                                          Container(
                                            width: _width * 0.02,
                                            child: const Text(
                                              ':',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Flexible(
                                            child: Container(
                                                // width: _width * 0.25,
                                                child: Flexible(
                                              child: Text(getComplainList[index]
                                                          .remarks1
                                                          .toString()
                                                          .trim() ==
                                                      'null'
                                                  ? ''
                                                  : getComplainList[index]
                                                      .remarks1
                                                      .toString()
                                                      .trim()),
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (getComplainList[index]
                                              .date2
                                              .toString()
                                              .trim() ==
                                          'null' &&
                                      getComplainList[index]
                                              .remarks2
                                              .toString()
                                              .trim() ==
                                          'null')
                                    Container()
                                  else
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: _width * 0.22,
                                              child: Flexible(
                                                child: Text(
                                                  getComplainList[index]
                                                              .date2
                                                              .toString()
                                                              .trim() ==
                                                          'null'
                                                      ? ''
                                                      : getComplainList[index]
                                                          .date2
                                                          .toString()
                                                          .trim(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Container(
                                            width: _width * 0.02,
                                            child: const Text(
                                              ':',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Flexible(
                                            child: Container(
                                                // width: _width * 0.25,
                                                child: Flexible(
                                              child: Text(getComplainList[index]
                                                          .remarks2
                                                          .toString()
                                                          .trim() ==
                                                      'null'
                                                  ? ''
                                                  : getComplainList[index]
                                                      .remarks2
                                                      .toString()
                                                      .trim()),
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (getComplainList[index]
                                              .date3
                                              .toString()
                                              .trim() ==
                                          'null' &&
                                      getComplainList[index]
                                              .remarks3
                                              .toString()
                                              .trim() ==
                                          'null')
                                    Container()
                                  else
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: _width * 0.22,
                                              child: Flexible(
                                                child: Text(
                                                  getComplainList[index]
                                                              .date3
                                                              .toString()
                                                              .trim() ==
                                                          'null'
                                                      ? ''
                                                      : getComplainList[index]
                                                          .date3
                                                          .toString()
                                                          .trim(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Container(
                                            width: _width * 0.02,
                                            child: const Text(
                                              ':',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Flexible(
                                            child: Container(
                                                // width: _width * 0.25,
                                                child: Flexible(
                                              child: Text(getComplainList[index]
                                                          .remarks3
                                                          .toString()
                                                          .trim() ==
                                                      'null'
                                                  ? ''
                                                  : getComplainList[index]
                                                      .remarks3
                                                      .toString()
                                                      .trim()),
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (getComplainList[index]
                                              .date4
                                              .toString()
                                              .trim() ==
                                          'null' &&
                                      getComplainList[index]
                                              .remarks4
                                              .toString()
                                              .trim() ==
                                          'null')
                                    Container()
                                  else
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: _width * 0.22,
                                              child: Flexible(
                                                child: Text(
                                                  getComplainList[index]
                                                              .date4
                                                              .toString()
                                                              .trim() ==
                                                          'null'
                                                      ? ''
                                                      : getComplainList[index]
                                                          .date4
                                                          .toString()
                                                          .trim(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Container(
                                            width: _width * 0.02,
                                            child: const Text(
                                              ':',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                              // width: _width * 0.25,
                                              child: Flexible(
                                            child: Text(getComplainList[index]
                                                        .remarks4
                                                        .toString()
                                                        .trim() ==
                                                    'null'
                                                ? ''
                                                : getComplainList[index]
                                                    .remarks4
                                                    .toString()
                                                    .trim()),
                                          )),
                                        ],
                                      ),
                                    ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          // height: _height * 0.14,
                          // color: Color(0xff9DBDFF),
                          child: InputDecorator(
                              decoration: InputDecoration(
                                  labelText: 'Status',
                                  labelStyle: TextStyle(
                                      color: ColorsUtils.appcolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  )),
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: _width * 0.22,
                                            child: const Text(
                                              'Status',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          width: _width * 0.02,
                                          child: const Text(
                                            ':',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            // width: _width * 0.25,
                                            child: Flexible(
                                          child: Text(
                                            getComplainList[index]
                                                .status
                                                .toString()
                                                .trim(),
                                            style: TextStyle(
                                                color: ColorsUtils.redColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: _width * 0.22,
                                            child: const Text(
                                              'Remarks',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          width: _width * 0.02,
                                          child: const Text(
                                            ':',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            // width: _width * 0.25,
                                            child: Flexible(
                                          child: Text(getComplainList[index]
                                              .remarks
                                              .toString()
                                              .trim()),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: _width * 0.22,
                                            child: const Text(
                                              'Close Date',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          width: _width * 0.02,
                                          child: const Text(
                                            ':',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            // width: _width * 0.25,
                                            child: Flexible(
                                          child: Text(
                                            getComplainList[index]
                                                .closeDate
                                                .toString()
                                                .trim(),
                                            style: TextStyle(
                                                color: ColorsUtils.redColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  Future Post_Complain() async {
    var response = await http.post(Uri.parse(GetComplain), body: {
      'FCmpNum': widget.assignedModel.cmp.toString(),
    });
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      getComplainList.clear();
      for (Map i in result) {
        getComplainList.add(GetComplainModel.fromJson(i));
      }
      setState(() {
        // loading = false;
        // searchAssignedList = List.from(assignedList);
      });
    } else {
      // setState(() {
      //   // loading = false;
      // });
    }
  }
}
