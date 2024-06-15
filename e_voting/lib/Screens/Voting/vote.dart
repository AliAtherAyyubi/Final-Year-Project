import 'package:e_voting/Models/candidate.dart';
import 'package:e_voting/Screens/Widgets/Voting/Stepper.dart';
import 'package:e_voting/Screens/Widgets/Voting/candidateCard.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VotingPage extends StatelessWidget {
  String? ElecTitle;
  List<CandidateModel>? candidatesList = [];

  VotingPage({super.key, this.candidatesList});

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

          candidatesList == null
              ? Text('No Candidate')
              : Expanded(
                  child: SizedBox(
                    width: Applayout.getscreenWidth() > 760 ? 70.w : 100.w,

                    // height: 400,e
                    child: ListView.builder(
                      itemCount: candidatesList!.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemBuilder: (context, index) {
                        final candidate = candidatesList![index];
                        return CandidateCard(
                          candidate: candidate,
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
