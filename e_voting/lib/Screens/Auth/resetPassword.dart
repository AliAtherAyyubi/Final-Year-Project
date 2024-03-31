import 'package:e_voting/Screens/Widgets/Voting/voteLabel.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResetPasswordPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                VoteLabel(
                  voteName: 'Create a New Password',
                  alignment: Alignment.center,
                  fontWeight: FontWeight.bold,
                  fontsize: 20,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 50.h,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/reset.jpg',
                    filterQuality: FilterQuality.high,
                  ),
                ),
                SizedBox(height: 40),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AuthTextField(
                          controller: password,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          labelText: 'New Password',
                          icon: Icons.password,
                          hidebtn: Icons.visibility_off,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AuthTextField(
                          controller: password,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          labelText: 'Confirm New Password',
                          icon: Icons.lock_reset,
                          hidebtn: Icons.visibility_off,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyButton(
                          text: 'Submit',
                          width: 100.w,
                        )
                      ],
                    )),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
