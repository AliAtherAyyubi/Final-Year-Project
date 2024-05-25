import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Screens/Owner/Owner%20Elections/editElection.dart';
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
  QuerySnapshot? electionData;
  bool data = false;
  //
  Future<void> fetchElections() async {
    QuerySnapshot? querySnapshot =
        await ElectionDatabase().fetchElectionByOrg();
    setState(() {
      electionData = querySnapshot;
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
      body: ListView(
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
              ? ListView.builder(
                  itemCount: electionData!.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    final election = electionData!.docs[index];
                    return ElectionTile(
                      title: election.get('name'),
                      date: TimeService().displayDate(index, electionData!),
                      onPress: () => Get.to(
                          () => EditElections(electionId: election.id),
                          transition: Transition.rightToLeft),
                    );
                  })
              : Loading(
                  color: Colors.green,
                )
        ],
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
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
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
      ),
    );
  }
}
