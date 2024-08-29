import 'dart:ui';
import 'package:flutter/material.dart';

class CircularIndicator {
  static void showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissing by tapping outside
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => true, // Allows back button to close the dialog
          child: Stack(
            children: [
              // The blurred background
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
              // The Circular Progress Indicator
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        );
      },
    );
  }

  static void hideLoader(BuildContext context) {
    Navigator.of(context).pop(); // Closes the dialog
  }
}
