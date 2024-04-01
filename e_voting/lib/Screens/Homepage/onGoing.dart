import 'package:e_voting/Providers/VotingInfo.dart';
import 'package:e_voting/Screens/Profile/candi_Profile.dart';
import 'package:e_voting/Screens/Voting/vote.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/candidateAvatar.dart';
import 'package:e_voting/Screens/Widgets/voteCard.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnGoingElectionPage extends StatelessWidget {
  OnGoingElectionPage({super.key});

  List<String> candidateName = [
    'Harry Brook',
    'Alice Henry',
    'William Washington',
    'Sohaib Zafar',
    'Syed Ali Raza',
    'Asgar Zaidi'
  ];

  List<String> voteNames = [
    'Student Representatives',
    'Free Democratic Party',
    'Presidential Power Play',
    'National Liberal Party'
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: Applayout.getheight(5),
          ),

          // Card Section //
          Container(
            color: Colors.transparent,
            height: 30.h,
            child: ListView.builder(
              itemCount: voteNames.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return VoteCard(
                    title: voteNames[index],
                    time: 'April 10th to 11th - 8am to 10pm',
                    description:
                        'Student representatives are known as enrolled scholars at their instituion elected to lobby for student\'s rights and represent the point of view of their peers.');
              },
            ),
          ),

          SizedBox(
            height: Applayout.getheight(10),
          ),

          /// Candidates Section //

          Text(
            '6 Candidates',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          // Candidates List>>>>>>
          Container(
            margin: EdgeInsets.only(top: Applayout.getheight(25)),
            // padding: EdgeInsets.symmetric(horizontal: 10),
            //color: Colors.amber,
            width: double.infinity,
            height: Applayout.getheight(200),
            child: ListView.builder(
                itemCount: 6,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                // padding: EdgeInsets.only(left: Applayout.getWidth(20)),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => CandidateProfile(),
                          transition: Transition.fade);
                    },
                    child: MyProfileAvatar(
                      name: candidateName[index],
                      image: 'assets/images/profile.jpg',
                    ),
                  );
                }),
          ),
          MyButton(
            text: 'VOTE NOW',
            width: 90.w,
            onPress: () {
              Get.to(() => VotingPage(), transition: Transition.fade);
            },
          ),
          SizedBox(
            height: Applayout.getheight(15),
          ),
        ],
      ),
    );
  }
}
