import 'package:e_voting/Screens/Auth/authScreen.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ////
    Future.delayed(const Duration(seconds: 4), () {
      Get.off(() => const AuthScreen(),
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
