import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Auth/authScreen.dart';
import 'package:e_voting/Screens/Auth/forgotPass.dart';
import 'package:e_voting/Screens/Auth/login.dart';
import 'package:e_voting/Screens/Auth/registerPage.dart';
import 'package:e_voting/Screens/Auth/resetPassword.dart';
import 'package:e_voting/Screens/Auth/splashscreen.dart';
import 'package:e_voting/Screens/Auth/welcome.dart';
import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Owner/Owner%20Elections/displayElection.dart';
import 'package:e_voting/Screens/Owner/ownerPage.dart';
import 'package:e_voting/Screens/Owner/ownerScreen.dart';
import 'package:e_voting/Screens/Profile/Settings/editProfile.dart';
import 'package:e_voting/Screens/Profile/userProfile.dart';
import 'package:e_voting/Screens/Voting/Confirmvote.dart';
import 'package:e_voting/Screens/Voting/Facerecognition1.dart';
import 'package:e_voting/Screens/Voting/idCheck.dart';
import 'package:e_voting/Screens/Voting/receipt.dart';
import 'package:e_voting/Screens/Voting/vote.dart';
import 'package:e_voting/Screens/Voting/voteSuccess.dart';
import 'package:e_voting/Screens/test.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase intitialization //
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Main App //
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(), // Wrap your app
  // ));
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
        // builder: FToastBuilder(),
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,

        debugShowCheckedModeBanner: false,
        // getPages: [z
        //   GetPage(
        //     name: "/loginpage",
        //     page: () => LoginPage(),
        //     transition: Transition.rightToLeftWithFade,
        //     transitionDuration: Duration(microseconds: 1),
        //   )
        // ],
        home: SplashScreen(),
      );
    });
  }
}
