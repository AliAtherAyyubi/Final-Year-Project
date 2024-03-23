import 'package:e_voting/Screens/Widgets/Voting/Stepper.dart';
import 'package:e_voting/Screens/Widgets/Voting/candidateCard.dart';
import 'package:e_voting/Screens/Widgets/Voting/voteLabel.dart';
import 'package:e_voting/utils/Applayout.dart';
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
    'Asgar Zaidi'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            VoteLabel(
              voteName: voteName,
            ),
            // My Stepper //

            VoteStepper(
              currentStepNo: 0,
            ),

            const SizedBox(
              height: 10,
            ),
            Text(
              'Choose your preferred candidate',
              style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20,
            ),

            /// Candidate Card Section ///

            Expanded(
              child: Container(
                width: 90.w,
                // height: 400,
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
      ),
    );
  }
}
