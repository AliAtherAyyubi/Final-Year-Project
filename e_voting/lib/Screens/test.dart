import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Controllers/election_control.dart';
import 'package:e_voting/Controllers/org_controller.dart';
import 'package:e_voting/Controllers/userController.dart';
import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Models/organization.dart';
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(() => Text(
                data.username.toString().toUpperCase(),
                style: TextStyle(fontSize: 24),
              )),
          Text(
            'First Login Please',
            style: AppStyle.textStyle1,
          ),
          MyButton(
              text: 'Sign in',
              width: 90.w,
              onPress: () async {
                await UserController().Signin('ali@gmail.com', '123456');
              }),
          // MyButton(
          //     text: 'Update user',
          //     width: 90.w,
          //     onPress: () async {
          //       UserController().updateUserCnic('35201-5631623-2');
          //       // UserController().updateUserEmail('info2atherayyubi@gmail.com');
          //       await UserController().updateUserName('Ali Ather');
          //       // UserController().updateUserPassword('123456');
          //     }),
          // MyButton(
          //     text: 'Create Organization',
          //     width: 90.w,
          //     loading: false,
          //     onPress: () async {
          //       OrgController().createOrg();
          //     }),
          // MyButton(
          //     text: 'Update Organization',
          //     width: 90.w,
          //     loading: false,
          //     onPress: () async {
          //       OrgModel org = OrgModel();
          //       org.orgName = 'Apple';
          //       org.description =
          //           'Samsung made big electronic modern machines like smartphones etc';
          //       OrgDatabase().updateOrg(org);
          //     }),
          MyButton(
              text: 'Create Election',
              width: 90.w,
              loading: false,
              onPress: () async {
                ElectionController().createElection(
                  'Unity Rise 2024',
                  'Emphasizing solidarity and collaboration for progress, this election campaign pledges to unite diverse voices and forge a path towards a brighter future for all.',
                  'OnGoing',
                  Timestamp.fromDate(DateTime(2024, 4, 17)),
                  Timestamp.fromDate(DateTime(2024, 4, 25)),
                );
                ElectionController().createElection(
                  'Visionary Vanguard',
                  'Championing forward-thinking leadership, this campaign promises innovative solutions and strategic planning to address pressing issues and propel society towards prosperity and equity.',
                  'OnGoing',
                  Timestamp.fromDate(DateTime(2024, 4, 17)),
                  Timestamp.fromDate(DateTime(2024, 4, 25)),
                );
                ElectionController().createElection(
                  'Empowerment Express',
                  'Centered on empowerment and representation, this election movement aims to amplify voices, promote equality, and empower individuals to shape their destinies and communities.',
                  'OnGoing',
                  Timestamp.fromDate(DateTime(2024, 4, 17)),
                  Timestamp.fromDate(DateTime(2024, 4, 25)),
                );
              }),
          // MyButton(
          //   text: 'Update Elections',
          //   onPress: () async {
          //     QuerySnapshot? querySnapshot =
          //         await ElectionController().fetchElections();
          //     String id = querySnapshot!.docs[1].get('electionId');

          //     ElectionModel e = ElectionModel();
          //     e.electionName = 'Student Rpresentative';
          //     e.description = 'University elections are going to held';
          //     e.status = 'upcoming';
          //     e.electionId = id;
          //     await ElectionController().updateElection(e);
          //   },
          // ),
          MyButton(
            text: 'Fetch Elections by ID',
            onPress: () async {
              QuerySnapshot? querySnapshot =
                  await ElectionController().fetchElections();

              ElectionModel? e = ElectionModel();
              var size = querySnapshot.docs.length;
              for (var i = 0; i < size; i++) {
                e = await ElectionDatabase()
                    .fetchElectionById(querySnapshot.docs[i].id);
                print(e!.startDate!.toDate());
              }
            },
          )
        ],
      ),
    );
  }
}
