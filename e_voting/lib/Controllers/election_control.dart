import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Providers/electionData.dart';
import 'package:e_voting/Services/dateTime.dart';
import 'package:get/get.dart';

class ElectionController {
  ElectionModel e = ElectionModel();
  electionData elec_data = Get.put(electionData());
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // create election //
  Future<void> createElection(name, detail, st, sdate, edate) async {
    var orgid = await OrgDatabase().GetOrgId();

    e.electionName = name;
    e.description = detail;
    e.orgId = orgid;
    e.status = st;
    e.startDate = sdate;
    e.endDate = edate;

    ElectionDatabase().electionDB(e);
  }
  // Fetch Elections //

  Future<void> fetchElections() async {
    List<Map<String, dynamic>> electionList = [];

    QuerySnapshot querySnapshot = await firestore.collection('election').get();
    if (querySnapshot.docs.isNotEmpty) {
      var doc = querySnapshot.docs;
      // for looop
      for (var i = 0; i < doc.length; i++) {
        Map<String, dynamic> electionInfo = {
          'name': doc[i].get('name').toString().capitalize,
          'description': doc[i].get('description'),
          'date': TimeService().displayDate(i, querySnapshot),
          // Add more fields as needed
        };
        electionList.add(electionInfo);
      }
      elec_data.setElections(electionList);
    } else {
      print('Elections are empty');
    }
  }
  // Update Organization //

  Future<void> updateElection(ElectionModel election) async {
    try {
      var elecId = election.electionId;

      await firestore.collection('election').doc(elecId).update({
        'name': election.electionName,
        'description': election.description,
        'startDate': election.startDate,
        'endDate': election.endDate,
        'status': election.status
        // 'adminId': org.adminId
      });

      print('updated Election');
    } on FirebaseException catch (e) {
      print('Error from firebase cannot update');
    }
  }

  // // Delete Organization //

  Future<void> deleteElection(String id) async {
    try {
      await firestore.collection('election').doc(id).delete();

      print('Deleted Election Doc');
    } on FirebaseException catch (e) {
      print('Error from firebase cannot update');
    }
  }
}
