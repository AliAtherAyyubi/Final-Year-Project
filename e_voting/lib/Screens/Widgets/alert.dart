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
    Get.snackbar(title, msg,
        backgroundColor: Colors.black,
        // colorText: Color.fromARGB(0, 27, 27, 27),
        duration: const Duration(seconds: 3),
        isDismissible: true,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Color.fromARGB(255, 251, 251, 251),
        snackStyle: SnackStyle.GROUNDED,
        margin: EdgeInsets.all(0),
        onTap: (snack) => snack.isDismissible,
        borderRadius: 0);
  }

  // new custom toast //

  static showToast(type, msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor:
            type == 1 ? Colors.green : const Color.fromARGB(255, 249, 146, 139),
        textColor: Colors.white,
        fontSize: 18);
  }
}
