import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;

import 'package:american_electronics/Models/GetComplain/GetComplainModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../APIs/apis.dart';
import '../../../../../../Utilities/Colors/colors.dart';
import '../../../../../../Utilities/Loader/loader.dart';
import '../../../../../../Utilities/Snackbar/snackbar.dart';

class PendingVisitFormUI extends StatefulWidget {
  GetComplainModel getComplainModel;
  PendingVisitFormUI({super.key, required this.getComplainModel});

  @override
  State<PendingVisitFormUI> createState() => _PendingVisitFormUIState();
}

class _PendingVisitFormUIState extends State<PendingVisitFormUI> {
  TextEditingController _serialController = TextEditingController();
  TextEditingController _itemController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();
  DateTime? _dateTime;
  var cdate = DateFormat("dd-MM-yyyy").format(DateTime.now());

  // DateTime selectedInitialDate = DateTime.now();
  String? status = 'Pending';
  File? _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setComplainData();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery
        .of(context)
        .size
        .height;
    var _width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: ColorsUtils.lightblue,
      appBar: AppBar(
        title: Text(
          'Visit Form',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: _width * 0.4,
                  height: _height * 0.03,
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
                              .trim(), style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,),))
                    ],
                  ),
                ),
                InkWell(
                  // onTap: (){_intSelectDate(context,setState);},
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      const Text('Date: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        cdate.toString(),
                        // DateFormat('dd-MM-yyyy').format(selectedInitialDate),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      // const Icon(Icons.calendar_today, color: Colors.green),
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
                      labelText: 'Customer Information',
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
                      Container(
                        child: Row(
                          children: [
                            Container(
                                width: _width * 0.23,
                                child: const Text(
                                  'Address',
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
                                      .address1
                                      .toString()
                                      .trim()),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                                width: _width * 0.23,
                                child: const Text(
                                  '',
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
                                      .address2
                                      .toString()
                                      .trim()),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                                width: _width * 0.23,
                                child: const Text(
                                  'Mobile No',
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
                                      .mobile
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 0.3,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 16,
              child: TextField(
                readOnly: true,
                controller: _itemController,
                decoration: InputDecoration(
                  labelText: "Item",
                  labelStyle: TextStyle(color: ColorsUtils.appcolor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 0.3,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 16,
              child: TextField(
                controller: _serialController,
                decoration: InputDecoration(
                  labelText: "Serial No",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 0.3,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 16,
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
                  'Cancel',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: "Status",
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
                controller: _remarkController,
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
            InkWell(
              onTap: _showImageSourceDialog,
              child: Container(
                height: _height * 0.15,
                width: _width * 0.4,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8)),
                child: _image == null
                    ? const Center(child: Icon(Icons.image_outlined, size: 50,))
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: _height / 16,
              width: _width / 0.3, // Set the height
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
                onPressed: () {
                  post_SaveVisit();
                  CircularIndicator.showLoader(context);
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void _showImageSourceDialog() {
    var _height = MediaQuery
        .of(context)
        .size
        .height;
    var _width = MediaQuery
        .of(context)
        .size
        .width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                _takePicture(ImageSource.camera);
                Navigator.of(context).pop();
              },
              child: Container(
                height: _height * 0.04,
                child: Image.asset('assets/camera.png'),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                _takePicture(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              child: Container(
                height: _height * 0.04,
                child: Image.asset('assets/gallery.png'),
              ),
            )
          ],
        );
      },
    );
  }

  void _takePicture(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  setComplainData() {
    _itemController.text =
        widget.getComplainModel.item.toString().trim() ?? '0';
  }

  // Future<void> _intSelectDate(
  //     BuildContext context, StateSetter setState) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     helpText: 'From Date',
  //     initialDate: cdate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != cdate) {
  //     setState(() {
  //       cdate = picked;
  //     });
  //   }
  // }
  //006679

  Future post_SaveVisit() async {
    var request = http.MultipartRequest('POST',
        Uri.parse(SaveVisit));
    request.fields['FTrnNum'] = widget.getComplainModel.comp.toString();
    request.fields['FCmpSts'] = status.toString().substring(0,1);
    request.fields['FItmSer'] = _serialController.text;
    request.fields['FVstRem'] = _remarkController.text;
    request.fields['FVstDat'] = cdate.toString();

    if (_image != null) {
      var picture = await http.MultipartFile.fromPath('VstImg', _image!.path);
      request.files.add(picture);
    }
    final response = await http.Response.fromStream(await request.send());
    var result = jsonDecode(response.body.toString());
    if (result["error"] == 200) {
      print(result["message"]);
      Snackbar.showSnackBar(context, result['message'], Colors.teal);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      Snackbar.showSnackBar(context, result['message'], Colors.teal);
      Navigator.pop(context);
    }
  }
}
