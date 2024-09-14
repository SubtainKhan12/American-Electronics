import 'package:american_electronics/Utilities/Colors/colors.dart';
import 'package:flutter/material.dart';

import '../../../Models/InstallarComperison/InstallarComparisonModel.dart';

class InstallarComperisonUI extends StatefulWidget {
  List<InstallarComparisonModel> installarComparison = [];

  InstallarComperisonUI({super.key, required this.installarComparison});

  @override
  State<InstallarComperisonUI> createState() => _InstallarComperisonUIState();
}

class _InstallarComperisonUIState extends State<InstallarComperisonUI> {
  List<InstallarComparisonModel> filterInstallarComparison = [];
  double tableFontSize = 14;

  @override
  void initState() {
    super.initState();
    filterInstallarComparison = widget.installarComparison;
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Installer Comparison',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
        backgroundColor: ColorsUtils.appcolor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(children: [
            TextField(
              onChanged: (value) {
                search(value);
              },
              decoration: InputDecoration(
                  hintText: 'Search Installer Name',
                  labelText: 'Search...',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
            ),
            SizedBox(height: _height * 0.005),
            filterInstallarComparison.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 300.0),
                      child: Text(
                        'No record found',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.grey),
                      ),
                    ),
                  )
                : Table(
                    border: TableBorder(
                      verticalInside: BorderSide(width: 1, color: Colors.grey),
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(0.85),
                      1: FlexColumnWidth(0.15),
                    },
                    children: [
                      TableRow(
                        // Header row
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            border: Border.all(width: 0.5)),
                        children: [
                          TableCell(
                            child: Center(
                              child: Text('Installer Name',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: tableFontSize,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text('No#',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: tableFontSize,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                      for (var i = 0; i < filterInstallarComparison.length; i++)
                        TableRow(
                          // Data row
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.grey)),
                          children: [
                            TableCell(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 3.0, left: 5),
                                child: Text(
                                    filterInstallarComparison[i]
                                        .instalalr
                                        .toString(),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: tableFontSize,
                                    )),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 3.0, right: 5),
                                child: Text(
                                    filterInstallarComparison[i]
                                        .installations
                                        .toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: tableFontSize,
                                    )),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
          ]),
        ),
      ),
    );
  }

  void search(String query) {
    setState(() {
      filterInstallarComparison = widget.installarComparison.where((category) {
        final customerNameMatches =
            category.instalalr?.toLowerCase().contains(query.toLowerCase()) ??
                false;

        return customerNameMatches;
      }).toList();
    });
  }
}
