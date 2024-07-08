import 'package:e_voting/Controllers/election_control.dart';
import 'package:e_voting/Database/candidate_db.dart';
import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Local%20Database/electionData.dart';
import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Models/candidate.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Providers/electionData.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Voting/vote.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
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
  late DateTime endDate;

  // final candidateData candi_data = Get.put(candidateData());
  final electionData elec_data = Get.put(electionData());
  UserData userData = Get.put(UserData());
  //

  List<CandidateModel> candidatesList = [];
  List<CandidateModel> filterCandidatesList = [];
  List<ElectionModel> electionList = [];
  bool data = false;

  Future<void> fetchData() async {
    // setState(() {
    //   data = false;
    // });
    electionList = await ElectionDatabase().fetchAllElections();
    candidatesList = await CandidateDB().fetchAllCandidates();

    ///

    setElection(1);
  }

  void setElection(int index) async {
    elec_data.setElectionTitle(electionList[index].electionName ?? "");
    elec_data.setElectionId(electionList[index].electionId ?? "");
    //
    // var orgID = electionList[index].orgId ?? "";
    var elecID = electionList[index].electionId ?? "";
    // await UserLocalData().setUserOrgID(orgID);
    //
    setState(() {
      endDate = electionList[index].endDate!.toDate();
      filterCandidatesList =
          CandidateDB().filterCandidates(candidatesList, elecID);

      //
      data = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.84,
    );
    activeIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return data
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
                child: candidatesList.isEmpty
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
                onPress: electionList.isEmpty
                    ? () {
                        MyAlert.showToast(0, 'No Election found');
                      }
                    : () {
                        if (DateTime.now().isAfter(endDate)) {
                          DialogMsg().showMsg(
                              context, 'Election deadline has passed.');
                        } else {
                          VoteNow();
                        }
                      },
              ),
              SizedBox(
                height: Applayout.getheight(20),
              ),
            ],
          )
        : Padding(
            padding: EdgeInsets.only(top: 50),
            child: Loading(),
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
          endDate = electionList[index].endDate!.toDate();
        },
        itemBuilder: (context, index) {
          final election = electionList[index];

          return AnimatedScale(
            scale: index == activeIndex ? 1.05 : 0.95,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: VoteCard(
              title: election.electionName ?? "Election Title",
              position: election.position ?? "",
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

////
  void VoteNow() {
    var title = elec_data.electionTitle;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyAlertDialogWidget(
            title: 'Are you sure you want to vote for following election?',
            content: Text(
              '$title',
              style:
                  AppStyle().h3.copyWith(color: AppStyle.textClr, fontSize: 25),
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
  }
}
