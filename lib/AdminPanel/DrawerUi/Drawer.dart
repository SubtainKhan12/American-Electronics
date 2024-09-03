import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminDrawerUI extends StatefulWidget {
  const AdminDrawerUI({super.key});

  @override
  State<AdminDrawerUI> createState() => _AdminDrawerUIState();
}

class _AdminDrawerUIState extends State<AdminDrawerUI> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admin Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'admin@example.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Image.asset('assets/install.png',height: 20,),
              title: Text('Ac Installation'),
              onTap: () {
                // Handle the Dashboard tap
              },
            ),
            ListTile(
              leading: Image.asset('assets/location-pin.png',height: 20,),

              title: Text('City'),
              onTap: () {
                // Handle the Users tap
              },
            ),
            ListTile(
              leading: Image.asset('assets/complaint.png',height: 20,),
              title: Text('Item'),
              onTap: () {
                // Handle the Settings tap
              },
            ),

          ],
        ),
    );
  }
}

