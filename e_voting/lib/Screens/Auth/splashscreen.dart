import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Screens/Auth/authScreen.dart';
import 'package:e_voting/Screens/Homepage/dashboard.dart';
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
  bool isUser = false;
  Future<void> checkUser() async {
    isUser = await user.checkUserLoggedIn();
    print('UserExist:$isUser');
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ////
    checkUser();
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(() => isUser ? Dashboard() : AuthScreen(),
          duration: Duration(milliseconds: 100), transition: Transition.native);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.primaryColor,
      body: Center(
        child: Text(
          'WeVote',
          style: AppStyle.headstyle.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
