import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Local%20Database/electionData.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Screens/Owner/Owner%20Elections/addElection.dart';
import 'package:e_voting/Screens/Owner/Owner%20Elections/editElection.dart';
import 'package:e_voting/Screens/Widgets/alertDialog.dart';
import 'package:e_voting/Screens/Widgets/empty.dart';
import 'package:e_voting/Screens/Widgets/loading.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Services/dateTime.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerElectionList extends StatefulWidget {
  const OwnerElectionList({super.key});

  @override
  State<OwnerElectionList> createState() => Owner_ElectionListState();
}

class Owner_ElectionListState extends State<OwnerElectionList> {
  // QuerySnapshot? electionData;
  List<ElectionModel> electionList = [];
  bool data = false;
  //
  Future<void> fetchElections() async {
    electionList = await ElectionDatabase().fetchElectionByOrg();
    setState(() {
      // electionData = querySnapshot;
      data = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchElections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: ScreenTitle(
            title: '',
          )),
      //
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.to(() => OwnerElection(), transition: Transition.rightToLeft);
        },
        child: Icon(Icons.add),
        backgroundColor: AppStyle.primaryColor,
      ),
      //
      body: RefreshIndicator(
        onRefresh: () => fetchElections(),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Your Elections',
              style: AppStyle().h2,
            ),
            SizedBox(
              height: 20,
            ),
            //
            data
                ? electionList.isEmpty
                    ? EmptyImage()
                    : ListView.builder(
                        itemCount: electionList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          // final election = electionData!.docs[index];
                          final e = electionList[index];
                          return Dismissible(
                            key: Key(e.electionId!),
                            confirmDismiss: (direction) async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) {
                                  return MyAlertDialogWidget(
                                    title:
                                        'Are you sure you want to delete this election?',
                                    cancelBtnText: 'No',
                                    confirmBtnText: 'Yes',
                                    onConfirm: () =>
                                        Navigator.of(context).pop(true),
                                    onCancel: () =>
                                        Navigator.of(context).pop(false),
                                  );
                                },
                              );
                              return confirm ?? false;
                            },
                            onDismissed: (direction) async {
                              await ElectionDatabase()
                                  .deleteElectionByID(e.electionId!);
                              await fetchElections();
                            },
                            direction: DismissDirection.endToStart,
                            background: Container(
                              margin: EdgeInsets.only(bottom: 5),
                              // alignment: Alignment.centerRight,
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
                            child: ElectionTile(
                              title: e.electionName,
                              date: TimeService().votingTime(
                                  e.startDate!.toDate(), e.endDate!.toDate()),
                              onPress: () => Get.to(
                                  () => EditElections(electionModel: e),
                                  transition: Transition.rightToLeft),
                            ),
                          );
                        })
                : Loading(
                    color: AppStyle.iconClr,
                  )
          ],
        ),
      ),
    );
  }
}

class ElectionTile extends StatelessWidget {
  String? title;
  String? date;
  final Function()? onPress;
  ElectionTile({super.key, this.title, this.date, this.onPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${title}',
        style: AppStyle().h3.copyWith(color: Colors.black),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          '$date',
          style: AppStyle().txt2.copyWith(color: Colors.grey.shade600),
        ),
      ),
      trailing: IconButton(
        onPressed: onPress,
        icon: Icon(Icons.arrow_forward),
        iconSize: 30,
        color: AppStyle.iconClr,
      ),
      contentPadding: EdgeInsets.all(10),
      tileColor: Colors.grey.shade200,
    );
  }
}
