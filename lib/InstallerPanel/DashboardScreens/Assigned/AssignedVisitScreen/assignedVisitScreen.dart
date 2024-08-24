import 'package:flutter/material.dart';

import '../../../../Utilities/Colors/colors.dart';
import 'VisitForm/visitFormUi.dart';

class AssignedVisitScreen extends StatefulWidget {
  const AssignedVisitScreen({super.key});

  @override
  State<AssignedVisitScreen> createState() => _AssignedVisitScreenState();
}

class _AssignedVisitScreenState extends State<AssignedVisitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Visit',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>VisitFormUI()));
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index){
              return Card(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date: 01-08-2024',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                        Text('asdfghjdfghjk', style: TextStyle(fontSize: 12),),
                      ],
                    ),
                  ),

                ),
              );
            }),
      ),
    );
  }
}
