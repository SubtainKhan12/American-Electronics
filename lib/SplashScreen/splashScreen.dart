import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../InstallerPanel/DashboardScreens/Dashboard/dashboard.dart';
import '../LoginPages/loginscreen.dart';
import '../UserPanel/UserDashboard/DasboardScreen/userDashboardUi.dart';





class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = 'login';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset(
            "assets/AELogo.png",
            height: 400,
          ),
        ),
      ),
    );
  }

  Future whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(SplashScreenState.KEYLOGIN);
    var userType = sharedPref.getString('userType'); // Retrieve user type

    Timer(Duration(seconds: 2), () {
      if (isLoggedIn != null && isLoggedIn) {
        // Navigate based on user type
        if (userType == 'Installar') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardUI()), // Technician Panel
          );
        } else if (userType == 'User') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserDashboardUI()), // Admin Panel
          );
        }
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginUI())
        );
      }
    });
  }

}