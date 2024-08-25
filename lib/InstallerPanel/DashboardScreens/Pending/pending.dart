import 'dart:convert';
import 'package:american_electronics/InstallerPanel/DashboardScreens/Pending/PendingCustomerProfile/pendingCustomerProfile.dart';
import 'package:american_electronics/InstallerPanel/DashboardScreens/Pending/PendingVisitScreen/pendingVisitScreen.dart';
import 'package:american_electronics/Models/Pending/PendingModel.dart';
import 'package:american_electronics/Utilities/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../APIs/apis.dart';

class PendingUI extends StatefulWidget {
  const PendingUI({super.key});

  @override
  State<PendingUI> createState() => _PendingUIState();
}

class _PendingUIState extends State<PendingUI> {
  List<PendingModel> pendingList = [];
  List<PendingModel> searchPendingList = [];
  String? colCode;
  bool loading = true; // State variable to control the loading state

  @override
  void initState() {
    super.initState();
    getLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pending Applications',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: Padding(
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
              child: loading// Show loader if loading is true
                  ? Center(child: CircularProgressIndicator())
                  : searchPendingList
                          .isEmpty // Show message if no data is available
                      ? Center(child: Text("No applications are pending",style: TextStyle(fontSize: 16,fontWeight:
              FontWeight.bold,color: Colors.grey),))
                      : ListView.builder(
                          itemCount: searchPendingList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) =>
                                      _buildBottomSheet(
                                          context, searchPendingList[index]),
                                );
                              },
                              child: Card(
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
                                            searchPendingList[index]
                                                .cmp
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const Text(
                                            '  -  ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            searchPendingList[index]
                                                .date
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        searchPendingList[index]
                                            .customer
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        searchPendingList[index]
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
    );
  }

  Widget _buildBottomSheet(BuildContext context, PendingModel model) {
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
                        Text(
                          model.mobile.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
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
                                        PendingCustomerDetail(
                                            pendingModel: model)));
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
                                                PendingVisitScreen(pendingModel: model,)));
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

  Future Post_Pending() async {

    var response = await http.post(Uri.parse(Pending), body: {
      'FIntCod': colCode.toString(),
    });
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      pendingList.clear();
      for (Map i in result) {
        pendingList.add(PendingModel.fromJson(i));

      }
      setState(() {
         // Update loading state once data is fetched
        searchPendingList = List.from(pendingList);
      });
    } else {
      setState(() {
        loading = false; // Update loading state in case of an error
      });
    }
  }

  getLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    colCode = sp.getString('colCode');
    setState(() {});
    Post_Pending();
  }

  void search(String query) {
    setState(() {
      searchPendingList = pendingList.where((category) {
        final customerNameMatches =
            category.customer?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        final mobileNumberMatches =
            category.mobile?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        return customerNameMatches || mobileNumberMatches;
      }).toList();
    });
  }
}
