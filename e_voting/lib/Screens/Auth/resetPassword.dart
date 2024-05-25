import 'package:e_voting/Screens/Auth/login.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Services/textControl.dart';
import 'package:e_voting/Services/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResetPasswordPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextController textController = TextController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: ScreenTitle(title: 'Create New Password')),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                          controller: textController.password,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          labelText: 'New Password',
                          icon: Icons.password,
                          hidebtn: Icons.visibility_off,
                          validator: (value) =>
                              Validation().isValidPassword(value),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AuthTextField(
                          controller: textController.confirmPassword,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          labelText: 'Confirm New Password',
                          icon: Icons.lock_reset,
                          hidebtn: Icons.visibility_off,
                          validator: (value) {
                            if (textController.password.text !=
                                textController.confirmPassword.text) {
                              return 'Password don\'t match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyButton(
                          text: 'Submit',
                          width: 100.w,
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              MyAlert.Alert(
                                  'Password Changed successfully!', '');
                              Future.delayed(Duration(seconds: 4), () {
                                Get.off(() => LoginPage(),
                                    transition: Transition.native);
                              });
                            }
                          },
                        )
                      ],
                    )),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
