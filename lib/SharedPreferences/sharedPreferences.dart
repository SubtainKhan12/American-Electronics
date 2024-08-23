import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/LoginModel/LoginModel.dart';

class Shared_pref with ChangeNotifier{

  static Future saveuser(User user)async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("id", user.id??"");
    sp.setString('userId', user.tusrid??'');
    sp.setString('cashCode', user.tcashcod??'');
    sp.setString('strCode', user.tstrcod??'');
    sp.setString('empCode', user.tempcod??'');
    sp.setString('userName', user.tusrnam??'');
    sp.setString('userType', user.tusrtyp??'');
    sp.setString('mobNum', user.tmobnum??'');
    sp.setString('emailAdd', user.temladd??'');
    sp.setString('colCode', user.tcolcod??'');
  }

}