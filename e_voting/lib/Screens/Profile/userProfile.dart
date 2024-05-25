import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:e_voting/Controllers/image_control.dart';
import 'package:e_voting/Controllers/userController.dart';
import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Auth/login.dart';
import 'package:e_voting/Screens/Profile/Settings/editProfile.dart';
import 'package:e_voting/Screens/Profile/Settings/resetPassword.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:e_voting/Screens/Widgets/loading.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/userprofile.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserProfilePage extends StatefulWidget {
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserData data = Get.put(UserData());
  UserModel user = UserModel();
// to get from gallery and upload //
  String imageUrl = "";
  String name = "";
  bool loading = false;
  Future<void> getImage() async {
    try {
      XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final File path = File(pickedFile.path);
        // final name = pickedFile.name;
        final id = data.userID;
        setState(() {
          imageUrl = "";
          loading = true;
        });
        var res = await ImageController().uploadImage(id, path);
        if (res == null) {
          await fetchUserInfo();
          MyAlert.Alert("", 'Uploaded Successfully!');
        } else
          MyAlert.Alert("", res.toString());
      }
    } catch (e) {
      MyAlert.Alert("", 'System Error');

      // print('System Error');
    }
  }

  Future<void> fetchUserInfo() async {
    UserModel getuser = await UserLocalData().fetchLocalUser();
    setState(() {
      user = getuser;
      imageUrl = user.imageUrl ?? "";
      name = user.userName!.toUpperCase();
      print(name);
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: ScreenTitle(
            title: 'Account',
          )),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              imageUrl == ""
                  ? GFBorder(
                      color: Colors.green,
                      strokeWidth: 3,
                      type: GFBorderType.circle,
                      dashedLine: [4, 7],
                      padding: EdgeInsets.all(0),
                      child: GFAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 90,
                          child: loading
                              ? Loading(
                                  color: AppStyle.primaryColor,
                                )
                              : const Icon(
                                  Icons.face,
                                  size: 35,
                                  color: AppStyle.primaryColor,
                                )))
                  : CircularProfileAvatar(
                      imageUrl,
                      radius: 90,
                      cacheImage: true,
                      elevation: 10,
                    ),
              Positioned(
                right: Applayout.getWidth(80),
                bottom: Applayout.getWidth(20),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppStyle.primaryColor,
                  child: IconButton(
                    onPressed: loading ? null : getImage,
                    icon: const Icon(
                      Icons.camera_alt,
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
            name,
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
          GestureDetector(
              onTap: () {
                Get.to(() => EditUserProfile(),
                    transition: Transition.rightToLeft);
              },
              child: SettingLabel(label: 'Edit your personal information')),
          GestureDetector(
              onTap: () => Get.to(() => PasswordResetPage(),
                  transition: Transition.rightToLeft),
              child: SettingLabel(label: 'Password reset')),
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
              Get.offAll(() => LoginPage(),
                  // duration: const Duration(seconds: 1),
                  transition: Transition.native);
            },
          )
        ],
      ),
    );
  }
}
