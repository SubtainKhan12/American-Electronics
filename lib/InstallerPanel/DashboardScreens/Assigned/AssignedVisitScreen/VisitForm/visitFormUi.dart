import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../Utilities/Colors/colors.dart';

class VisitFormUI extends StatefulWidget {
  const VisitFormUI({super.key});

  @override
  State<VisitFormUI> createState() => _VisitFormUIState();
}

class _VisitFormUIState extends State<VisitFormUI> {
  DateTime selectedInitialDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Visit Form',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: _width * 0.4,
                height: _height * 0.03,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    labelText: 'Serial No',

                  ),
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 8),
                  const Text('From: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    DateFormat('dd-MM-yyyy').format(selectedInitialDate),
                    style: const TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Icon(Icons.calendar_today, color: Colors.green),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Future<void> _intSelectDate(
      BuildContext context, StateSetter setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      helpText: 'From Date',
      initialDate: selectedInitialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedInitialDate) {
      setState(() {
        selectedInitialDate = picked;
      });
    }
  }
}
