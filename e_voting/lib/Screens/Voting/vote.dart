import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Controllers/candidate_control.dart';
import 'package:e_voting/Database/user_db.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Providers/candidateData.dart';
import 'package:e_voting/Providers/electionData.dart';
import 'package:e_voting/Screens/Widgets/Voting/Stepper.dart';
import 'package:e_voting/Screens/Widgets/Voting/candidateCard.dart';
import 'package:e_voting/Screens/Widgets/loading.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VotingPage extends StatefulWidget {
  String? ElecTitle;
  VotingPage({super.key, this.ElecTitle});

  @override
  State<VotingPage> createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  candidateData candi_data = Get.put(candidateData());
  //
  List<Map<String, dynamic>> candidateInfo = [];

  // QuerySnapshot? queryCandidate;
  bool data = false;
  //
  void fetchCandidates() {
    setState(() {
      candidateInfo = candi_data.candidatesList
          .map((item) => item as Map<String, dynamic>)
          .toList();
      // print(candidateInfo);
      data = true;
    });
  }

  // UserModel user = UserModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchCandidates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VoteLabel(),
          // My Stepper //
          const SizedBox(
            height: 10,
          ),
          VoteStepper(
            currentStepNo: 0,
          ),

          SizedBox(
            height: Applayout.greater760() ? 4.h : 1.h,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Choose your preferred candidate',
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
                // textAlign: TextAlign.left,
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),

          /// Candidate Card Section ///

          Expanded(
            child: SizedBox(
              width: Applayout.getscreenWidth() > 760 ? 70.w : 100.w,

              // height: 400,e
              child: ListView.builder(
                itemCount: candidateInfo.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  final candidate = candidateInfo[index];
                  return CandidateCard(
                    id: candidate['id'],
                    name: candidate['name'],
                    description: candidate['description'],
                  );
                },
              ),
            ),
          )

          // SizedBox(
          //   height: 30,
          // )
        ],
      ),
    );
  }
}
