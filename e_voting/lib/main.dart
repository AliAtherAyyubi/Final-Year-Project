import 'package:e_voting/Views/Auth/Facerecognition1.dart';
import 'package:e_voting/Views/Auth/forgotPass.dart';
import 'package:e_voting/Views/Auth/login.dart';
import 'package:e_voting/Views/Auth/registerPage.dart';
import 'package:e_voting/Views/Auth/resetPassword.dart';
import 'package:e_voting/Views/Auth/welcome.dart';
import 'package:e_voting/Views/Homepage/Profile/candi_Profile.dart';
import 'package:e_voting/Views/Homepage/Voting/upcoming.dart';
import 'package:e_voting/Views/Homepage/Voting/vote.dart';
import 'package:e_voting/Views/Homepage/dashboard.dart';
import 'package:e_voting/Views/Widgets/ProgressBar/ProgressBar1.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, ScreenType) {
      return GetMaterialApp(
        title: 'E-voting App',
        theme: ThemeData(
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            // useMaterial3: true,
            // fontFamily: ,
            primaryColor: Color(0xff4CBB17)),
        debugShowCheckedModeBanner: false,
        home: ProgressBar(),
      );
    });
  }
}
