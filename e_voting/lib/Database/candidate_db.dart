import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Models/candidate.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';

class CandidateDB {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createCandidate(CandidateModel c) async {
    try {
      c.adminId = await UserLocalData().getUserId();
      //
      await firestore.collection('candidate').add({
        // 'candidateId': c.candidateId,
        'name': c.name,
        'imageUrl': c.imageUrl,
        'biography': c.biography,
        'publicDesc': c.publicDescription,
        'adminId': c.adminId,
        'elecId': c.elecId,
        'description': c.description,
        'voteCount': 0,
        'links': c.links
      });

      // await docRef.update({'candidateId': docRef.id});
      MyAlert.showToast(1, 'Added Successfully!');
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Error adding candidate');
    }
  }

  Future<void> updateCandidateById(CandidateModel c) async {
    try {
      await firestore.collection('candidate').doc(c.candidateId).update({
        'elecId': c.elecId,
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

  //
  Future<void> deleteCandidateByID(String id) async {
    try {
      await firestore.collection('candidate').doc(id).delete();
      MyAlert.showToast(1, 'Deleted Successfully!');
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'System Error');
    }
  }

  ///
  ///  Fetch Candiates by Org of Owner //
  Future<List<CandidateModel>> fetchCandidatesByAdmin() async {
    List<CandidateModel> candidatesList = [];
    try {
      var adminId = await UserLocalData().getUserId();

      ///
      QuerySnapshot querySnapshot = await firestore
          .collection('candidate')
          .where('adminId', isEqualTo: adminId)
          .get();

      var docs = querySnapshot.docs;
      //
      if (docs.isNotEmpty) {
        for (int i = 0; i < docs.length; i++) {
          candidatesList.add(CandidateModel(
            candidateId: docs[i].id,
            adminId: docs[i].get('adminId'),
            elecId: docs[i].get('elecId'),
            name: docs[i].get('name'),
            imageUrl: docs[i].get('imageUrl'),
            biography: docs[i].get('biography'),
            publicDescription: docs[i].get('publicDesc'),
            description: docs[i].get('description'),
            // voteCount: docs[i].get('voteCount'),
            links: docs[i].get('links'),
          ));
        }
        return candidatesList;
      }
      //
      return candidatesList;
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Network Error');
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
          await firestore.collection('candidate').get();

      var docs = querySnapshot.docs;
      //
      for (var i = 0; i < docs.length; i++) {
        candidatesList.add(CandidateModel(
          candidateId: docs[i].id,
          adminId: docs[i].get('adminId'),
          elecId: docs[i].get('elecId'),
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
      MyAlert.showToast(0, 'System Error');
    } catch (e) {
      print('error: $e');
    }
    return candidatesList;
  }

  List<CandidateModel> filterCandidates(
      List<CandidateModel> candidatesList, String elecID) {
    List<CandidateModel> filterCandidatesList = [];

    filterCandidatesList =
        candidatesList.where((element) => element.elecId == elecID).toList();
    /////
    // MyAlert.showToast(1, '${candidatesList[2].elecId.toString()}');

    return filterCandidatesList;
  }

  // Fetch Eelction by ID //

  Future<CandidateModel?> fetchCandidateById(String id) async {
    try {
      DocumentSnapshot doc =
          await firestore.collection('candidate').doc(id).get();

      return CandidateModel(
        candidateId: doc['candidateId'],
        adminId: doc['adminId'],
        name: doc['name'],
        imageUrl: doc['imageUrl'],
        biography: doc['biography'],
        publicDescription: doc['publicDesc'],
        description: doc['description'],
        links: doc['links'],
        // voteCount: doc['voteCount']
      );
    } on FirebaseException catch (e) {
      print('Error while fetching Election details');
      return null;
    }
  }
  // set User id when Candidate create his account //

  // Future<void> setUserId(String cnic, String uid) async {
  //   try {
  //     QuerySnapshot querySnapshot = await firestore
  //         .collection('candidate')
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
