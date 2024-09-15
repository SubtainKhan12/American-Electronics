import 'dart:convert';
import 'package:american_electronics/InstallerPanel/DashboardScreens/Assigned/AssignedVisitScreen/assignedVisitScreen.dart';
import 'package:american_electronics/Utilities/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../APIs/apis.dart';
import '../../../Models/Assigned/AssignedModel.dart';
import 'AssignedCustomerProfile/customerProfile.dart';

class AssignedUI extends StatefulWidget {
  const AssignedUI({super.key});

  @override
  State<AssignedUI> createState() => _AssignedUIState();
}

class _AssignedUIState extends State<AssignedUI> {
  List<AssignedModel> assignedList = [];
  List<AssignedModel> searchAssignedList = [];
  String? colCode;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assigned Applications',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: RefreshIndicator(
          onRefresh: Post_Assigned,
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
                    : searchAssignedList.isEmpty
                        ? const Center(
                            child: Text(
                            "No applications is Assigned",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ))
                        : ListView.builder(
                            itemCount: searchAssignedList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => _buildBottomSheet(
                                        context, searchAssignedList[index]),
                                  );
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5),
                                    child: Row(
                                      children: [
                                        // CircleAvatar(
                                        //   backgroundColor:
                                        //       searchAssignedList[index]
                                        //                   .status
                                        //                   .toString() ==
                                        //               'Pending'
                                        //           ? Colors.red
                                        //           : Colors.green,
                                        //   child: Text(
                                        //     '1',
                                        //     style: TextStyle(
                                        //         color: searchAssignedList[index]
                                        //                     .status
                                        //                     .toString() ==
                                        //                 'Pending'
                                        //             ? Colors.greenAccent
                                        //             : Colors.white),
                                        //   ),
                                        // ),
                                        // const SizedBox(
                                        //   width: 10,
                                        // ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  searchAssignedList[index]
                                                      .cmp
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xffF58634),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Text(
                                                  '  -  ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  searchAssignedList[index]
                                                      .date
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              searchAssignedList[index]
                                                  .customer
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  searchAssignedList[index]
                                                      .mobile
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '(${searchAssignedList[index].status.toString()})',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        searchAssignedList[index]
                                                                    .status
                                                                    .toString() ==
                                                                'Installed'
                                                            ? Colors.green
                                                            : Colors.red,
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

  Widget _buildBottomSheet(BuildContext context, AssignedModel model) {
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
                        Center(
                          child: Text(
                            model.customer.toString().trim(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
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
                                        AssignedCustomerDetail(
                                          assignedModel: model,
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
                        //                 AssignedVisitScreen(assignedModel: model,)));
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

  Future Post_Assigned() async {
    var response = await http.post(Uri.parse(Assigned), body: {
      'FIntCod': colCode.toString(),
    });
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      assignedList.clear();
      for (Map i in result) {
        assignedList.add(AssignedModel.fromJson(i));
      }
      setState(() {
        searchAssignedList = List.from(assignedList);
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  getLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    colCode = sp.getString('colCode');
    print(colCode);
    setState(() {});
    Post_Assigned();
  }

  void search(String query) {
    setState(() {
      searchAssignedList = assignedList.where((category) {
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
