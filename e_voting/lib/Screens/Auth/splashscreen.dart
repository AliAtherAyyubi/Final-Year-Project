import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Screens/Auth/authScreen.dart';
import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Homepage/mainDasboard.dart';
import 'package:e_voting/Screens/Admin/adminPage.dart';
import 'package:e_voting/Screens/Admin/AdminNavbar.dart';
import 'package:e_voting/Screens/Widgets/logo.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserLocalData user = UserLocalData();
  String userRole = "";
  bool isLogIn = false;
  ///////
  Future<void> checkUser() async {
    UserModel currentUser = await user.fetchLocalUser();
    isLogIn = await user.checkUserLoggedIn();

    await user.setUserId();
    setState(() {
      userRole = currentUser.role!.toLowerCase();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ////
    checkUser();
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(
          () => isLogIn
              ? userRole == 'owner'
                  ? OwnerMainScreen()
                  : DashboardScreen()
              : AuthScreen(),
          duration: Duration(milliseconds: 100),
          transition: Transition.native);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.primaryColor,
      body: Center(
        child: MyLogo(),
      ),
    );
  }
}
