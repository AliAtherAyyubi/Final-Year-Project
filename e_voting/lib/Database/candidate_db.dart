import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Models/candidate.dart';

class CandidateDB {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createCandidate(CandidateModel c) async {
    try {
      DocumentReference docRef = await firestore.collection('candidate').add({
        'candidateId': c.candidateId,
        'userId': c.userId,
        // 'electionId': c.electionId,
        'orgId': c.orgId,
        'cnic': c.cnic,
        'description': c.description,
        'voteCount': null,
        'links': c.links
      });

      await docRef.update({'candidateId': docRef.id});

      print('added Candidate');
    } on FirebaseException catch (e) {
      print('error :$e');
    }
  }

  Future<void> updateCandidateById(CandidateModel c) async {
    try {
      await firestore.collection('candidate').doc(c.candidateId).update({
        'cnic': c.cnic,
        'description': c.description,
        'voteCount': c.voteCount,
        'links': c.links
      });

      print('Update Candidate');
    } on FirebaseException catch (e) {
      print('error :$e');
    }
  }
  // Fetch Eelction by ID //

  Future<CandidateModel?> fetchCandidateById(String id) async {
    try {
      DocumentSnapshot doc =
          await firestore.collection('candidate').doc(id).get();

      return CandidateModel(
        candidateId: doc['candidateId'],
        userId: doc['userId'],
        orgId: doc['orgId'],
        // electionId: doc['electionId'],
        description: doc['description'],
        voteCount: doc['voteCount'],
        links: doc['links'],
      );
    } on FirebaseException catch (e) {
      print('Error while fetching Election details');
      return null;
    }
  }

  // set User id when Candidate create his account //

  Future<void> setUserId(String cnic, String uid) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('candidate')
          .where('cnic', isEqualTo: cnic)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String candidateId = querySnapshot.docs.first.id;
        await firestore
            .collection('candidate')
            .doc(candidateId)
            .update({'userId': uid});
        print('Set UserId into Candidate Table');
      } else {
        print('Your are not a Candidate, you are voter');
      }
    } on FirebaseException catch (e) {
      print('error :$e');
    }
  }
}
