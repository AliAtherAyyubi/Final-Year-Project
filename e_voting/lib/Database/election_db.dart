import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';

class ElectionDatabase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> electionDB(ElectionModel e) async {
    try {
      await firestore.collection('election').add({
        // 'electionId': e.electionId,
        'name': e.electionName,
        'position': e.position,
        'startDate': e.startDate,
        'endDate': e.endDate,
        'description': e.description,
        // 'status': e.status,
        'orgId': e.orgId,
        'adminId': e.adminId,
      });

      MyAlert.showToast(1, 'Added Successfully!');
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Network Error');
    }
  }

// Fetch Eelction by Org ID //

  Future<List<ElectionModel>> fetchElectionByAdmin() async {
    List<ElectionModel> electionList = [];

    try {
      var adminId = await UserLocalData().getUserId();

      ///
      QuerySnapshot querySnapshot = await firestore
          .collection('election')
          .where('adminId', isEqualTo: adminId)
          .get();

      var docs = querySnapshot.docs;

      if (docs.isNotEmpty) {
        for (var doc in docs) {
          electionList.add(ElectionModel(
            electionId: doc.id,
            orgId: doc.get('orgId'),
            adminId: doc.get('adminId'),
            electionName: doc.get('name'),
            position: doc.get('position'),
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
            adminId: doc.get('adminId'),
            electionName: doc.get('name'),
            position: doc.get('position'),
            description: doc.get('description'),
            startDate: doc.get('startDate'),
            endDate: doc.get('endDate'),
          ));
        }
      }
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
        'position': election.position,
        'description': election.description,
        'startDate': election.startDate,
        'endDate': election.endDate,
        // 'status': election.status
      });
      //
      MyAlert.showToast(1, 'Updated Successfully');
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
      MyAlert.showToast(0, 'System or Network Error');
    }
  }

  //
  Future<ElectionModel?> fetchElectionById(String id) async {
    try {
      DocumentSnapshot doc =
          await firestore.collection('election').doc(id).get();

      return ElectionModel(
          electionName: doc['name'],
          position: doc['position'],
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
}
