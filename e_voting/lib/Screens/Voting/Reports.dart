import 'package:e_voting/Database/Reports.dart';
import 'package:e_voting/Database/candidate_db.dart';
import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Models/candidate.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Screens/Widgets/candidateAvatar.dart';
import 'package:e_voting/Screens/Widgets/empty.dart';
import 'package:e_voting/Screens/Widgets/loading.dart';
import 'package:e_voting/Services/dateTime.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

///
class ElectionResultPage extends StatefulWidget {
  const ElectionResultPage({super.key});

  @override
  State<ElectionResultPage> createState() => _ElectionResultPageState();
}

class _ElectionResultPageState extends State<ElectionResultPage> {
  //
  // int NoOfVote = 0;
  int TotalVote = 1;
  int winnerIndex = 0;
  String winnerCandidate = "Not Decided Yet";
  String elecDuration = "";
  bool isElecEnd = false;

  //
  List<CandidateModel> candidatesList = [];
  List<CandidateModel> filterCandidatesList = [];
  List<ElectionModel> electionList = [];
  List<String> electionTitleList = [];
  List<int> NoOfVoteList = [];
  bool data = false;

  Future<void> fetchInfo() async {
    electionList = await ElectionDatabase().fetchAllElections();
    candidatesList = await CandidateDB().fetchAllCandidates();
    //
    for (var titles in electionList) {
      electionTitleList.add(titles.electionName!.capitalize ?? "Election");
    }
    setState(() {
      data = true;
    });
  }

  Future<void> setElection(String selectedElection) async {
    setState(() {
      data = false;
    });
    //
    var index = electionTitleList.indexOf(selectedElection);
    DateTime start = electionList[index].startDate!.toDate();
    DateTime end = electionList[index].endDate!.toDate();

    // to filter candidates
    if (index != -1) {
      var elecID = electionList[index].electionId ?? "";
      setState(() {
        filterCandidatesList =
            CandidateDB().filterCandidates(candidatesList, elecID);
        NoOfVoteList.clear();
      });
    }
    await getNoOfVotes(index);
    setState(() {
      elecDuration = TimeService().votingTime(start, end);

      isElecEnd = DateTime.now().isAfter(end);
      data = true;
    });
  }

  Future<void> getNoOfVotes(int index) async {
    //
    int TotalCount = 0;
    for (var candidate in filterCandidatesList) {
      int voteCount = await ReportsDatabase()
          .getCandidateVotes(candidate.candidateId ?? "");
      // MyAlert.showToast(1, 'Candidate Count: ${vote}');

      NoOfVoteList.add(voteCount);
      TotalCount += voteCount;
    }

    if (NoOfVoteList.isNotEmpty) {
      winnerIndex = ReportsDatabase().getWinner(NoOfVoteList);
      winnerCandidate = TotalCount < 10
          ? 'Deciding...'
          : filterCandidatesList[winnerIndex].name ?? "Deciding...";
    }
    setState(() {
      TotalVote = TotalCount;
      // NoOfVoteList = voteList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchInfo();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            'Election Result',
            style: AppStyle().h2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              'Choose an election to see result',
              style: AppStyle().h3.copyWith(color: Colors.black),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: ElectionDropdown(
              electionList: electionTitleList,
              onElectionSelected: (selectedElection) async {
                // Handle the selected election arnd show results
                await setElection(selectedElection);
                // print("Selected Election: $selectedElection");
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),

          //

          data
              ? Container(
                  margin: EdgeInsets.only(top: Applayout.getheight(5)),
                  // width: 90.w,
                  child: Column(
                    children: [
                      Text(
                        '$elecDuration',
                        style: AppStyle().txt1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      filterCandidatesList.isNotEmpty
                          ? Center(
                              child: Text(
                                'Total Votes Cast: $TotalVote',
                                style:
                                    AppStyle().h3.copyWith(color: Colors.black),
                              ),
                            )
                          : Container(),
                      isElecEnd
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Winner: ',
                                  style: AppStyle()
                                      .h2
                                      .copyWith(color: Colors.black),
                                ),
                                Text(
                                  winnerCandidate,
                                  style: AppStyle().h2,
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 20,
                      ),
                      filterCandidatesList.isEmpty
                          ? EmptyImage()
                          : ListView.builder(
                              itemCount: filterCandidatesList.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                final candidate = filterCandidatesList[index];
                                bool isBorder =
                                    winnerIndex == index ? true : false;
                                return VoteDataCard(
                                  name: candidate.name,
                                  imageUrl: candidate.imageUrl,
                                  NoOfVote: NoOfVoteList[index],
                                  TotalVotes: TotalVote,
                                  border: isBorder,
                                );
                              },
                            ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              : Loading(),
          SizedBox(
            height: 100,
          )
          //
        ],
      ),
    );
  }
}

//
class VoteDataCard extends StatelessWidget {
  //
  String? name;
  String? imageUrl;
  int NoOfVote;
  int TotalVotes;
  bool border;
  // String? Votekey;
  VoteDataCard(
      {this.name,
      this.imageUrl,
      this.border = false,
      required this.NoOfVote,
      required this.TotalVotes});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 150,
      width: 100.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: border ? Border.all(color: Colors.green, width: 3) : null),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CandidateAvatar(
                imageUrl: imageUrl,
                radius: 40,
                name: name!,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60.w,
                    child: LinearProgressIndicator(
                      // key: Key(Votekey!),
                      value: NoOfVote / (TotalVotes == 0 ? 1 : TotalVotes),
                      color: AppStyle.primaryColor,
                      borderRadius: BorderRadius.circular(50),
                      backgroundColor: Colors.grey[300],
                      minHeight: 15,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Vote: $NoOfVote ${border ? '(Leading)' : ""}',
                    style: AppStyle.textStyle1.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
///
///
class ElectionDropdown extends StatefulWidget {
  final List<String> electionList;
  final ValueChanged<String> onElectionSelected;

  ElectionDropdown(
      {required this.electionList, required this.onElectionSelected});

  @override
  _ElectionDropdownState createState() => _ElectionDropdownState();
}

class _ElectionDropdownState extends State<ElectionDropdown> {
  String? _selectedElection;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(20),
          hint: Text("Select Election"),
          style: AppStyle().txt1,
          value: _selectedElection,
          onChanged: (newValue) {
            setState(() {
              _selectedElection = newValue;
            });
            widget.onElectionSelected(newValue!);
          },
          items: widget.electionList.map((String election) {
            return DropdownMenuItem<String>(
              value: election,
              child: Text(election),
            );
          }).toList(),
        ),
      ),
    );
  }
}
