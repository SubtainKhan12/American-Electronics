import 'dart:convert';

import 'package:american_electronics/Models/CancelledInstallations/CancledInstallationModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../APIs/apis.dart';
import '../../../../Utilities/Colors/colors.dart';
import 'cancelCustomerDetails.dart';

class CanceledInstallationUI extends StatefulWidget {
  const CanceledInstallationUI({super.key});

  @override
  State<CanceledInstallationUI> createState() => _CanceledInstallationUIState();
}

class _CanceledInstallationUIState extends State<CanceledInstallationUI> {
  List<CancledInstallationModel> canceledInstallationList = [];
  List<CancledInstallationModel> searchCanceledInstallation = [];
  bool loading = true;
  String formatDate(String dateString) {
    DateTime parsedDate = DateTime.parse(dateString); // Parse the date string
    return DateFormat('dd-MM-yyyy').format(parsedDate); // Format the date
  }

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
      backgroundColor: ColorsUtils.lightblue,
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
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => _buildBottomSheet(
                                        context,
                                        searchCanceledInstallation[index]),
                                  );
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
                                                  searchCanceledInstallation[
                                                          index]
                                                      .cmp
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xffF58634),
                                                      fontWeight: FontWeight.w500),
                                                ),
                                                Text(
                                                  '  -  ',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  formatDate(searchCanceledInstallation[
                                                  index]
                                                      .date
                                                      .toString(),),

                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              searchCanceledInstallation[index]
                                                  .customer
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  searchCanceledInstallation[index]
                                                      .mobile
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                // SizedBox(width: _width * 0.02),
                                                // Text(
                                                //   searchCanceledInstallation[index]
                                                //               .tcmpsts
                                                //               .toString() ==
                                                //           "C"
                                                //       ? 'Canceled'
                                                //       : searchCanceledInstallation[
                                                //               index]
                                                //           .tcmpsts
                                                //           .toString(),
                                                //   style: const TextStyle(
                                                //       fontSize: 12,
                                                //       color: Colors.red),
                                                // ),
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
      BuildContext context, CancledInstallationModel model) {
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
                                        CancelCustomerDetailsUI(
                                          canceledInstallationList: model,
                                        )));
                          },
                          child: const ListTile(
                            leading: Icon(Icons.info),
                            title: Text("Complain Detail"),
                            // subtitle: Text("Customer CMP: ${model.cmp}"),
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 PendingCustomerDetail(
                        //                     pendingModel: model)));
                        //   },
                        //   child: const ListTile(
                        //     leading: Icon(Icons.info),
                        //     title: Text("Complain Detail"),
                        //     // subtitle: Text("Customer CMP: ${model.cmp}"),
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: (){
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 PendingVisitScreen(pendingModel: model,)));
                        //   },
                        //   child: const ListTile(
                        //     leading: Icon(Icons.location_on),
                        //     title: Text("Technician Visit"),
                        //     // subtitle: Text("Visit Date: ${model.date}"),
                        //   ),
                        // ),
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
