import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Controllers/election_control.dart';
import 'package:e_voting/Controllers/image_control.dart';
import 'package:e_voting/Controllers/userController.dart';
import 'package:e_voting/Database/candidate_db.dart';
import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Models/candidate.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Sample extends StatefulWidget {
  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  UserData data = Get.put(UserData());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  File? imageFile;
// to get from gallery and upload //
  Future<void> getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final File path = File(pickedFile!.path);
    // final name = pickedFile.name;
    final name = data.userID;
    setState(() {
      // imageUrl = null;
      imageFile = path;
    });

    // await ImageController().uploadImage(name, path);
    // fetchImage();
  }

  String? imageUrl;
  Future<void> fetchImage() async {
    String url = await ImageController().fetchImage();
    setState(() {
      imageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          imageFile != null
              ? Container(
                  height: 50,
                  width: 80,
                  child: Image.file(imageFile!),
                )
              // ? CircularProfileAvatar(
              //     imageUrl!,
              //     radius: 80,
              //     cacheImage: true,
              //   )
              : CircularProgressIndicator(),
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
                await UserController().Signin('shoaib@gmail.com', '123456');
                fetchImage();
              }),
          MyButton(text: 'Upload Image', width: 90.w, onPress: getImage),
          MyButton(
              text: 'Create Canddiate',
              width: 90.w,
              onPress: () async {
                CandidateModel c = CandidateModel();
                c.cnic = '35201-45653161-1';
                c.description = [
                  'Dynamic leader with vision, integrity, and dedication, transforming organizations positively.',
                  'Dynamic leader with vision, integrity, and dedication, transforming organizations positively.'
                ];
                c.userId = data.userID.toString();

                await CandidateDB().createCandidate(c);
              }),
        ],
      ),
    );
  }

  //
}
// MyButton(
//             text: 'Fetch Elections by ID',
//             onPress: () async {
//               QuerySnapshot? querySnapshot =
//                   await ElectionController().fetchElections();

//               ElectionModel? e = ElectionModel();
//               var size = querySnapshot.docs.length;
//               for (var i = 0; i < size; i++) {
//                 e = await ElectionDatabase()
//                     .fetchElectionById(querySnapshot.docs[i].id);
//                 print(e!.startDate!.toDate());
//               }
//             },
//           )
  // Future<void> _uploadImage() async {
  //   final result = await FilePicker.platform.pickFiles(
    //   type: FileType.image,
    //   allowMultiple: false,
    // );

    // if (result != null) {
    //   final file = result.files.first;

    //   // Check if the selected file is an image
    //   if (file.extension != 'jpg' &&
    //       file.extension != 'jpeg' &&
    //       file.extension != 'png' &&
    //       file.extension != 'gif') {
    //     print('Please select an image file.');
    //     return;
    //   }
    //   final fileBytes = result.files.first.bytes;
    //   final fileName = result.files.first.name;
    //   // var fileName = 'user';
    //   uploadImage(fileName, fileBytes);
    // } else {
    //   print('Please Select image only');
    // }
  // }
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
          // MyButton(
          //     text: 'Create Election',
          //     width: 90.w,
          //     loading: false,
          //     onPress: () async {
          //       ElectionController().createElection(
          //         'Unity Rise 2024',
          //         'Emphasizing solidarity and collaboration for progress, this election campaign pledges to unite diverse voices and forge a path towards a brighter future for all.',
          //         'OnGoing',
          //         Timestamp.fromDate(DateTime(2024, 4, 17)),
          //         Timestamp.fromDate(DateTime(2024, 4, 25)),
          //       );
          //       ElectionController().createElection(
          //         'Visionary Vanguard',
          //         'Championing forward-thinking leadership, this campaign promises innovative solutions and strategic planning to address pressing issues and propel society towards prosperity and equity.',
          //         'OnGoing',
          //         Timestamp.fromDate(DateTime(2024, 4, 17)),
          //         Timestamp.fromDate(DateTime(2024, 4, 25)),
          //       );
          //       ElectionController().createElection(
          //         'Empowerment Express',
          //         'Centered on empowerment and representation, this election movement aims to amplify voices, promote equality, and empower individuals to shape their destinies and communities.',
          //         'OnGoing',
          //         Timestamp.fromDate(DateTime(2024, 4, 17)),
          //         Timestamp.fromDate(DateTime(2024, 4, 25)),
          //       );
          //     }),
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