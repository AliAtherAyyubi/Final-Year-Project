import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Controllers/election_control.dart';
import 'package:e_voting/Controllers/image_control.dart';
import 'package:e_voting/Controllers/userController.dart';
import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          imageUrl != null
              ? Container(
                  height: 200,
                  width: 250,
                  child: Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/e-voting-9ab22.appspot.com/o/profile_images%2FlessSize.jpg?alt=media&token=def6464e-20cc-42e2-8879-06854797276f",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      print('Error loading image: $error');
                      return Text('Error loading image');
                    },
                  ),
                )
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
                await UserController().Signin('ali@gmail.com', '123456');
                fetchImage();
              }),
          MyButton(
              text: 'Upload Image',
              width: 90.w,
              onPress: () async {
                await ImageController().getImage();
              }),
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

  //
}

  // Future<void> _uploadImage() async {
  //   final XFile? image = await ImagePicker().pickImage(
  //     source: ImageSource.gallery, // Allow picking from gallery
  //   );

  //   if (image != null) {
  //     // Check if the selected file is an image
  //     if (['jpg', 'jpeg', 'png', 'gif']
  //         .contains(image.path.split('.').last.toLowerCase())) {
  //       print('Please select an image file.');
  //       return;
  //     }

  //     final fileBytes = await image.readAsBytes();
  //     final fileName = image.name;
  //     await UserController().uploadImage(fileName, fileBytes);
  //   } else {
  //     print('No image selected.');
  //   }
  // }
