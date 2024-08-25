import 'dart:io';

import 'package:american_electronics/Models/GetComplain/GetComplainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../Utilities/Colors/colors.dart';

class PendingVisitFormUI extends StatefulWidget {
  GetComplainModel getComplainModel;
  PendingVisitFormUI({super.key, required this.getComplainModel});

  @override
  State<PendingVisitFormUI> createState() => _PendingVisitFormUIState();
}

class _PendingVisitFormUIState extends State<PendingVisitFormUI> {
  TextEditingController _serialController = TextEditingController();
  DateTime selectedInitialDate = DateTime.now();
  String? status;
  File? _image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setComplainData();
  }

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
                  controller: _serialController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    labelText: 'Serial No',
                    labelStyle: TextStyle(
                      fontSize:
                          _height * 0.015, // Adjust font size based on height
                    ),
                  ),
                  style: TextStyle(
                    fontSize: _height *
                        0.015, // Adjust text input size based on height
                  ),
                ),
              ),
              InkWell(
                onTap: (){_intSelectDate(context,setState);},
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    const Text('Date: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: InputDecorator(
                decoration: InputDecoration(
                    labelText: 'Complain Information',
                    labelStyle: TextStyle(
                        color: ColorsUtils.appcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    )),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                              width: _width * 0.23,
                              child: const Text(
                                'Complain No',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          Container(
                            width: _width * 0.02,
                            child: const Text(
                              ':',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            // width: _width * 0.25,
                              child: Text(widget.getComplainModel
                                  .comp
                                  .toString()
                                  .trim()))
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: _width * 0.23,
                              child: const Text(
                                'Customer',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          Container(
                            width: _width * 0.02,
                            child: const Text(
                              ':',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            // width: _width * 0.25,
                              child: Flexible(
                                child: Text(widget.getComplainModel
                                    .customer
                                    .toString()
                                    .trim()),
                              ))
                        ],
                      ),
                    ),

                  ],
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 0.3,
            height: MediaQuery.of(context).size.height / 16,
            child: DropdownButtonFormField<String>(
              value: status,
              onChanged: (newValue) {
                setState(() {
                  status = newValue;
                });
              },
              items: <String>[
                'Pending',
                'Installed',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: "Type",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            // width: MediaQuery.of(context).size.width / 0.3,
            // height: MediaQuery.of(context).size.height / 16,
            child: TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Remarks",
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                // floatingLabelBehavior: FloatingLabelBehavior.always, // Keeps label at the top
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: _height * 0.15,
                width: _width * 0.4,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8)),
                child: _image == null
                    ? const Center(child: Icon(Icons.image_outlined,size: 50,))
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                    ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: _takePicture,
                child: Container(
                  height: _height * 0.15,
                  width: _width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: _height / 16,
            width: _width / 0.3, // Set the height
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
              onPressed: () {},
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 25),
              ),
            ),
          )
        ]),
      ),
    );
  }
  setComplainData(){
    _serialController.text = widget.getComplainModel.serialNo.toString().trim() ?? '0';
  }

  void _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
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
