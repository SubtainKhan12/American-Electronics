import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DrawerScreens/UserManagement/users.dart';

class AdminDrawerUI extends StatefulWidget {
  const AdminDrawerUI({super.key});

  @override
  State<AdminDrawerUI> createState() => _AdminDrawerUIState();
}

class _AdminDrawerUIState extends State<AdminDrawerUI> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Drawer(
      width: _width * 0.68,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 5),
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                // color: Colors.white,
              ),
              child: Image.asset('assets/AELogo.png'),
            ),
            ListTile(
              leading: Image.asset('assets/management.png',height: 20,),
              title: Text('User Management'),
              dense: true,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> UserUI()));
              },
            ),
            ListTile(
              leading: Image.asset('assets/install.png',height: 20,),
              title: Text('Ac Installation'),
              dense: true,
              onTap: () {
                // Handle the Dashboard tap
              },
            ),
            ListTile(
              leading: Image.asset('assets/location-pin.png',height: 20,),
              dense: true,

              title: Text('City'),
              onTap: () {
                // Handle the Users tap
              },
            ),
            ListTile(
              leading: Image.asset('assets/complaint.png',height: 20,),
              title: Text('Item'),
              dense: true,

              onTap: () {
                // Handle the Settings tap
              },
            ),

          ],
        ),
    );
  }
}

