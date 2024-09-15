import 'dart:convert';

import 'package:american_electronics/Utilities/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../../APIs/apis.dart';
import '../../../../Models/ActiveInstallar/ActiveInstallar.dart';
import '../../../../Models/UnassignedInstallation/UnassignedInstallationModel.dart';
import '../../../../Utilities/Loader/loader.dart';
import '../../../../Utilities/Snackbar/snackbar.dart';

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
  TextEditingController _phonecontroller = TextEditingController();

  String? _selectedInstallarId;

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

  void _onItemTapped(ActiveInstallar selectedInstallar) {
    setState(() {
      _searchcontroller.text = selectedInstallar.tintdsc.toString().trim();
      _phonecontroller.text = selectedInstallar.tmobnum
          .toString()
          .trim();

      _selectedInstallarId = selectedInstallar.tintcod.toString(); // Store technician ID
      _isDropdownOpen = false;
      print(_selectedInstallarId);
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
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _translatetext = false;
                        });
                      },
                      child: Text(
                        'Eng',
                        style: TextStyle(
                          fontSize: 16,
                          color: !_translatetext ? Colors.yellow : Colors.white,
                          fontWeight: !_translatetext
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text("|",
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorsUtils.whiteColor,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _translatetext = true;
                        });
                      },
                      child: Text(
                        'اردو',
                        style: TextStyle(
                          fontSize: 16,
                          color: _translatetext ? Colors.yellow : Colors.white,
                          fontWeight: _translatetext
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
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
                          text: widget.unassignedInstallationList.ttrnnum
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
                          text: widget.unassignedInstallationList.ttrndat
                              .toString()
                              .trim(),
                          style: TextStyle(color: ColorsUtils.blackColor)),
                    ]))
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: _height * 0.01,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: _width * 0.2,
                                    child: const Text(
                                      'Address 1',
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
                                          .unassignedInstallationList.tadd001
                                          .toString()
                                          .trim())
                                      : FutureBuilder<String>(
                                          future: translateTextToUrdu(widget
                                              .unassignedInstallationList
                                              .tadd001
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
                                                    .tadd001
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
                                                        .tadd001
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: _width * 0.2,
                                    child: const Text(
                                      'Address 2',
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
                                          .unassignedInstallationList.tadd002
                                          .toString()
                                          .trim())
                                      : FutureBuilder<String>(
                                          future: translateTextToUrdu(widget
                                              .unassignedInstallationList
                                              .tadd002
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
                                                    .tadd002
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
                                                        .tadd002
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: _width * 0.2,
                                    child: const Text(
                                      'City',
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
                                          .unassignedInstallationList.city
                                          .toString()
                                          .trim())
                                      : FutureBuilder<String>(
                                          future: translateTextToUrdu(widget
                                              .unassignedInstallationList.city
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
                                                    .city
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
                                                        .city
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
                              children: [
                                Container(
                                    width: _width * 0.2,
                                    child: const Text(
                                      'Dealer',
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
                                  child: Text(widget
                                              .unassignedInstallationList.dealer
                                              .toString()
                                              .trim() ==
                                          'null'
                                      ? ''
                                      : widget.unassignedInstallationList.dealer
                                          .toString()
                                          .trim()),
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
                                      'item',
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
                                  child: Text(widget.unassignedInstallationList
                                              .ttrndsc
                                              .toString()
                                              .trim() ==
                                          'null'
                                      ? ''
                                      : widget
                                          .unassignedInstallationList.ttrndsc
                                          .toString()
                                          .trim()),
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
                                      'Serial#',
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
                                                .unassignedInstallationList
                                                .titmser
                                                .toString()
                                                .trim() ==
                                            'null'
                                        ? ''
                                        : widget
                                            .unassignedInstallationList.titmser
                                            .toString()
                                            .trim()))
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: _height * 0.01,
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
                                  .toString()
                                  .trim()),
                              onTap: () {
                                _onItemTapped(_filterActiveInstallarList[
                                    index]); // Select item
                              },
                            );
                          },
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: _height * 0.01,
                ),
                InkWell(
                  onTap: (){
                    _showPhoneDialog(_phonecontroller.text);
                  },
                  child: TextField(
                    controller: _phonecontroller,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Technician Phone No',
                      suffixIcon: Icon(Icons.phone_android),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                ),
                Container(
                    width: _width * 1,
                    height: _height * 0.07,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7))),
                        onPressed: () {
                          post_SaveInstallarAssignment();
                          CircularIndicator.showLoader(context);
                        },
                        child: Text('Assign')))
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

  Future post_SaveInstallarAssignment() async {
    var response = await http.post(Uri.parse(SaveInstallarAssignment), body: {
      'FIntCod': _selectedInstallarId.toString().trim(),
      'FTrnNum': widget.unassignedInstallationList.ttrnnum.toString().trim(),
    });
    var result = jsonDecode(response.body);
    if (result['error'] == 200) {
      Snackbar.showSnackBar(context, result['message'], Colors.teal);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      Snackbar.showSnackBar(context, 'Error you must select Installer', Colors.red);
      Navigator.pop(context);
    }
  }
  Future<void> _showPhoneDialog(String phoneNumber) async {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          content: Text('Would you like to call or message on WhatsApp?'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.phone,
                  size: _height * 0.04, color: Color(0xff06D001)),
              onPressed: () {
                _makePhoneCall(phoneNumber);
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                _openWhatsApp(phoneNumber);
                Navigator.of(context).pop();
              },
              child: Container(
                height: _height * 0.04,
                child: Image.asset('assets/whatsapp.png'),
              ),
            )
          ],
        );
      },
    );
  }

  ///-----------------------> Function to Navigate to phone dail <-----------------///
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  ///-------------------> Function to Navigate to whatsapp <------------------///
  Future<void> _openWhatsApp(String phoneNumber) async {
    final launchUri = Uri(
      scheme: 'https',
      path: 'wa.me/$phoneNumber',
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Could not launch WhatsApp for $phoneNumber';
    }
  }
}
