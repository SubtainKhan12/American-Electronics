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
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Image.asset(
                'assets/loginBackgroundImage.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                color: Colors.black
                    .withOpacity(0.3), // Blackish color overlay with opacity
              ),
            ),
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
            Padding(
              padding: const EdgeInsets.only(
                top: 328,
              ),
              child: Image.asset(
                'assets/Ellipse.png',
                width: _width * 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 390.0,
              ),
              child: Container(
                height: _height * 0.5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          hintText: 'UserName',
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white54, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: _toggleObscureText,
                            icon: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          hintText: 'Password',
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white54, width: 2),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: _width * 0.3,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: const BorderSide(
                                            color: Colors.white70, width: 2)),
                                    backgroundColor: ColorsUtils.appcolor,
                                  ),
                                  onPressed: () {
                                    post_login();
                                    CircularIndicator.showLoader(context);
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white70),
                                  )),
                            ),
                            Container(
                              width: _width * 0.3,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: const BorderSide(
                                            color: Colors.white70, width: 2)),
                                    backgroundColor: ColorsUtils.appcolor,
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(color: Colors.white70),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Want to install AC?',
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            )),
                      )
                    ],
                  ),
                ),
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
