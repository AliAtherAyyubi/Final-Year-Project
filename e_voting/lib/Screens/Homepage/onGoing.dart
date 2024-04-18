import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Controllers/election_control.dart';
import 'package:e_voting/Providers/VotingInfo.dart';
import 'package:e_voting/Screens/Profile/candi_Profile.dart';
import 'package:e_voting/Screens/Voting/vote.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/candidateAvatar.dart';
import 'package:e_voting/Screens/Widgets/Voting/voteCard.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnGoingElectionPage extends StatefulWidget {
  @override
  State<OnGoingElectionPage> createState() => _OnGoingElectionPageState();
}

class _OnGoingElectionPageState extends State<OnGoingElectionPage> {
  // OnGoingElectionPage({super.key});
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

  List<String> candidateName = [
    'Harry Brook',
    'Alice Henry',
    'William Washington',
    'Sohaib Zafar',
    'Syed Ali Raza',
    'Asgar Zaidi'
  ];
  late QuerySnapshot querySnapshot;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchElection();
  }

  bool data = false;
  Future<void> fetchElection() async {
    QuerySnapshot Snapshot = await ElectionController().fetchElections();

    setState(() {
      if (Snapshot.docs.isNotEmpty) {
        querySnapshot = Snapshot;
        data = true;
      }
    });
  }

  String getDate(int index) {
    var startDay = querySnapshot.docs[index].get('startDate').toDate().day;
    var endDay = querySnapshot.docs[index].get('endDate').toDate().day;
    String month =
        getMonthName(querySnapshot.docs[index].get('startDate').toDate().month);

    String time = '$month $startDay - $endDay';
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: data
          ? Column(
              children: [
                SizedBox(
                  height: Applayout.getheight(5),
                ),

                // Card Section //
                Container(
                  color: Colors.transparent,
                  height: 30.h,
                  child: ListView.builder(
                    itemCount: querySnapshot.docs.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return VoteCard(
                        title: querySnapshot.docs[index].get('name'),
                        time: getDate(index),
                        description:
                            querySnapshot.docs[index].get('description'),
                      );
                    },
                  ),
                ),

                SizedBox(
                  height: Applayout.getheight(10),
                ),

                /// Candidates Section //

                Text(
                  '6 Candidates',
                  style: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.bold),
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
                          child: CandidateAvatar(
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
            )
          : const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                  child: CircularProgressIndicator(
                color: AppStyle.textClr,
              )),
            ),
    );
  }
}
