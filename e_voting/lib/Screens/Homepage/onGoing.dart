import 'package:e_voting/Controllers/election_control.dart';
import 'package:e_voting/Database/candidate_db.dart';
import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Models/candidate.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Providers/electionData.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Voting/vote.dart';
import 'package:e_voting/Screens/Widgets/alertDialog.dart';
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
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//////////
class OnGoingElectionPage extends StatefulWidget {
  @override
  State<OnGoingElectionPage> createState() => _OnGoingElectionPageState();
}

class _OnGoingElectionPageState extends State<OnGoingElectionPage> {
  late final PageController pageController;
  late int activeIndex;

  // final candidateData candi_data = Get.put(candidateData());
  final electionData elec_data = Get.put(electionData());
  UserData userData = Get.put(UserData());
  //

  List<CandidateModel> candidatesList = [];
  List<CandidateModel> filterCandidatesList = [];
  List<ElectionModel> electionList = [];
  bool data = false;

  Future<void> fetchInfo() async {
    if (elec_data.electionList.isEmpty) {
      electionList = await ElectionDatabase().fetchAllElections();
      candidatesList = await CandidateDB().fetchAllCandidates();
    }
    setState(() {
      data = true;
    });
    setElection(1);
  }

  void setElection(int index) async {
    elec_data.setElectionTitle(electionList[index].electionName ?? "");
    elec_data.setElectionId(electionList[index].electionId ?? "");
    var orgID = electionList[index].orgId ?? "";
    await UserLocalData().setUserOrgID(orgID);
    setState(() {
      filterCandidatesList =
          CandidateDB().filterCandidatesByOrg(candidatesList, orgID);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchInfo();
    pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.84,
    );
    activeIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await fetchInfo(),
      child: data
          ? Column(
              children: [
                SizedBox(
                  height: Applayout.getheight(5),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      _buildCardsPageView(context),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: AnimatedSmoothIndicator(
                          activeIndex: activeIndex,
                          count: electionList.length,
                          effect: ExpandingDotsEffect(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Applayout.getheight(10),
                ),
                Text(
                  '${filterCandidatesList.length} Candidates',
                  style: GoogleFonts.inter(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),

                //// Candidates Section Avatars //
                Container(
                  margin: EdgeInsets.only(top: Applayout.getheight(10)),
                  width: double.infinity,
                  height: Applayout.getheight(180),
                  child: filterCandidatesList.isEmpty
                      ? Center(
                          child: Text('No Candidates found'),
                        )
                      : ListView.builder(
                          itemCount: filterCandidatesList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final candidate = filterCandidatesList[index];
                            return CandidateAvatar(
                              name: candidate.name,
                              imageUrl: candidate.imageUrl,
                            );
                          },
                        ),
                ),
                MyButton(
                  text: 'VOTE NOW',
                  width: 95.w,
                  onPress: () {
                    var title = elec_data.electionTitle;
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MyAlertDialogWidget(
                            title:
                                'Are you sure you want to vote for following election?',
                            content: Text(
                              '$title',
                              style: AppStyle().h3.copyWith(
                                    color: AppStyle.textClr,
                                  ),
                            ),
                            cancelBtnText: 'No',
                            confirmBtnText: 'Yes',
                            onConfirm: () {
                              Navigator.pop(context);

                              Get.to(
                                  () => VotingPage(
                                        candidatesList: filterCandidatesList,
                                      ),
                                  duration: const Duration(milliseconds: 500),
                                  transition: Transition.fadeIn);
                            },
                          );
                        });
                  },
                ),
                SizedBox(
                  height: Applayout.getheight(15),
                ),
              ],
            )
          : Padding(
              padding: EdgeInsets.only(top: 50),
              child: Loading(),
            ),
    );
  }

  Widget _buildCardsPageView(BuildContext context) {
    return SizedBox(
      height: 32.h,
      width: 100.w,
      child: PageView.builder(
        controller: pageController,
        itemCount: electionList.length,
        onPageChanged: (index) async {
          setState(() => activeIndex = index);
          setElection(activeIndex);
        },
        itemBuilder: (context, index) {
          final election = electionList[index];

          return AnimatedScale(
            scale: index == activeIndex ? 1.05 : 0.95,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: VoteCard(
              title: election.electionName ?? "Election Title",
              time: TimeService().votingTime(
                  election.startDate!.toDate(), election.endDate!.toDate()),
              description: election.description ??
                  "This election is essential for shaping the future direction and policies of our organization, ensuring that it continues to serve and meet the needs of our members effectively.",
            ),
          );
        },
      ),
    );
  }
}








// import 'package:card_swiper/card_swiper.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_voting/Controllers/candidate_control.dart';
// import 'package:e_voting/Controllers/election_control.dart';
// import 'package:e_voting/Providers/candidateData.dart';
// import 'package:e_voting/Models/user.dart';
// import 'package:e_voting/Providers/electionData.dart';
// import 'package:e_voting/Screens/Profile/candi_Profile.dart';
// import 'package:e_voting/Screens/Voting/vote.dart';
// import 'package:e_voting/Screens/Widgets/loading.dart';
// import 'package:e_voting/Screens/Widgets/myButton.dart';
// import 'package:e_voting/Screens/Widgets/candidateAvatar.dart';
// import 'package:e_voting/Screens/Widgets/Voting/voteCard.dart';
// import 'package:e_voting/Services/dateTime.dart';
// import 'package:e_voting/utils/Applayout.dart';
// import 'package:e_voting/utils/Appstyles.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class OnGoingElectionPage extends StatefulWidget {
//   @override
//   State<OnGoingElectionPage> createState() => _OnGoingElectionPageState();
// }

// class _OnGoingElectionPageState extends State<OnGoingElectionPage> {
//   late final Animation<Offset> slideAnimation;
//   late final PageController pageController;
//   late int activeIndex;

//   candidateData candi_data = Get.put(candidateData());
//   electionData elec_data = Get.put(electionData());
//   // //
//   List<Map<String, dynamic>> candidatesList = [];
//   List<Map<String, dynamic>> electionList = [];
// //
//   bool data = false;

//   Future<void> fetchInfo() async {
//     if (elec_data.electionList.isEmpty) {
//       await ElectionController().fetchElections();
//       await CandidateController().fetchCandidates();
//     }

//     setState(() {
//       electionList = elec_data.electionList
//           .map((element) => element as Map<String, dynamic>)
//           .toList();
//       candidatesList = candi_data.candidatesList
//           .map((item) => item as Map<String, dynamic>)
//           .toList();
//       data = true;
//     });
//     elec_data.setElectionTitle(electionList[0]['name'] ?? "");
//     elec_data.setElectionId(electionList[0]['elecId'] ?? "");
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchInfo();
//     pageController = PageController(
//       initialPage: 1,
//       viewportFraction: 0.85,
//     );
//     activeIndex = 1;
//     slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 1.5),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(
//         parent: widget.pageTransitionAnimation,
//         curve: Curves.easeOut,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: data
//           ? Column(
//               children: [
//                 SizedBox(
//                   height: Applayout.getheight(5),
//                 ),

//                 // Card Section //
//                 //By najam
//                 Container(
//                   padding: const EdgeInsets.only(bottom: 20),
//                   decoration: const BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(25),
//                       bottomRight: Radius.circular(25),
//                     ),
//                   ),
//                   clipBehavior: Clip.hardEdge,
//                   child: Column(
//                     children: [
//                       _buildCardsPageView(context),
//                       SlideTransition(
//                         position: slideAnimation,
//                         child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 30),
//                             child: AnimatedSmoothIndicator(
//                               activeIndex: activeIndex,
//                               count: electionList.length,
//                               effect: ExpandingDotsEffect(),
//                             )),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Card Section //
//                 //By Ali
//                 // Container(
//                 //     color: Colors.transparent,
//                 //     // width: 400,
//                 //     height: 30.h,
//                 //     child: Swiper(
//                 //         itemCount: electionList.length,
//                 //         loop: false,
//                 //         pagination: const SwiperPagination(
//                 //             alignment: Alignment.bottomCenter,
//                 //             margin: EdgeInsets.only(top: 20)),
//                 //         onIndexChanged: (index) {
//                 //           var elecId = electionList[index]['elecId'] ?? "";
//                 //           var title = electionList[index]['name'] ?? "";
//                 //           elec_data.setElectionTitle(title);
//                 //           elec_data.setElectionId(elecId);
//                 //         },
//                 //         itemBuilder: (BuildContext context, int index) {
//                 //           final election = electionList[index];
//                 //           var title = electionList[index]['name'] ?? "";
//                 //           return VoteCard(
//                 //             title: title,
//                 //             time: election['date'] ?? "",
//                 //             description:
//                 //                 election['description'] ?? "Network error",
//                 //           );
//                 //         })),

//                 SizedBox(
//                   height: Applayout.getheight(10),
//                 ),

//                 /// Candidates Section //

//                 Text(
//                   '${candidatesList.length} Candidate',
//                   style: GoogleFonts.inter(
//                       fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 // Candidates List>>>>>>
//                 Container(
//                     margin: EdgeInsets.only(top: Applayout.getheight(25)),
//                     // padding: EdgeInsets.symmetric(horizontal: 10),
//                     //color: Colors.amber,
//                     width: double.infinity,
//                     height: Applayout.getheight(200),
//                     child: ListView.builder(
//                         itemCount: candidatesList.length,
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () {
//                               Get.to(
//                                   () => CandidateProfile(
//                                         name: candidatesList[index]['name'],
//                                         description: candidatesList[index]
//                                             ['description'],
//                                       ),
//                                   transition: Transition.fadeIn);
//                             },
//                             child: CandidateAvatar(
//                               name: candidatesList[index]['name'],
//                               image: 'assets/images/profile.jpg',
//                             ),
//                           );
//                         })),
//                 MyButton(
//                   text: 'VOTE NOW',
//                   width: 95.w,
//                   onPress: () {
//                     Get.to(() => VotingPage(), transition: Transition.fade);
//                   },
//                 ),
//                 SizedBox(
//                   height: Applayout.getheight(15),
//                 ),
//               ],
//             )
//           : const Padding(
//               padding: EdgeInsets.only(top: 50),
//               child: Center(
//                   child: CircularProgressIndicator(
//                 color: AppStyle.textClr,
//               )),
//             ),
//     );
//   }

//   Widget _buildCardsPageView(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final cardWidth = screenSize.width - 16 * 2;
//     return SizedBox(
//       height: 40.h,
//       child: PageView.builder(
//         controller: pageController,
//         itemCount: electionList.length,
//         onPageChanged: (index) {
//           setState(() => activeIndex = index);
//           var elecId = electionList[index]['elecId'] ?? "";
//           var title = electionList[index]['name'] ?? "";
//           elec_data.setElectionTitle(title);
//           elec_data.setElectionId(elecId);
//         },
//         itemBuilder: (context, index) {
//           final election = electionList[index];
//           var title = electionList[index]['name'] ?? "";

//           return AnimatedScale(
//             scale: index == activeIndex ? 1 : 0.85,
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//             child: HeroMode(
//               enabled: index == activeIndex,
//               child: Hero(
//                 tag: 'card_${electionList[index]['elecid']}',
//                 child: VoteCard(
//                   title: title,
//                   time: election['date'] ?? "",
//                   description: election['description'] ?? "Network error",
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
