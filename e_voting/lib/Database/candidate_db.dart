import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Models/candidate.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';

class CandidateDB {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createCandidate(CandidateModel c) async {
    try {
      c.orgId = await OrgDatabase().GetOrgId();
      DocumentReference docRef = await firestore.collection('Candidates').add({
        'candidateId': c.candidateId,
        'name': c.name,
        'imageUrl': c.imageUrl,
        'biography': c.biography,
        'publicDesc': c.publicDescription,
        'orgId': c.orgId,
        'description': c.description,
        'voteCount': 0,
        'links': c.links
      });

      await docRef.update({'candidateId': docRef.id});
      MyAlert.showToast(1, 'Added Successfully!');
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Error adding candidate');

      print('error :$e');
    }
  }

  Future<void> updateCandidateById(CandidateModel c) async {
    try {
      await firestore.collection('Candidates').doc(c.candidateId).update({
        'name': c.name,
        'imageUrl': c.imageUrl,
        'biography': c.biography,
        'publicDesc': c.publicDescription,
        'description': c.description,
        'links': c.links,
        'voteCount': c.voteCount,
      });
      MyAlert.showToast(1, 'Updated Successfully!');
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Error updating candidate');
    }
  }
  // Fetch Eelction by ID //

  Future<CandidateModel?> fetchCandidateById(String id) async {
    try {
      DocumentSnapshot doc =
          await firestore.collection('Candidates').doc(id).get();

      return CandidateModel(
          candidateId: doc['candidateId'],
          orgId: doc['orgId'],
          name: doc['name'],
          imageUrl: doc['imageUrl'],
          biography: doc['biography'],
          publicDescription: doc['publicDesc'],
          description: doc['description'],
          links: doc['links'],
          voteCount: doc['voteCount']);
    } on FirebaseException catch (e) {
      print('Error while fetching Election details');
      return null;
    }
  }

  //
  Future<void> deleteCandidateByID(String id) async {
    try {
      await firestore.collection('Candidates').doc(id).delete();
      MyAlert.showToast(1, 'Deleted Successfully!');
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'System Error');
    }
  }

  ///
  ///  Fetch Candiates by Org of Owner //
  Future<List<CandidateModel>> fetchCandidatesByOrg() async {
    List<CandidateModel> candidatesList = [];
    try {
      var orgID = await OrgDatabase().GetOrgId();

      ///
      QuerySnapshot querySnapshot = await firestore
          .collection('Candidates')
          .where('orgId', isEqualTo: orgID)
          .get();

      var docs = querySnapshot.docs;
      //
      if (docs.isNotEmpty) {
        for (int i = 0; i < docs.length; i++) {
          candidatesList.add(CandidateModel(
            candidateId: docs[i].id,
            orgId: docs[i].get('orgId'),
            name: docs[i].get('name'),
            imageUrl: docs[i].get('imageUrl'),
            biography: docs[i].get('biography'),
            publicDescription: docs[i].get('publicDesc'),
            description: docs[i].get('description'),
            voteCount: docs[i].get('voteCount'),
            links: docs[i].get('links'),
          ));
        }
        return candidatesList;
      }
      //
      return candidatesList;
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Network Error');

      print('Error while fetching Election details $e');
    } catch (e) {
      print('error: $e');
    }
    return candidatesList;
  }

  //////
  ////
  Future<List<CandidateModel>> fetchAllCandidates() async {
    List<CandidateModel> candidatesList = [];

    try {
      ///
      QuerySnapshot querySnapshot =
          await firestore.collection('Candidates').get();

      var docs = querySnapshot.docs;
      //
      for (var i = 0; i < docs.length; i++) {
        candidatesList.add(CandidateModel(
          candidateId: docs[i].id,
          orgId: docs[i].get('orgId'),
          name: docs[i].get('name'),
          imageUrl: docs[i].get('imageUrl'),
          biography: docs[i].get('biography'),
          publicDescription: docs[i].get('publicDesc'),
          description: docs[i].get('description'),
          voteCount: docs[i].get('voteCount'),
          links: docs[i].get('links'),
        ));
      }
      //
      return candidatesList;
    } on FirebaseException catch (e) {
      print('Error while fetching Election details $e');
    } catch (e) {
      print('error: $e');
    }
    return candidatesList;
  }

  List<CandidateModel> filterCandidatesByOrg(
      List<CandidateModel> candidatesList, String OrgId) {
    List<CandidateModel> filterCandidatesList = [];

    filterCandidatesList =
        candidatesList.where((element) => element.orgId == OrgId).toList();

    return filterCandidatesList;
  }
  // set User id when Candidate create his account //

  // Future<void> setUserId(String cnic, String uid) async {
  //   try {
  //     QuerySnapshot querySnapshot = await firestore
  //         .collection('Candidates')
  //         .where('cnic', isEqualTo: cnic)
  //         .get();

  //     if (querySnapshot.docs.isNotEmpty) {
  //       String candidateId = querySnapshot.docs.first.id;
  //       await firestore
  //           .collection('candidate')
  //           .doc(candidateId)
  //           .update({'userId': uid});
  //       print('Set UserId into Candidate Table');
  //     } else {
  //       print('Your are not a Candidate, you are voter');
  //     }
  //   } on FirebaseException catch (e) {
  //     print('error :$e');
  //   }
  // }
}
