import 'package:e_voting/Screens/Auth/firstscreen.dart';
import 'package:e_voting/Screens/Auth/login.dart';
import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Profile/candi_Profile.dart';
import 'package:e_voting/Screens/Voting/Facerecognition1.dart';
import 'package:e_voting/Screens/Voting/idCheck.dart';
import 'package:e_voting/Screens/Voting/vote.dart';

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
        getPages: [
          GetPage(
            name: "/loginpage",
            page: () => LoginPage(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: Duration(microseconds: 1),
          )
        ],
        home: FirstScreen(),
      );
    });
  }
}
