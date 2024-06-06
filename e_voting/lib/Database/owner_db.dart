import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Models/owner.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:get/get.dart';

class OwnerDatabase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserData user = Get.put(UserData());
  //
  Future<void> createOwner(OwnerModel owner) async {
    try {
      await firestore.collection('owner').add({
        'userID': owner.userID,
        'orgID': owner.orgID,
        'candidates': owner.candidates,
        'voters': owner.voters,
      });
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Error while creating Owner!');
    }
  }

  /// Voters Section ///////>>>>>>>>>>
  // Fetch Voters by ownerID or userID //

  Future<void> addVoter(String voterID) async {
    try {
      var id = await getOwnerID();
      await firestore.collection('owner').doc(id).update({
        'voters': FieldValue.arrayUnion([voterID])
      });
      MyAlert.showToast(1, 'Added Successfully');
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Error adding voter!');
    }
  }

  //
  Future<List?> fetchVoters() async {
    try {
      List voters;
      var id = await getOwnerID();
      DocumentSnapshot doc = await firestore.collection('owner').doc(id).get();

      if (doc.exists) {
        voters = doc['voters'];
        return voters;
      }
      return null;
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Error while fetching voters!');
      return null;
    }
  }

  ///
  Future<void> updateVoter(String oldVoterID, String newVoterID) async {
    try {
      var id = await getOwnerID();

      await firestore.collection('owner').doc(id).update({
        'voters': FieldValue.arrayRemove([oldVoterID])
      });
      await firestore.collection('owner').doc(id).update({
        'voters': FieldValue.arrayUnion([newVoterID])
      });
      MyAlert.showToast(1, 'Updated Successfully');
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Error updating voter!');
    }
  }

/////////////////////////////////
  Future<void> deleteVoter(String voterID) async {
    try {
      var id = await getOwnerID();

      await firestore.collection('owner').doc(id).update({
        'voters': FieldValue.arrayRemove([voterID])
      });
      MyAlert.showToast(1, 'Deleted Successfully');
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Error deleting voter!');
    }
  }

  ///
  Future<String?> getOwnerID() async {
    try {
      var id = user.userID.toString();

      QuerySnapshot querySnapshot = await firestore
          .collection('owner')
          .where('userID', isEqualTo: id)
          .get();

      String ownerID = querySnapshot.docs[0].id;
      return ownerID;
    } on FirebaseException catch (e) {
      print('Error while fetching OwnerID');
    }
  }
}
