import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class MyAlert {
  static toast(BuildContext? context, String msg) {
    GFToast.showToast(
      msg, context!,
      toastPosition: GFToastPosition.BOTTOM,
      textStyle: TextStyle(fontSize: 18, color: GFColors.WHITE),
      backgroundColor: GFColors.DARK,
      toastDuration: 3,
      toastBorderRadius: 20,

      // trailing: const Icon(
      //   Icons.close,
      //   color: GFColors.SUCCESS,
      // )
    );
  }

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

  // new custom toast //

  static showToast(msg) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(msg),
        ],
      ),
    );

    FToast().showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
