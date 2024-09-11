import 'dart:convert';

import 'package:american_electronics/Utilities/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class CompalinSheetUI extends StatefulWidget {
  const CompalinSheetUI({super.key});

  @override
  State<CompalinSheetUI> createState() => _CompalinSheetUIState();
}

class _CompalinSheetUIState extends State<CompalinSheetUI> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _mobileNoController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _Address1Controller = TextEditingController();
  TextEditingController _address2Controller = TextEditingController();
  TextEditingController _serialNoController = TextEditingController();
  TextEditingController _complainController = TextEditingController();
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Complain',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
        backgroundColor: ColorsUtils.appcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: _width * 0.35,
                height: _height * 0.04,
                child: TextField(
                  controller: _dateController,
                  style: TextStyle(
                    fontSize: _height * 0.02,
                    color: Colors.grey.shade600,
                  ),
                  decoration: InputDecoration(
                    labelText: "Date",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: _width * 0.02,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.005,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Mobile #",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.005,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.005,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Address 1",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.005,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Address 2",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.005,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Serial #",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.005,
              ),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Item/Complain",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.01,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.maxFinite, _height * 0.055),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    newComplain();
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: _height * 0.03),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  setData() {
    _dateController.text = DateFormat('dd-MM-yyyy').format(dateTime);
  }

  Future newComplain() async {
    var response = await http.post(Uri.parse(''), body: {});
    var result = jsonDecode(response.body);
    if (result['error'] == 200) {
      SnackBar(content: result['message']);
    } else {
      SnackBar(content: result['message']);
    }
  }
}
