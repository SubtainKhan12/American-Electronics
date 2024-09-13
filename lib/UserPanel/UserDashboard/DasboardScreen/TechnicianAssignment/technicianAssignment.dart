import 'dart:convert';

import 'package:american_electronics/Utilities/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:http/http.dart' as http;
import '../../../../APIs/apis.dart';
import '../../../../Models/ActiveTechnicians/ActiveInstallar.dart';
import '../../../../Models/UnassignedInstallation/UnassignedInstallationModel.dart';

class UserTechnicianAssignmentUI extends StatefulWidget {
  UnassignedInstallationModel unassignedInstallationList;

  UserTechnicianAssignmentUI(
      {super.key, required this.unassignedInstallationList});

  @override
  State<UserTechnicianAssignmentUI> createState() =>
      _UserTechnicianAssignmentUIState();
}

class _UserTechnicianAssignmentUIState
    extends State<UserTechnicianAssignmentUI> {
  final translator = GoogleTranslator();
  bool _translatetext = false;
  List<ActiveInstallar> _activeInstallarList = []; // Store API data
  List<ActiveInstallar> _filterActiveInstallarList = []; // Store filtered data
  bool _isDropdownOpen = false; // Control dropdown visibility
  TextEditingController _searchcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchDataFromApi(); // Fetch data from API when widget initializes
  }

  void _onTextChanged(String input) {
    setState(() {
      _filterActiveInstallarList = _activeInstallarList
          .where((item) => item.tintdsc!
              .toLowerCase()
              .contains(input.toLowerCase())) // Convert each item to lowercase
          .toList(); // Filter data based on input
    });
  }

  void _onItemTapped(String item) {
    setState(() {
      _searchcontroller.text = item; // Set selected item to TextField
      _isDropdownOpen = false; // Close the dropdown
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if (_isDropdownOpen) {
          setState(() {
            _isDropdownOpen = false; // Close the dropdown if it's open
          });
          return false; // Prevent the back button from popping the screen
        }
        return true; // Allow the screen to pop if dropdown is not open
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Technician Assignment',
            style: TextStyle(color: ColorsUtils.whiteColor),
          ),
          backgroundColor: ColorsUtils.appcolor,
          centerTitle: true,
          iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              children: [
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: _width * 0.2,
                                    child: const Text(
                                      'Customer',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                Container(
                                  width: _width * 0.02,
                                  child: const Text(
                                    ':',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                    // width: _width * 0.25,
                                    child: Flexible(
                                  child: _translatetext == false
                                      ? Text(widget
                                          .unassignedInstallationList.tcstnam
                                          .toString()
                                          .trim())
                                      : FutureBuilder<String>(
                                          future: translateTextToUrdu(widget
                                              .unassignedInstallationList
                                              .tcstnam
                                              .toString()
                                              .trim()),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Text(
                                                  'isLoading....'); // Show a spinner while translating
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                widget
                                                    .unassignedInstallationList
                                                    .tcstnam
                                                    .toString()
                                                    .trim(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            } else {
                                              return Text(
                                                snapshot.data ??
                                                    widget
                                                        .unassignedInstallationList
                                                        .tcstnam
                                                        .toString()
                                                        .trim(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            }
                                          },
                                        ),
                                ))
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                    width: _width * 0.2,
                                    child: const Text(
                                      'Mobile#',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                Container(
                                  width: _width * 0.02,
                                  child: const Text(
                                    ':',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                    // width: _width * 0.25,
                                    child: Text(widget
                                        .unassignedInstallationList.tmobnum
                                        .toString()
                                        .trim()))
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                    width: _width * 0.2,
                                    child: const Text(
                                      'Complain#',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                Container(
                                  width: _width * 0.02,
                                  child: const Text(
                                    ':',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                    // width: _width * 0.25,
                                    child: Text(widget
                                        .unassignedInstallationList.ttrnnum
                                        .toString()
                                        .trim()))
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                    width: _width * 0.2,
                                    child: const Text(
                                      'Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                Container(
                                  width: _width * 0.02,
                                  child: const Text(
                                    ':',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                    // width: _width * 0.25,
                                    child: Text(widget
                                        .unassignedInstallationList.ttrndat
                                        .toString()
                                        .trim()))
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _searchcontroller,
                  decoration: InputDecoration(
                    labelText: 'Technicians',
                    suffixIcon: _isDropdownOpen
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                _isDropdownOpen = false;
                              });
                            },
                            child: Icon(
                              Icons.arrow_drop_up_outlined,
                            ))
                        : Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _onTextChanged(value);
                    setState(() {
                      _isDropdownOpen = true;
                    });
                  },
                  onTap: () {
                    setState(() {
                      _isDropdownOpen = true;
                    });
                  },
                ),
                // Dropdown menu showing filtered items
                _isDropdownOpen && _filterActiveInstallarList.isNotEmpty
                    ? Container(
                        height: _height * 0.4,
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.only(top: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _filterActiveInstallarList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_filterActiveInstallarList[index]
                                  .tintdsc
                                  .toString()),
                              onTap: () {
                                _onItemTapped(_filterActiveInstallarList[index]
                                    .tintdsc
                                    .toString()); // Select item
                              },
                            );
                          },
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> translateTextToUrdu(String text) async {
    try {
      final translation = await translator.translate(text, to: 'ur');
      return translation.text ?? text;
    } catch (e) {
      print('Translation error: $e');
      return text;
    }
  }

  Future<void> _fetchDataFromApi() async {
    final response = await http.get(Uri.parse(GetActiveInstallar));

    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _activeInstallarList.clear();
      for (Map i in result) {
        _activeInstallarList.add(ActiveInstallar.fromJson(i));
      }
      setState(() {
        _filterActiveInstallarList =
            _activeInstallarList; // Initially, show all data
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
}
