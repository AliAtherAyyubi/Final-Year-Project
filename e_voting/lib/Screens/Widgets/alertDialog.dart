import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Widgets/loading.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyAlertDialogWidget extends StatelessWidget {
  final String? title;
  final Widget? content;
  final String? confirmBtnText;
  final String? cancelBtnText;
  bool loading;
  // final String? cancelButtonText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  MyAlertDialogWidget({
    Key? key,
    required this.title,
    this.content,
    this.onConfirm,
    this.loading = false,
    this.confirmBtnText,
    this.cancelBtnText,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title!,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: content,
      actions: [
        MyTextButton(
          onPress: onCancel ??
              () {
                Navigator.pop(context);
              },
          text: cancelBtnText ?? 'Cancel',
          elevation: 0,
          textClr: Colors.grey.shade700,
          fontWeight: FontWeight.w500,
        ),
        MyButton(
          onPress: onConfirm,
          text: confirmBtnText ?? "Add",
          elevation: 0,
          height: 45,
          fontWeight: FontWeight.w400,
          width: 35.w,
          loading: loading,
        ),
      ],
    );
  }
}

class DialogMsg {
  void showMsg(BuildContext context, msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            msg,
            style: AppStyle().h3.copyWith(color: Colors.black),
          ),
          actions: [
            MyButton(
              onPress: () {
                Navigator.pop(context);
              },
              text: 'OK',
              fontWeight: FontWeight.w400,
              width: 30.w,
              height: 45,
              elevation: 0,
            )
          ],
        );
      },
    );
  }
//

  void faceAlertMsg(BuildContext context, String msg) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0), // Rounded corners for the dialog
            ),
            contentPadding: EdgeInsets.all(16.0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success icon in the center
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60,
                ),
                SizedBox(height: 16.0),
                // Message
                Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24.0),
                // 'Go to Vote' button
                MyButton(
                  onPress: () {
                    // Navigator.pop(context);
                    Get.to(() => Dashboard(), transition: Transition.native);

                    // Close the dialog
                    // Navigate to voting screen or any other action
                    // Example: Get.to(() => VotingScreen());
                  },
                  text: 'Go to Vote',
                  elevation: 5,
                  height: 50,
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showAlert(
      {required BuildContext context, required String msg, required int type}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              type == 1
                  ? const Icon(
                      FontAwesomeIcons.check,
                      color: AppStyle.iconClr,
                      size: 50,
                    )
                  : type == 0
                      ? const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 60,
                        )
                      : const Icon(
                          Icons.info,
                          color: Color.fromARGB(255, 216, 195, 1),
                          size: 60,
                        ),
              SizedBox(height: 15),
              Text(
                msg,
                style: AppStyle().h3.copyWith(color: Colors.black),
              ),
            ],
          ),
          actions: [
            MyButton(
              onPress: () {
                Navigator.pop(context);
              },
              text: 'OK',
              fontWeight: FontWeight.w400,
              width: 30.w,
              height: 45,
              elevation: 0,
            )
          ],
        );
      },
    );
  }

  void showAlertDialog(BuildContext context, msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyAlertDialogWidget(
          title: msg,
          confirmBtnText: 'No',
        );
      },
    );
  }
}

// Usage

// MyAlertDialog().showAlertDialog(
//               context,
//               'Enter CNIC of Voter',
//               Form(
//                 key: formKey,
//                 child: FlatTextField(
//                   controller: cnic,
//                   keyboardType: TextInputType.number,
//                   labelText: 'CNIC',
//                   inputFormatter: Validation().cnicFormatter,
//                   validator: (value) => Validation().isValidCnic(value),
//                 ),
//               ),
//               'Add', () async {
//             if (formKey.currentState!.validate()) {
//               await OwnerDatabase().addVoter(cnic.text);
//               await fetchVoters();
//               cnic.text = '';
//               Navigator.pop(context);
//             }
//           });
//         }