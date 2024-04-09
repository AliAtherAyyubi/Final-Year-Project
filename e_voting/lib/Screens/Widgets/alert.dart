import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class MyAlert {
  // String title;
  // String message;

  // MyAlert({this.Al});
  // static Alert(BuildContext? context, String title, String msg) {
  //   GFToast.showToast(msg, context!,
  //       toastPosition: GFToastPosition.BOTTOM,
  //       textStyle: TextStyle(fontSize: 16, color: GFColors.WHITE),
  //       backgroundColor: GFColors.DARK,
  //       trailing: const Icon(
  //         Icons.notifications,
  //         color: GFColors.SUCCESS,
  //       ));
  // }
  static Alert(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      backgroundColor: Colors.black,
      // colorText: Color.fromARGB(0, 27, 27, 27),
      duration: const Duration(seconds: 3),
      isDismissible: false,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Color.fromARGB(255, 251, 251, 251),
      snackStyle: SnackStyle.FLOATING,
    );
  }
}
