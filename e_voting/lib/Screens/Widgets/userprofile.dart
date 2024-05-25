import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileSetting extends StatelessWidget {
  final String title;
  ProfileSetting({required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          color: AppStyle.darkGreen,
          thickness: 1,

          // height: 10,
        ),
        gap(
          Height: Applayout.getheight(10),
        ),
        Text(
          title,
          style:
              AppStyle.textStyle2.copyWith(color: Colors.black, fontSize: 20),
        ),
        const gap(
          Height: 5,
        ),
      ],
    );
  }
}

class SettingLabel extends StatelessWidget {
  final String label;
  SettingLabel({required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label,
        //   style: AppStyle.textStyle4
        //       .copyWith(fontSize: 17.sp, fontWeight: FontWeight.w100),
        // ),
        // const gap(
        //   Height: 10,
        // ),
        Container(
          height: 40,
          child: Center(
            child: ListTile(
              // leading: Icon(Icons.person),
              title: Text(
                '$label',
                style: AppStyle.textStyle4
                    .copyWith(fontSize: 17.sp, fontWeight: FontWeight.w100),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      ],
    );
  }
}
