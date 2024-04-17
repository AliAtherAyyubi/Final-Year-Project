import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Models/election.dart';

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
        'status': e.status,
        'orgId': e.orgId,
      });

      await docRef.update({'electionId': docRef.id});
      print('added election');
    } on FirebaseException catch (e) {
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
      print('Error while fetching Election details');
      return null;
    }
  }
}
