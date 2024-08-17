import 'package:flutter/material.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
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
                      const TextField(
                        decoration: InputDecoration(
                          hintText: 'UserName',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
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
                            borderSide: BorderSide(color: Colors.white54, width: 2),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2),
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
                                    backgroundColor: const Color(0xff1010),
                                  ),
                                  onPressed: () {},
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
                                    backgroundColor: const Color(0xff1010),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Want to install AC?',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Register',
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
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
}
