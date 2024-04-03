import 'package:e_voting/Screens/Widgets/Voting/Stepper.dart';
import 'package:e_voting/Screens/Widgets/Voting/candidateCard.dart';
import 'package:e_voting/Screens/Widgets/Voting/voteLabel.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VotingPage extends StatefulWidget {
  VotingPage({super.key});

  @override
  State<VotingPage> createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  String voteName = 'Vote for Student Representatives';

  List<String> candidateName = [
    'Harry Brook',
    'Alice Henry',
    'William Washington',
    'Sohaib Zafar',
    'Syed Ali Raza',
    'Asgar Zaidi',
    'Najam-Ud-Din',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 6.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: VoteLabel(
              voteName: voteName,
              // alignment: Alignment.center,
            ),
          ),
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
                  itemCount: candidateName.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    return CandidateCard(
                        name: candidateName[index],
                        description:
                            'I\'ll let your voice be heard and work towards the fulfillment of your needs.');
                  }),
            ),
          ),

          // SizedBox(
          //   height: 30,
          // )
        ],
      ),
    );
  }
}
