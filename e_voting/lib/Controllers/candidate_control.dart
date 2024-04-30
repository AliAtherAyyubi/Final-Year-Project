import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Database/user_db.dart';
import 'package:e_voting/Models/user.dart';

class CandidateController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot?> fetchCandidates() async {
    QuerySnapshot querySnapshot = await firestore.collection('candidate').get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot;
    } else
      print('no Candidates exist');
    return null;
  }
}
