import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../../APIs/apis.dart';
import '../../../../Models/Pending/UserPendingInstallationsModel.dart';
import '../../../../Utilities/Colors/colors.dart';
import 'PendingCustomerDetails/customerProfile.dart';
import 'VisitScreen/pendingVisitScreen.dart';

class UserPendingInstallationUI extends StatefulWidget {
  const UserPendingInstallationUI({super.key});

  @override
  State<UserPendingInstallationUI> createState() =>
      _UserPendingInstallationUIState();
}

class _UserPendingInstallationUIState extends State<UserPendingInstallationUI> {
  List<UserPendingInstallationsModel> pendingInstallationList = [];
  List<UserPendingInstallationsModel> searchPendingInstallationList = [];
  String? colCode;
  bool loading = true; // State variable to control the loading state
  String formatDate(String dateString) {
    DateTime parsedDate = DateTime.parse(dateString); // Parse the date string
    return DateFormat('dd-MM-yyyy').format(parsedDate); // Format the date
  }

  @override
  void initState() {
    super.initState();
    get_PendingInstallations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.lightblue,
      appBar: AppBar(
        title: Text(
          'Pending Installation',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: RefreshIndicator(
          onRefresh: get_PendingInstallations,
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
                child: loading // Show loader if loading is true
                    ? Center(child: CircularProgressIndicator())
                    : searchPendingInstallationList
                            .isEmpty // Show message if no data is available
                        ? Center(
                            child: Text(
                            "No applications are pending",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ))
                        : ListView.builder(
                            itemCount: searchPendingInstallationList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => _buildBottomSheet(
                                        context,
                                        searchPendingInstallationList[index]),
                                  ).then((value)=> get_PendingInstallations());
                                },
                                child: Card(
                                  color: ColorsUtils.whiteColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              searchPendingInstallationList[index]
                                                  .cmp
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xffF58634),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const Text(
                                              '  -  ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              formatDate(searchPendingInstallationList[index]
                                                  .date
                                                  .toString(),),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          searchPendingInstallationList[index]
                                              .customer
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          searchPendingInstallationList[index]
                                              .mobile
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 12,
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

  Widget _buildBottomSheet(
      BuildContext context, UserPendingInstallationsModel model) {
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
                        // Container(
                        //   child: InputDecorator(
                        //       decoration: InputDecoration(
                        //           labelText: 'Installer Information',
                        //           labelStyle: TextStyle(
                        //               color: ColorsUtils.appcolor,
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 20),
                        //           border: OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(0),
                        //           )),
                        //       child: Column(
                        //         children: [
                        //           Container(
                        //             child: Row(
                        //               children: [
                        //                 Container(
                        //                     width: _width * 0.2,
                        //                     child: const Text(
                        //                       'Installer',
                        //                       style: TextStyle(
                        //                           fontWeight: FontWeight.bold),
                        //                     )),
                        //                 Container(
                        //                   width: _width * 0.02,
                        //                   child: const Text(
                        //                     ':',
                        //                     style: TextStyle(
                        //                         fontWeight: FontWeight.bold),
                        //                   ),
                        //                 ),
                        //                 Container(
                        //                     // width: _width * 0.25,
                        //                     child: Flexible(
                        //                   child: Text(model.installar
                        //                               .toString()
                        //                               .trim() ==
                        //                           'null'
                        //                       ? ''
                        //                       : model.installar
                        //                           .toString()
                        //                           .trim()),
                        //                 ))
                        //               ],
                        //             ),
                        //           ),
                        //           Container(
                        //             child: Row(
                        //               children: [
                        //                 Container(
                        //                     width: _width * 0.2,
                        //                     child: const Text(
                        //                       'Mobile#',
                        //                       style: TextStyle(
                        //                           fontWeight: FontWeight.bold),
                        //                     )),
                        //                 Container(
                        //                   width: _width * 0.02,
                        //                   child: const Text(
                        //                     ':',
                        //                     style: TextStyle(
                        //                         fontWeight: FontWeight.bold),
                        //                   ),
                        //                 ),
                        //                 InkWell(
                        //                   onTap: () {
                        //                     _showPhoneDialog(model
                        //                         .installarMobile
                        //                         .toString());
                        //                   },
                        //                   child: Container(
                        //                       // width: _width * 0.25,
                        //                       child: Text(
                        //                     model.installarMobile
                        //                                 .toString()
                        //                                 .trim() ==
                        //                             'null'
                        //                         ? ''
                        //                         : model.installarMobile
                        //                             .toString()
                        //                             .trim(),
                        //                     style: TextStyle(
                        //                       decoration:
                        //                           TextDecoration.underline,
                        //                       decorationColor:
                        //                           ColorsUtils.appcolor,
                        //                       decorationThickness: 2,
                        //                       fontSize: 16,
                        //                       color: ColorsUtils.appcolor,
                        //                     ),
                        //                   )),
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //           Container(
                        //             child: Row(
                        //               children: [
                        //                 Container(
                        //                     width: _width * 0.2,
                        //                     child: const Text(
                        //                       'item',
                        //                       style: TextStyle(
                        //                           fontWeight: FontWeight.bold),
                        //                     )),
                        //                 Container(
                        //                   width: _width * 0.02,
                        //                   child: const Text(
                        //                     ':',
                        //                     style: TextStyle(
                        //                         fontWeight: FontWeight.bold),
                        //                   ),
                        //                 ),
                        //                 Container(
                        //                     // width: _width * 0.25,
                        //                     child: Flexible(
                        //                   child: Text(model.item
                        //                               .toString()
                        //                               .trim() ==
                        //                           'null'
                        //                       ? ''
                        //                       : model.item.toString().trim()),
                        //                 ))
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       )),
                        // ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PendingCustomerDetail(
                                            pendingInstallationStatus: model))).then((value)=> get_PendingInstallations());
                          },
                          child: const ListTile(
                            leading: Icon(Icons.info),
                            title: Text("Complain Detail"),
                            // subtitle: Text("Customer CMP: ${model.cmp}"),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PendingVisitScreen(pendingInstallationList: model,))).then((value)=> get_PendingInstallations());
                          },
                          child: const ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text("Technician Visit"),
                            // subtitle: Text("Visit Date: ${model.date}"),
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

  Future get_PendingInstallations() async {
    var response = await http.get(Uri.parse(PendingInstallations));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      pendingInstallationList.clear();
      for (Map i in result) {
        pendingInstallationList.add(UserPendingInstallationsModel.fromJson(i));
      }
      setState(() {
        // Update loading state once data is fetched
        searchPendingInstallationList = List.from(pendingInstallationList);
      });
    } else {
      setState(() {
        loading = false; // Update loading state in case of an error
      });
    }
  }

  void search(String query) {
    setState(() {
      searchPendingInstallationList = pendingInstallationList.where((category) {
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
