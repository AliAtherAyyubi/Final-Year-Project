import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Controllers/candidate_control.dart';
import 'package:e_voting/Controllers/election_control.dart';
import 'package:e_voting/Database/user_db.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Providers/VotingInfo.dart';
import 'package:e_voting/Screens/Profile/candi_Profile.dart';
import 'package:e_voting/Screens/Voting/vote.dart';
import 'package:e_voting/Screens/Widgets/loading.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/candidateAvatar.dart';
import 'package:e_voting/Screens/Widgets/Voting/voteCard.dart';
import 'package:e_voting/Services/dateTime.dart';
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

  List<String>? candidateName = [];
  late QuerySnapshot querySnapshot;
  QuerySnapshot? queryCandidate;
  late var doc;

  bool data = false;
  String getDate(int index) {
    var startDay = querySnapshot.docs[index].get('startDate').toDate().day;
    var endDay = querySnapshot.docs[index].get('endDate').toDate().day;
    String month = TimeService().getMonthName(
        querySnapshot.docs[index].get('startDate').toDate().month);

    String time = '$month $startDay - $endDay';
    return time;
  }

  Future<void> fetchElection() async {
    QuerySnapshot Snapshot = await ElectionController().fetchElections();

    setState(() {
      if (Snapshot.docs.isNotEmpty) {
        querySnapshot = Snapshot;
        data = true;
      }
    });
  }

  UserModel user = UserModel();
  Future<void> fetchCanddiates() async {
    queryCandidate = await CandidateController().fetchCandidates();
    doc = queryCandidate!.docs;
    for (var i = 0; i < queryCandidate!.docs.length; i++) {
      var uid = queryCandidate!.docs[i].get('userId');
      user = await userDatabase().getUserById(uid);
      candidateName!.add(user.userName.toString());
    }
    // print(candidateName);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchElection();
    fetchCanddiates();
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
                  '${candidateName!.length} Candidate',
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
                  child: candidateName != null
                      ? ListView.builder(
                          itemCount: candidateName!.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                    () => CandidateProfile(
                                          name:
                                              candidateName![index].capitalize,
                                          description:
                                              doc[index].get('description'),
                                        ),
                                    transition: Transition.fade);
                              },
                              child: CandidateAvatar(
                                name: candidateName![index].capitalize,
                                image: 'assets/images/profile.jpg',
                              ),
                            );
                          })
                      : SizedBox(
                          height: 50,
                          width: 50,
                          child: Loading(
                            color: AppStyle.textClr,
                          ),
                        ),
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
