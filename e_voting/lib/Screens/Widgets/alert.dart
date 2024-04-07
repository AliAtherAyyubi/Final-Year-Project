import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAlert {
  // String title;
  // String message;

  // MyAlert({this.Al});

  static Alert(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      // backgroundColor: AppStyle.lightskyColor,
      // colorText: Color.fromARGB(0, 27, 27, 27),
      duration: Duration(seconds: 2),
      isDismissible: true,
      snackPosition: SnackPosition.TOP,
    );
  }

  void display() {
    print('object');
  }
}
