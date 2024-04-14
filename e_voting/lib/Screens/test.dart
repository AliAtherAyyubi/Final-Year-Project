import 'package:e_voting/Controllers/election_control.dart';
import 'package:e_voting/Controllers/org_controller.dart';
import 'package:e_voting/Controllers/userController.dart';
import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Sample extends StatelessWidget {
  String getMonthName(int monthNumber) {
    List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[
        monthNumber - 1]; // Adjust index since month numbers start from 1
  }

  UserData data = Get.put(UserData());
  @override
  Widget build(BuildContext context) {
    String name = data.username.toString();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(() => Text(name)),
          Text(
            'First Login Please',
            style: AppStyle.textStyle1,
          ),
          MyButton(
              text: 'Sign in',
              width: 90.w,
              onPress: () async {
                await UserController()
                    .Signin(context, 'najam@gmail.com', '123456');
              }),
          MyButton(
              text: 'Create Organization',
              width: 90.w,
              loading: true,
              onPress: () async {
                var id = Get.put(UserData()).userID.toString();
                OrgController().createOrg(id);
              }),
          MyButton(
              text: 'Create Election',
              width: 90.w,
              // loading: true,
              onPress: () async {
                print(DateTime.timestamp());
                String startDate = DateTime.now().day.toString() +
                    " " +
                    getMonthName(DateTime.now().month);
                String endDate =
                    DateTime(DateTime.now().year, 5, 11).day.toString() +
                        " " +
                        getMonthName(DateTime.june);

                ElectionController().createElection('Unity Vote 2024',
                    'Democracy Now', 'OnGoing', startDate, endDate);
              }),
          MyButton(
            text: 'Get OrgId',
            onPress: () async {
              var id = await OrgDatabase().GetOrgId();
              print('OrgID:$id');
            },
          )
        ],
      ),
    );
  }
}
