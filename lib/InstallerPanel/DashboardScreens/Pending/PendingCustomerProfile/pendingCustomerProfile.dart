import 'package:american_electronics/Models/Pending/PendingModel.dart';
import 'package:flutter/material.dart';
import 'package:american_electronics/Utilities/Colors/colors.dart';
import '../../../../Models/Assigned/AssignedModel.dart';

class PendingCustomerProfileUI extends StatefulWidget {
  final PendingModel pendingModelList;

  PendingCustomerProfileUI({super.key, required this.pendingModelList});

  @override
  State<PendingCustomerProfileUI> createState() => _PendingCustomerProfileUIState();
}

class _PendingCustomerProfileUIState extends State<PendingCustomerProfileUI> {
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
                      _buildInfoText('Customer', widget.pendingModelList.customer.toString()),
                      _buildInfoText('Mobile', widget.pendingModelList.mobile.toString()),
                      _buildInfoText('Address',
                          '${widget.pendingModelList.address1}\n${widget.pendingModelList.address2}'),
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
                  child: _buildInfoText('City', widget.pendingModelList.city.toString()),
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
        _buildTableRow('Item', widget.pendingModelList.item.toString()),
        _buildTableRow('Serial #', widget.pendingModelList.serial.toString()),
        _buildTableRow('Quantity', widget.pendingModelList.qnty.toString()),
        _buildTableRow('Amount', '${widget.pendingModelList.amount}'),
        _buildTableRow('Status', widget.pendingModelList.status.toString()),
        _buildTableRow('Date', widget.pendingModelList.date.toString()),
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
