import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:e_voting/Database/candidate_db.dart';
import 'package:e_voting/Models/candidate.dart';
import 'package:e_voting/Screens/Owner/Candidates/add.dart';
import 'package:e_voting/Screens/Owner/Candidates/edit.dart';
import 'package:e_voting/Screens/Widgets/alertDialog.dart';
import 'package:e_voting/Screens/Widgets/empty.dart';
import 'package:e_voting/Screens/Widgets/loading.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CandidateScreen extends StatefulWidget {
  const CandidateScreen({super.key});

  @override
  State<CandidateScreen> createState() => _CandidateScreenState();
}

class _CandidateScreenState extends State<CandidateScreen> {
  List<CandidateModel> candidateList = [];
  bool data = false;
  //
  Future<void> fetchCandidates() async {
    candidateList = await CandidateDB().fetchCandidatesByOrg();
    //
    setState(() {
      data = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCandidates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: ScreenTitle(
            title: '',
          )),
      //
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.to(() => AddCandidateScreen(),
              transition: Transition.rightToLeft);
        },
        child: Icon(Icons.add),
        backgroundColor: AppStyle.primaryColor,
      ),
      //
      body: RefreshIndicator(
        onRefresh: () => fetchCandidates(),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Your Candidates',
              style: AppStyle().h2,
            ),
            SizedBox(
              height: 20,
            ),
            //
            data
                ? candidateList.isEmpty
                    ? EmptyImage()
                    : SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                            itemCount: candidateList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              // final election = electionData!.docs[index];
                              final candidate = candidateList[index];
                              return Dismissible(
                                key: Key(candidate.candidateId!),
                                onDismissed: (direction) async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return MyAlertDialogWidget(
                                          title:
                                              'Are you sure you want to delete this candidate?',
                                          cancelBtnText: 'No',
                                          confirmBtnText: 'Yes',
                                          onConfirm: () async {
                                            await CandidateDB()
                                                .deleteCandidateByID(
                                                    candidate.candidateId!);
                                            await fetchCandidates();
                                          },
                                        );
                                      });
                                },
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                                child: CandidateTile(
                                    name: candidate.name,
                                    imageUrl: candidate.imageUrl,
                                    bio: candidate.biography,
                                    onPress: () {
                                      Get.to(
                                          () => EditCandidateScreen(
                                                candidate: candidate,
                                              ),
                                          transition: Transition.rightToLeft);
                                    }),
                              );
                            }),
                      )
                : Loading()
          ],
        ),
      ),
    );
  }
}

class CandidateTile extends StatelessWidget {
  String? name;
  String? imageUrl;
  String? bio;
  final Function()? onPress;
  CandidateTile({super.key, this.name, this.imageUrl, this.bio, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 5),
      child: ListTile(
        enableFeedback: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: CircularProfileAvatar(
          imageUrl ??
              "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
          radius: 25,
        ),
        title: Text(
          '$name',
          style: AppStyle().h3.copyWith(color: Colors.black, fontSize: 18),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            '${bio!.split(' ').take(4).toList().join(' ')}...',
            style: AppStyle().txt3.copyWith(color: Colors.grey.shade600),
          ),
        ),
        trailing: IconButton(
          onPressed: onPress,
          icon: Icon(Icons.arrow_forward),
          iconSize: 30,
          color: AppStyle.iconClr,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        tileColor: Color(0xFF97FBC6),
      ),
    );
  }
}
