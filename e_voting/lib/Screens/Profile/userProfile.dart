import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:e_voting/Screens/Auth/login.dart';
import 'package:e_voting/Screens/Widgets/Voting/voteLabel.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/userprofile.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          children: [
            SizedBox(
              height: Applayout.getheight(10),
            ),
            VoteLabel(
              voteName: 'Account',
              fontWeight: FontWeight.w700,
              alignment: Alignment.center,
            ),
            const gap(
              Height: 25,
            ),
            Stack(
              children: [
                Center(
                    child: GFBorder(
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
                )),
                Positioned(
                  left: 230,
                  top: 110,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppStyle.primaryColor,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                      ),
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
              'ALI ATHER',
              style: AppStyle.textStyle1
                  .copyWith(fontSize: 25, color: AppStyle.textClr),
              textAlign: TextAlign.center,
            ),
            gap(
              Height: 20,
            ),
            // Setting Section //
            ProfileSetting(title: 'Account Settings'),
            SettingLabel(label: 'Edit your personal information'),
            SettingLabel(label: 'Password reset'),
            gap(
              Height: 10,
            ),
            ProfileSetting(title: 'App Settings'),
            SettingLabel(label: 'Notifications'),
            gap(
              Height: 10,
            ),
            ProfileSetting(title: 'Support'),
            SettingLabel(label: 'FAQ'),
            SettingLabel(label: 'Contact us'),

            gap(
              Height: 30,
            ),
            // Button //

            MyButton(
              text: 'LOG OUT',
              width: 100.w,
              onPress: () {
                Get.off(() => LoginPage(),
                    // duration: const Duration(seconds: 1),
                    transition: Transition.native);
              },
            )
          ],
        ),
      ),
    );
  }
}
