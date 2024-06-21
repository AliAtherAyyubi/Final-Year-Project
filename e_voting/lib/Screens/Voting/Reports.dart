import 'package:e_voting/Database/Reports.dart';
import 'package:e_voting/Database/candidate_db.dart';
import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Models/candidate.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Screens/Widgets/candidateAvatar.dart';
import 'package:e_voting/Screens/Widgets/loading.dart';
import 'package:e_voting/Screens/Widgets/myAvatar.dart';
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
  int NoOfVote = 0;
  int TotalVote = 1;
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
    var index = electionTitleList.indexOf(selectedElection);
    if (index != -1) {
      var orgID = electionList[index].orgId ?? "";
      await UserLocalData().setUserOrgID(orgID);
      setState(() {
        filterCandidatesList =
            CandidateDB().filterCandidatesByOrg(candidatesList, orgID);
      });
    }
    await getNoOfVotes(index);
  }

  Future<void> getNoOfVotes(int index) async {
    setState(() {
      data = false;
    });
    var id = electionList[index].electionId!;
    TotalVote = await ReportsDatabase().getElectionTotalVotes(id);
    for (var candidate in filterCandidatesList) {
      int vote = await ReportsDatabase()
          .getCandidateVotes(candidate.candidateId ?? "");

      NoOfVoteList.add(vote);
    }
    setState(() {
      data = true;
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
                  margin: EdgeInsets.only(top: Applayout.getheight(10)),
                  width: 90.w,
                  child: filterCandidatesList.isEmpty
                      ? const Center(
                          child: Text('No Result Found'),
                        )
                      : ListView.builder(
                          itemCount: filterCandidatesList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final candidate = filterCandidatesList[index];
                            return VoteData(
                              name: candidate.name,
                              imageUrl: candidate.imageUrl,
                              NoOfVote: NoOfVoteList[index],
                              TotalVotes: TotalVote,
                            );
                          },
                        ),
                )
              : Loading(),
        ],
      ),
    );
  }
}

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

//
class VoteData extends StatelessWidget {
  //
  String? name;
  String? imageUrl;
  int NoOfVote;
  int TotalVotes;
  VoteData(
      {super.key,
      this.name,
      this.imageUrl,
      this.NoOfVote = 0,
      this.TotalVotes = 1});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 120,
        width: 100.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CandidateAvatar(
              imageUrl: imageUrl,
              radius: 30,
              name: name,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60.w,
                  child: LinearProgressIndicator(
                    value: NoOfVote / TotalVotes,
                    color: AppStyle.primaryColor,
                    borderRadius: BorderRadius.circular(50),
                    backgroundColor: Colors.grey[300],
                    minHeight: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'No of Vote: $NoOfVote',
                  style: AppStyle.textStyle1.copyWith(color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
