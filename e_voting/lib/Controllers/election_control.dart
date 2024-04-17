import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Models/election.dart';

class ElectionController {
  ElectionModel e = ElectionModel();
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

  Future<QuerySnapshot> fetchElections() async {
    QuerySnapshot querySnapshot = await firestore.collection('election').get();
    // var len = querySnapshot.docs.length;
    // print('No of Elections:$len');
    // print(querySnapshot.docs[1].get('electionId'));
    // querySnapshot.docs.forEach((element) {
    //   print(element.data());
    //   print('\n');
    // });
    return querySnapshot;
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
