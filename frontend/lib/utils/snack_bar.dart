import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


///Snack bar to show Toast messages
class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackbar(String? text) {
    return Fluttertoast.showToast(
      msg: text!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
