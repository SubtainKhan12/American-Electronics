import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../APIs/apis.dart';
import '../../../../Models/ClosedInstallation/ClosedInstallationsModel.dart';
import '../../../../Models/InstalledInstalltionModel.dart';
import '../../../../Utilities/Colors/colors.dart';
import 'package:http/http.dart' as http;

import 'InstalledCustomerDetails.dart';
import 'closeInstalledInstallation.dart';

class InstalledInstallationUI extends StatefulWidget {
  const InstalledInstallationUI({super.key});

  @override
  State<InstalledInstallationUI> createState() =>
      _InstalledInstallationUIState();
}

class _InstalledInstallationUIState extends State<InstalledInstallationUI> {
  List<InstalledInstalltionModel> InstalledInstallationList = [];
  List<InstalledInstalltionModel> searchInstalledInstallation = [];
  bool loading = true;
  String formatDate(String dateString) {
    DateTime parsedDate = DateTime.parse(dateString); // Parse the date string
    return DateFormat('dd-MM-yyyy').format(parsedDate); // Format the date
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_InstalledInstallation();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorsUtils.lightblue,
      appBar: AppBar(
        title: Text(
          'Installed Installation',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: RefreshIndicator(
        onRefresh: get_InstalledInstallation,
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
                    : searchInstalledInstallation.isEmpty
                        ? const Center(
                            child: Text(
                            "Data Not Found",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ))
                        : ListView.builder(
                            itemCount: searchInstalledInstallation.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => _buildBottomSheet(
                                        context,
                                        searchInstalledInstallation[index]),
                                  ).then((value)=>get_InstalledInstallation());
                                },
                                child: Card(
                                  color: ColorsUtils.whiteColor,
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
                                                  searchInstalledInstallation[
                                                          index]
                                                      .cmp
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xffF58634),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  '  -  ',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  formatDate( searchInstalledInstallation[
                                                  index]
                                                      .date
                                                      .toString(),),

                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Text(

                                              searchInstalledInstallation[index]
                                                  .customer
                                                  .toString(),

                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  searchInstalledInstallation[
                                                          index]
                                                      .mobile
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
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

  Widget _buildBottomSheet(
      BuildContext context, InstalledInstalltionModel model) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          child: DraggableScrollableSheet(
            initialChildSize: 0.35,
            maxChildSize: 0.9,
            minChildSize: 0.3,
            builder: (_, controller) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: ListView(
                      controller: controller,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          model.customer.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            _showPhoneDialog(model.mobile.toString());
                          },
                          child: Text(
                            model.mobile.toString(),
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: ColorsUtils.appcolor,
                              decorationThickness: 2,
                              fontSize: 16,
                              color: ColorsUtils.appcolor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Customer CMP: ${model.cmp}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        InstalledCustomerDetailsUI(
                                          installedInstalltionList: model,
                                        ))).then((value)=>get_InstalledInstallation());
                          },
                          child: const ListTile(
                            leading: Icon(Icons.info),
                            title: Text("Installation Detail"),
                            // subtitle: Text("Customer CMP: ${model.cmp}"),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CloseInstalledInstallationUI(
                                          installedInstalltionList: model,
                                        ))).then((value)=>get_InstalledInstallation());
                          },
                          child: const ListTile(
                            leading: Icon(Icons.call_missed_outgoing_rounded),
                            title: Text("Close Installation"),
                            // subtitle: Text("Customer CMP: ${model.cmp}"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
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

  Future get_InstalledInstallation() async {
    var response = await http.get(Uri.parse(InstalledInstallations));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      InstalledInstallationList.clear();

      for (Map i in result) {
        InstalledInstallationList.add(InstalledInstalltionModel.fromJson(i));
      }
      setState(() {
        searchInstalledInstallation = List.from(InstalledInstallationList);
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void search(String query) {
    setState(() {
      searchInstalledInstallation = InstalledInstallationList.where((category) {
        final customerNameMatches =
            category.customer?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        final mobileNumberMatches =
            category.mobile?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        final complainNumberMatches =
            category.cmp?.toLowerCase().contains(query.toLowerCase()) ?? false;
        return customerNameMatches ||
            mobileNumberMatches ||
            complainNumberMatches;
      }).toList();
    });
  }
}
