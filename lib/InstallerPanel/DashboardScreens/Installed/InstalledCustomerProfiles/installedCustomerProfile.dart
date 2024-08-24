import 'package:american_electronics/Models/Installed/InstalledModel.dart';
import 'package:flutter/material.dart';
import 'package:american_electronics/Utilities/Colors/colors.dart';
import '../../../../Models/Assigned/AssignedModel.dart';

class InstalledCustomerProfileUI extends StatefulWidget {
  final InstalledModel installedModelList;

  InstalledCustomerProfileUI({super.key, required this.installedModelList});

  @override
  State<InstalledCustomerProfileUI> createState() => _InstalledCustomerProfileUIState();
}

class _InstalledCustomerProfileUIState extends State<InstalledCustomerProfileUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer Profile',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Customer details
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoText('Customer', widget.installedModelList.customer.toString()),
                      _buildInfoText('Mobile', widget.installedModelList.mobile.toString()),
                      _buildInfoText('Address',
                          '${widget.installedModelList.address1}\n${widget.installedModelList.address2}'),
                    ],
                  ),
                ),

                // Divider
                Container(
                  height: 100, // Adjust height based on content
                  width: 1.0,
                  color: ColorsUtils.redColor,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                ),

                // City
                Expanded(
                  flex: 1,
                  child: _buildInfoText('City', widget.installedModelList.city.toString()),
                ),
              ],
            ),

            SizedBox(height: 10.0), // Add some spacing before the table

            // Table Section
            _buildTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title: ',
              style: TextStyle(
                color: ColorsUtils.appcolor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            TextSpan(
              text: content.trim(),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      children: [
        _buildTableRow('Item', widget.installedModelList.item.toString()),
        _buildTableRow('Serial #', widget.installedModelList.serial.toString()),
        _buildTableRow('Quantity', widget.installedModelList.qnty.toString()),
        _buildTableRow('Amount', '${widget.installedModelList.amount}'),
        _buildTableRow('Status', widget.installedModelList.status.toString()),
        _buildTableRow('Date', widget.installedModelList.date.toString()),
      ],
    );
  }

  TableRow _buildTableRow(String title, String content) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              color: ColorsUtils.appcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(content.trim()),
        ),
      ],
    );
  }
}
