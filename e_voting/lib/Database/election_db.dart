import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Local%20Database/electionData.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:get/get.dart';

class ElectionDatabase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> electionDB(ElectionModel e) async {
    try {
      DocumentReference docRef = await firestore.collection('election').add({
        // 'electionId': e.electionId,
        'name': e.electionName,
        'startDate': e.startDate,
        'endDate': e.endDate,
        'description': e.description,
        // 'status': e.status,
        'orgId': e.orgId,
      });

      await docRef.update({'electionId': docRef.id});
      e.electionId = docRef.id;
      // await ElectionLocalData().addLocalElection(e);
      MyAlert.showToast(1, 'Added Successfully!');
      print('added election');
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Network Error');

      print('error :$e');
    }
  }
  // Fetch Eelction by ID //

  Future<ElectionModel?> fetchElectionById(String id) async {
    try {
      DocumentSnapshot doc =
          await firestore.collection('election').doc(id).get();

      return ElectionModel(
          electionName: doc['name'],
          description: doc['description'],
          electionId: doc['electionId'],
          orgId: doc['orgId'],
          startDate: doc['startDate'],
          endDate: doc['endDate'],
          status: doc['status']);
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'System error ');
    }
  }
// Fetch Eelction by Org ID //

  Future<List<ElectionModel>> fetchElectionByOrg() async {
    List<ElectionModel> electionList = [];

    try {
      var orgID = await OrgDatabase().GetOrgId();
      QuerySnapshot querySnapshot = await firestore
          .collection('election')
          .where('orgId', isEqualTo: orgID)
          .get();

      var docs = querySnapshot.docs;

      if (docs.isNotEmpty) {
        for (var doc in docs) {
          electionList.add(ElectionModel(
            electionId: doc.id,
            orgId: doc.get('orgId'),
            electionName: doc.get('name'),
            description: doc.get('description'),
            startDate: doc.get('startDate'),
            endDate: doc.get('endDate'),
          ));
        }
      }

      return electionList;
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Something went wrong');
    }
    return electionList;
  }

  //

  Future<List<ElectionModel>> fetchAllElections() async {
    List<ElectionModel> electionList = [];
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('election').get();

      var docs = querySnapshot.docs;

      if (docs.isNotEmpty) {
        for (var doc in docs) {
          electionList.add(ElectionModel(
            electionId: doc.id,
            orgId: doc.get('orgId'),
            electionName: doc.get('name'),
            description: doc.get('description'),
            startDate: doc.get('startDate'),
            endDate: doc.get('endDate'),
          ));
        }
      }

      //
      // await LocalElectionData().setAllElections(querySnapshot);
      //
      return electionList;
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'System error ');
    }
    return electionList;
  }
  // Update Elections //

  Future<void> updateElectionByID(ElectionModel election) async {
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
      //
      MyAlert.showToast(1, 'Updated Successfully');
      print('updated Election');
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'System Error');
    }
  }

  // Delete Election //

  Future<void> deleteElectionByID(String id) async {
    try {
      await firestore.collection('election').doc(id).delete();
      MyAlert.showToast(1, 'Deleted Successfully');
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'System or Network Erro');
    }
  }
}
