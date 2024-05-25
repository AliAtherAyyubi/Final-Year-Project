import 'package:e_voting/Controllers/userController.dart';
import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/Services/validation.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  // const PasswordResetPage({super.key});
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  // TextEditingController currentPassword = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();
  void clear() {
    password.text = "";
    confirmPassword.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: ScreenTitle(
          title: 'Reset Password',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              'Change Your Password',
              style: AppStyle.headstyle
                  .copyWith(color: Colors.black, fontSize: 25),
            ),
            SizedBox(
              height: 40,
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    // AuthTextField(
                    //   controller: currentPassword,
                    //   keyboardType: TextInputType.visiblePassword,
                    //   hintText: 'Current Password',
                    //   icon: Icons.password,
                    //   hidebtn: Icons.visibility_off,
                    //   validator: (value) {
                    //     // if (value.isEmpty) return 'Enter password';
                    //     return Validation().isValidPassword(value);
                    //   },
                    // ),
                    AuthTextField(
                      controller: password,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Enter Password',
                      icon: Icons.password,
                      obscureText: true,
                      hidebtn: Icons.visibility_off,
                      validator: (value) {
                        // if (value.isEmpty) return 'Enter password';
                        return Validation().isValidPassword(value);
                      },
                    ),
                    AuthTextField(
                      controller: confirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Confirm Password',
                      icon: Icons.rotate_left_sharp,
                      obscureText: true,
                      hidebtn: Icons.visibility_off,
                      validator: (value) {
                        if (password.text != confirmPassword.text)
                          return 'Password are not same';
                        return Validation().isValidPassword(value);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyButton(
                      onPress: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          await UserController()
                              .updateUserPassword(password.text);
                          // Get.to(() => Dashboard(),
                          //     transition: Transition.leftToRight);

                          setState(() {
                            loading = false;
                          });
                          clear();
                        }
                      },
                      text: 'Save Password',
                      width: 90.w,
                      loading: loading,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
