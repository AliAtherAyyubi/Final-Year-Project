import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Controllers/org_controller.dart';
import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Local%20Database/adminData.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Providers/electionData.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:e_voting/Services/dateTime.dart';
import 'package:get/get.dart';

class ElectionController {
  ////
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
    bool exist = await AdminLocalData().isOrgExist();
    if (exist) {
      String? orgId = await OrgDatabase().GetOrgId();
      e.electionName = name;
      e.startDate = TimeService().convertToTimestamp(sdate);
      e.endDate = TimeService().convertToTimestamp(edate);
      e.description = detail;
      e.orgId = orgId;
      await ElectionDatabase().electionDB(e);
    } else {
      MyAlert.showToast(0, 'First create organization');
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
