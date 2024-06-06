import 'package:e_voting/Screens/Widgets/loading.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyAlertDialog extends StatelessWidget {
  final String? title;
  final Widget? content;
  final String? confirmBtnText;
  bool loading;
  // final String? cancelButtonText;
  final VoidCallback? onConfirm;
  // final VoidCallback onCancel;

  MyAlertDialog(
      {Key? key,
      required this.title,
      this.content,
      this.onConfirm,
      this.loading = false,
      this.confirmBtnText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title!,
        style: TextStyle(
          color: Colors.green.shade900,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: content,
      actions: [
        MyTextButton(
          onPress: () {
            Navigator.pop(context);
          },
          text: 'Cancel',
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
          width: 28.w,
          loading: loading,
        ),
      ],
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