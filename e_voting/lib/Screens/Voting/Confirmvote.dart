import 'package:e_voting/Controllers/vote_control.dart';
import 'package:e_voting/Providers/candidateData.dart';
import 'package:e_voting/Providers/electionData.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Voting/voteSuccess.dart';
import 'package:e_voting/Screens/Widgets/Voting/Stepper.dart';
import 'package:e_voting/Screens/Widgets/alertDialog.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/candidateAvatar.dart';
import 'package:e_voting/Screens/Widgets/myAvatar.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConfirmVote extends StatefulWidget {
  @override
  State<ConfirmVote> createState() => _ConfirmVoteState();
}

class _ConfirmVoteState extends State<ConfirmVote> {
  UserData user = Get.put(UserData());

  candidateData candidate = Get.put(candidateData());

  electionData election = Get.put(electionData());
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VoteLabel(),
            const SizedBox(
              height: 10,
            ),
            VoteStepper(
              currentStepNo: 3,
            ),
            gap(
              Height: Applayout.getheight(50),
            ),
            Container(
              width: 80.w,
              child: Text(
                'Are you sure you want to vote for this candidate? Once confirmed, this action can\'t be undone.',
                style: GoogleFonts.inter(
                    fontSize: 18.sp, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            gap(
              Height: Applayout.getheight(20),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: Applayout.getheight(380),
              // color: Colors.amber,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: Applayout.getheight(200),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppStyle.cardClr,
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 121, 219, 151),
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: Offset(0, 5))
                      ],
                      borderRadius:
                          BorderRadius.circular(Applayout.getheight(30)),
                    ),
                  ),
                  Obx(
                    () => Positioned(
                        top: 0,
                        child: CandidateAvatar(
                          radius: 24.w,
                          fontsize: 20,
                          image: 'assets/images/profile.jpg',
                          name: candidate.candidateName.toString().capitalize,
                        )),
                  )
                ],
              ),
            ),
            MyButton(
              text: 'CONFIRM',
              width: 95.w,
              loading: loading,
              onPress: () async {
                setState(() {
                  loading = true;
                });
                var userId = user.userID.toString();
                var cand_id = candidate.candidateId.toString();
                var elecId = election.electionId.toString();
                var votedfor = election.electionTitle.toString();
                var orgId = "3eme9c3NHtINcgybKYxd";
                await VoteController()
                    .createVote(userId, elecId, cand_id, orgId, votedfor);
                setState(() {
                  loading = false;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            MyTextButton(
              text: 'CANCEL',
              textClr: AppStyle.textClr,
              elevation: 0,
              border: false,
              onPress: () {
                // MyAlertDialog().showCustomAlertDialog(context);
                Get.to(() => Dashboard(), transition: Transition.leftToRight);
              },
            ),
          ],
        ),
      ),
    );
  }
}
