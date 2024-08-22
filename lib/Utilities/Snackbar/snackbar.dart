
import 'package:flutter/material.dart';

class Snackbar {
  static showSnackBar(BuildContext context, String msg, var BGColor) {
    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: (BGColor),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Dismiss',
        disabledTextColor: Colors.white,
        textColor: Colors.yellow,
        onPressed: () {
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}