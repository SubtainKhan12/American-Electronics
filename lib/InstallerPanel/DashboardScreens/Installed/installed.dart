import 'dart:convert';
import 'package:american_electronics/InstallerPanel/DashboardScreens/Installed/InstalledCustomerProfiles/installedCustomerProfile.dart';
import 'package:american_electronics/InstallerPanel/DashboardScreens/Installed/InstalledVisitScreen/VisitForm/installedVisitFormUi.dart';
import 'package:american_electronics/Models/Installed/InstalledModel.dart';
import 'package:american_electronics/Utilities/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../APIs/apis.dart';
import 'InstalledVisitScreen/installedVisitScreen.dart';

class InstalledUI extends StatefulWidget {
  const InstalledUI({super.key});

  @override
  State<InstalledUI> createState() => _InstalledUIState();
}

class _InstalledUIState extends State<InstalledUI> {
  List<InstalledModel> installedList = [];
  List<InstalledModel> searchInstalledList = [];
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
          'Installed Applications',
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
              child: loading // Show loader if loading is true
                  ? Center(child: CircularProgressIndicator())
                  : searchInstalledList
                  .isEmpty // Show message if no data is available
                  ? Center(child: Text("No Application is Installed",style: TextStyle(fontSize: 16,fontWeight:
              FontWeight.bold,color: Colors.grey),))
                  : ListView.builder(
                  itemCount: searchInstalledList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) =>
                              _buildBottomSheet(
                                  context, searchInstalledList[index]),
                        );

                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    searchInstalledList[index].cmp.toString(),
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
                                    searchInstalledList[index].date.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                searchInstalledList[index].customer.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                searchInstalledList[index].mobile.toString(),
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

  Widget _buildBottomSheet(BuildContext context, InstalledModel model) {
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
                                        InstalledCustomerDetail(
                                            installedModel: model)));
                          },
                          child: const ListTile(
                            leading: Icon(Icons.info),
                            title: Text("Information"),
                            // subtitle: Text("Customer CMP: ${model.cmp}"),
                          ),
                        ),
                        // InkWell(
                        //   onTap: (){
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 InstalledVisitScreen(
                        //                     installedModel: model)));
                        //   },
                        //   child: const ListTile(
                        //     leading: Icon(Icons.location_on),
                        //     title: Text("Visit"),
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


  Future Post_Installed() async {
    var response = await http.post(Uri.parse(Installed), body: {
      'FIntCod': colCode.toString(),
    });
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      installedList.clear();
      for (Map i in result) {
        installedList.add(InstalledModel.fromJson(i));
      }
      setState(() {

        searchInstalledList = List.from(installedList);
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
    Post_Installed();
  }

  void search(String query) {
    setState(() {
      searchInstalledList = installedList.where((category) {
        final customerNameMatches =
            category.customer?.toLowerCase().contains(query.toLowerCase()) ?? false;
        final mobileNumberMatches =
            category.mobile?.toLowerCase().contains(query.toLowerCase()) ?? false;
        final complainNumberMatches =
            category.cmp?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        return customerNameMatches || mobileNumberMatches || complainNumberMatches;
      }).toList();
    });
  }

}

