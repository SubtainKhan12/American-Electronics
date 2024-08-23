import 'package:american_electronics/Utilities/Colors/colors.dart';
import 'package:flutter/material.dart';

class CustomerProfileUI extends StatefulWidget {
  const CustomerProfileUI({super.key});

  @override
  State<CustomerProfileUI> createState() => _CustomerProfileUIState();
}

class _CustomerProfileUIState extends State<CustomerProfileUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Profile',style: TextStyle(color: ColorsUtils.whiteColor),),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
    );
  }
}
