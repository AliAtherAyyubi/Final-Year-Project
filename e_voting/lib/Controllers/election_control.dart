import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Controllers/org_controller.dart';
import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Providers/electionData.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:e_voting/Services/dateTime.dart';
import 'package:get/get.dart';

class ElectionController {
  ElectionModel e = ElectionModel();
  electionData elec_data = Get.put(electionData());
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // create election //
  Future<void> createElection(
    name,
    sdate,
    edate,
    detail,
  ) async {
    String? orgId = await OrgDatabase().GetOrgId();
    e.electionName = name;
    e.startDate = TimeService().convertToTimestamp(sdate);
    e.endDate = TimeService().convertToTimestamp(edate);
    e.description = detail;
    e.orgId = orgId;
    await ElectionDatabase().electionDB(e);
    // bool exist = OrgController().isOrgExist();
    // print(exist);
    // if (orgId != null) {

    // } else {
    //   MyAlert.showToast(0, 'First create organization');
    // }
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
          'elecId': doc[i].id,
          'name': doc[i].get('name').toString().capitalize,
          'description': doc[i].get('description'),
          'date': TimeService().votingTime(i, querySnapshot),
          // Add more fields as needed
        };
        electionList.add(electionInfo);
      }
      elec_data.setElections(electionList);
    } else {
      print('Elections are empty');
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
