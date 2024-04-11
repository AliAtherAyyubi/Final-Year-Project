import 'package:e_voting/Controllers/userController.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Auth/login.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/userprofile.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserProfilePage extends StatelessWidget {
  UserData data = Get.put(UserData());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: ScreenTitle(
            title: 'Account',
          )),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          // // SizedBox(
          // //   height: 5.h,
          // // ),
          // VoteLabel(
          //   voteName: 'Account',
          //   fontWeight: FontWeight.w700,
          //   alignment: Alignment.center,
          // ),
          const gap(
            Height: 5,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              GFBorder(
                color: Colors.green,
                strokeWidth: 3,
                type: GFBorderType.circle,
                dashedLine: [4, 7],
                padding: EdgeInsets.all(0),
                child: const GFAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 80,
                  child: Icon(
                    Icons.face,
                    size: 35,
                    color: AppStyle.primaryColor,
                  ),
                ),
              ),
              Positioned(
                right: Applayout.getWidth(75),
                bottom: Applayout.getWidth(20),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppStyle.primaryColor,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                    ),
                    // splashRadius: 20,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          gap(
            Height: Applayout.getheight(20),
          ),
          Text(
            Provider.of<UserData>(context, listen: false)
                .username
                .toUpperCase(),
            style: AppStyle.textStyle1.copyWith(
              fontSize: 25,
              color: AppStyle.textClr,
            ),
            textAlign: TextAlign.center,
          ),
          const gap(
            Height: 20,
          ),
          // Setting Section //
          ProfileSetting(title: 'Account Settings'),
          SettingLabel(label: 'Edit your personal information'),
          SettingLabel(label: 'Password reset'),
          const gap(
            Height: 10,
          ),
          ProfileSetting(title: 'App Settings'),
          SettingLabel(label: 'Notifications'),
          const gap(
            Height: 10,
          ),
          ProfileSetting(title: 'Support'),
          SettingLabel(label: 'FAQ'),
          SettingLabel(label: 'Contact us'),

          const gap(
            Height: 30,
          ),
          // Button //

          MyButton(
            text: 'LOG OUT',
            width: 100.w,
            // loading: true,
            onPress: () async {
              await UserController().signOut();
              Get.off(() => LoginPage(),
                  // duration: const Duration(seconds: 1),
                  transition: Transition.native);
            },
          )
        ],
      ),
    );
  }
}
