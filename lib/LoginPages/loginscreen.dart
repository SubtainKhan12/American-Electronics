import 'dart:convert';

import 'package:american_electronics/InstallerPanel/DashboardScreens/Dashboard/dashboard.dart';
import 'package:american_electronics/Models/LoginModel/LoginModel.dart';
import 'package:american_electronics/Utilities/Colors/colors.dart';
import 'package:american_electronics/Utilities/Loader/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../APIs/apis.dart';
import '../CustomerPanel/newInstallations.dart';
import '../SharedPreferences/sharedPreferences.dart';
import '../SplashScreen/splashScreen.dart';
import '../UserPanel/CompalinSheet/complainSheet.dart';
import '../UserPanel/UserDashboard/DasboardScreen/userDashboardUi.dart';
import '../Utilities/Snackbar/snackbar.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  LoginModel? loginModelList;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  static String KEYNAME = "userId";

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(

          children: [
            // Container(
            //   height: double.maxFinite,
            //   width: double.maxFinite,
            //   child: Image.asset(
            //     'assets/img.png',
            //     fit: BoxFit.fill,
            //   ),
            // ),
            // Positioned.fill(
            //   child: Container(
            //     color: Colors.black
            //         .withOpacity(0.3), // Blackish color overlay with opacity
            //   ),
            // ),
            Padding(
              padding:  EdgeInsets.only(top: _height * 0.055, left: _width * 0.15),
              child: Image.asset('assets/AELogo.png',
                  height: _height * 0.2, width: _width * 0.7),
            ),
            Padding(
              padding:  EdgeInsets.only(top: _height * 0.065, left: _width * 0.25),
              child: Image.asset(
                'assets/blueStar.png',
                height: _height * 0.05,
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: _height * 0.195, left: _width * 0.14),
              child: Image.asset(
                'assets/blackStar.png',
                height: _height * 0.05,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _height * 0.18, left: _width * 0.75),
              child: Image.asset(
                'assets/redStar.png',
                height: _height * 0.04,
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: _height * 0.29, left: _width * 0.075),
              child: Container(
                width: _width * 0.85,
                height: _height * 0.4,
                decoration: const BoxDecoration(
                  color: Color(0xffC4E4FF),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: _width * 0.67,
                      height: _height * 0.07,
                      child: TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                            suffix: Icon(
                              Icons.email_outlined,
                              // color: Colors.red,
                            ),
                            labelText: "Id/Mobile no",
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                            )),
                      ),
                    ),
                     SizedBox(
                      height: _height * 0.01,
                    ),
                    Container(
                      width: _width * 0.67,
                      height: _height * 0.07,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            suffix: IconButton(
                              onPressed: _toggleObscureText,
                              icon: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            labelText: "Password",
                            border: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                            )),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: _width *0.52),
                      child: TextButton(
                          onPressed: () {}, child: Text('Register')),
                    ),
                    SizedBox(height: _height * 0.01,),
                    InkWell(
                      onTap: () {
                        post_login();
                        CircularIndicator.showLoader(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: _width * 0.68,
                        decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                            color: ColorsUtils.appcolor),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),

                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: 610, left: 25, right: 25),
            //   child: Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: [
            //           InkWell(
            //             onTap: () {
            //               Navigator.push(context, MaterialPageRoute(builder: (context)=>ACInstallationUI()));
            //             },
            //             child: Material(
            //               borderRadius: BorderRadius.circular(20),
            //               elevation: 10,
            //               shadowColor: Color(0xffC4E4FF),
            //               child: Container(
            //                 height: _height * 0.06,
            //                 width: _width * 0.4,
            //                 decoration: BoxDecoration(
            //                   color: Color(0xffC4E4FF),
            //                   borderRadius: BorderRadius.circular(5),
            //                 ),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     SizedBox(
            //                       width: _width * 0.03,
            //                     ),
            //                     Image.asset(
            //                       'assets/install.png',
            //                       color: Colors.blueAccent,
            //                       height: 30,
            //                     ),
            //                     VerticalDivider(
            //                       color: Colors.black,
            //                       thickness: 1,
            //                     ),
            //                     // SizedBox(width: 20,),
            //                     Text(
            //                       'AC Installation',
            //                       style: TextStyle(
            //                           fontWeight: FontWeight.w500,
            //                           fontSize: 12),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //           Material(
            //             borderRadius: BorderRadius.circular(5),
            //             elevation: 10,
            //             shadowColor: Color(0xffC4E4FF),
            //             child: InkWell(
            //               onTap: (){
            //                 Navigator.push(context, MaterialPageRoute(builder: (context)=> CompalinSheetUI()));
            //               },
            //               child: Container(
            //                 height: _height * 0.06,
            //                 width: _width * 0.4,
            //                 decoration: BoxDecoration(
            //                   color: Color(0xffC4E4FF),
            //                   borderRadius: BorderRadius.circular(5),
            //                 ),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     SizedBox(
            //                       width: _width * 0.03,
            //                     ),
            //                     Image.asset(
            //                       'assets/complaint.png',
            //                       color: Colors.red,
            //                       height: 30,
            //                     ),
            //                     VerticalDivider(
            //                       color: Colors.black,
            //                       thickness: 1,
            //                     ),
            //                     // SizedBox(width: 20,),
            //                     Text(
            //                       'New Complain',
            //                       style: TextStyle(
            //                           fontWeight: FontWeight.w500, fontSize: 12),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(top: _height * 0.72),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Column(
                  children: [
                    Container(
                      height: _height * 0.09,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ACInstallationUI()));
                        }, child: Image.asset(
                        'assets/install.png',
                        color: Colors.blue,
                        height: 30,
                      ),),
                    ),
                    Text('Ac Installation')
                  ],
                ),
                SizedBox(width: _width * 0.05,),
                Column(
                  children: [
                    Container(
                      height: _height * 0.09,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                        onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> CompalinSheetUI()));
                        }, child: Image.asset(
                        'assets/complaint.png',
                        color: Colors.red,
                        height: 30,
                      ),),
                    ),
                    Text('New Complain'),
                  ],
                ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _height* 0.91),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/CrystalSolutions.png', height: _height * 0.05,),
                   SizedBox(
                    width: _width * 0.01,
                  ),
                  Column(
                    children: [
                      RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Powered by ",
                                    style: TextStyle(
                                        color: ColorsUtils.blackColor)),
                                TextSpan(
                                    text: "Crystal ",
                                    style: TextStyle(
                                        color: ColorsUtils.blueCrystal,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: "Solutions",
                                    style: TextStyle(
                                        color: ColorsUtils.orangeCrystal,
                                        fontWeight: FontWeight.bold)),
                              ])),
                      RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Contact us: ",
                                style: TextStyle(
                                    color: ColorsUtils.blackColor)),
                            TextSpan(
                                text: "+92 304 4770075",
                                style: TextStyle(
                                    color: ColorsUtils.blueCrystal,
                                    fontWeight: FontWeight.bold)),
                          ])),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> post_login() async {
    FocusScope.of(context).unfocus();
    var response = await http.post(Uri.parse(login), body: {
      'userid': _usernameController.text,
      'password': _passwordController.text,
    });

    var result = jsonDecode(response.body);

    if (result['error'] == 200) {
      loginModelList = LoginModel.fromJson(result);

      if (loginModelList?.user?.tusrid == _usernameController.text.trim() &&
          loginModelList?.user?.tusrpwd == _passwordController.text.trim()) {

        Shared_pref.saveuser(loginModelList!.user!);

        if (loginModelList?.user?.tusrtyp == 'Installar') {
          var sharedPref = await SharedPreferences.getInstance();
          sharedPref.setBool(SplashScreenState.KEYLOGIN, true);
          sharedPref.setString('userType', 'Installar');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const DashboardUI()),
                (Route<dynamic> route) => false,
          );
          Snackbar.showSnackBar(context, 'Login Successful', Colors.teal);
        } else if (loginModelList?.user?.tusrtyp == 'User') {
          var sharedPref = await SharedPreferences.getInstance();
          sharedPref.setBool(SplashScreenState.KEYLOGIN, true);
          sharedPref.setString('userType', 'User');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const UserDashboardUI()),
                (Route<dynamic> route) => false,
          );
          Snackbar.showSnackBar(context, 'Login Successful', Colors.teal);
        }
      } else {
        _usernameController.clear();
        _passwordController.clear();
        Snackbar.showSnackBar(context, 'Wrong Credentials', Colors.red);
        Navigator.pop(context);
      }
    } else {
      Snackbar.showSnackBar(context, 'Login Failed', Colors.red);
      Navigator.pop(context);
    }
  }

}
