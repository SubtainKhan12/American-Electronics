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
import '../SharedPreferences/sharedPreferences.dart';
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

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText; // Toggle the obscuring state
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
              padding: const EdgeInsets.only(top: 50.0, left: 60),
              child: Image.asset('assets/AELogo.png',
                  height: _height * 0.2, width: _width * 0.7),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 55.0, left: 95),
              child: Image.asset(
                'assets/blueStar.png',
                height: _height * 0.05,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 170.0, left: 55),
              child: Image.asset(
                'assets/blackStar.png',
                height: _height * 0.05,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 160.0, left: 290),
              child: Image.asset(
                'assets/redStar.png',
                height: _height * 0.04,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     top: 328,
            //   ),
            //   child: Image.asset(
            //     'assets/Ellipse.png',
            //     width: _width * 1,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 250.0, left: 30),
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
                    const SizedBox(
                      height: 12,
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
                      padding: const EdgeInsets.only(left: 200.0),
                      child: TextButton(
                          onPressed: () {}, child: Text('Register')),
                    ),
                    SizedBox(height: 10,),
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
            Padding(
              padding: EdgeInsets.only(top: 610, left: 25, right: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomersUI()));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 10,
                          shadowColor: Color(0xffC4E4FF),
                          child: Container(
                            height: _height * 0.06,
                            width: _width * 0.4,
                            decoration: BoxDecoration(
                              color: Color(0xffC4E4FF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: _width * 0.03,
                                ),
                                Image.asset(
                                  'assets/install.png',
                                  color: Colors.blueAccent,
                                  height: 30,
                                ),
                                VerticalDivider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                // SizedBox(width: 20,),
                                Text(
                                  'AC Installation',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> ExpenseUI()));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 10,
                          shadowColor: Color(0xffC4E4FF),
                          child: Container(
                            height: _height * 0.06,
                            width: _width * 0.4,
                            decoration: BoxDecoration(
                              color: Color(0xffC4E4FF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: _width * 0.03,
                                ),
                                Image.asset(
                                  'assets/clean.png',
                                  color: Colors.blueAccent,
                                  height: 30,
                                ),
                                VerticalDivider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                // SizedBox(width: 20,),
                                Text(
                                  'Ac Service',
                                  style: TextStyle(fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        elevation: 10,
                        shadowColor: Color(0xffC4E4FF),
                        child: Container(
                          height: _height * 0.06,
                          width: _width * 0.4,
                          decoration: BoxDecoration(
                            color: Color(0xffC4E4FF),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: _width * 0.03,
                              ),
                              Image.asset(
                                'assets/complaint.png',
                                color: Colors.red,
                                height: 30,
                              ),
                              VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              // SizedBox(width: 20,),
                              Text(
                                'New Complain',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        elevation: 10,
                        shadowColor: Color(0xffC4E4FF),
                        child: Container(
                          height: _height * 0.06,
                          width: _width * 0.4,
                          decoration: BoxDecoration(
                            color: Color(0xffC4E4FF),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: _width * 0.03,
                              ),
                              Image.asset(
                                'assets/customer-ratings.png',
                                color: Colors.red,
                                height: 30,
                              ),
                              VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              // SizedBox(width: 20,),
                              Text(
                                'Complain Status',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 780.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/CrystalSolutions.png', height: 30,),
                  const SizedBox(
                    width: 5,
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
            )

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

    print('Response: $result');

    if (result['error'] == 200) {
      Navigator.pop(context);
      loginModelList = LoginModel.fromJson(result);

      if (loginModelList?.user?.tusrtyp == 'Installar' &&
          loginModelList?.user?.tusrid == _usernameController.text.trim() &&
          loginModelList?.user?.tusrpwd == _passwordController.text) {
        Shared_pref.saveuser(loginModelList!.user!);
        // var sharedPref = await SharedPreferences.getInstance();
        // sharedPref.setBool(SplashScreenState.KEYLOGIN, true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const DashboardUI()));
        Snackbar.showSnackBar(context, 'Login Successful', Colors.teal);
      }
    } else {
      _usernameController.clear();
      _passwordController.clear();
      Snackbar.showSnackBar(context, 'Wrong Credentials', Colors.red);
      Navigator.pop(context);
    }
  }
}
