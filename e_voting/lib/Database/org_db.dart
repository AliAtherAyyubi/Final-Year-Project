import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Models/organization.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OrgDatabase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createOrgDB(OrgModel org) async {
    try {
      DocumentReference docRef = await firestore
          .collection('organization')
          .add({
        'name': org.orgName,
        'description': org.description,
        'adminId': org.adminId
      });

      await docRef.update({'orgId': docRef.id});

      print('Added Organization');
    } on FirebaseException catch (e) {
      print('Error from firebase,${e.toString()}');
    }
  }

  Future<String?> GetOrgId() async {
    try {
      String adminid = Get.put(UserData()).userID.toString();

      QuerySnapshot querySnapshot = await firestore
          .collection('organization')
          .where('adminId', isEqualTo: adminid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Retrieve the orgId from the first matching document
        String orgId = querySnapshot.docs.first.get('orgId');
        return orgId;
      } else {
        // No documents found with the provided adminId
        print('No organization found');
        return null;
      }
      // print('${id}');
    } on FirebaseException catch (e) {
      print('Error:${e.toString()}');
      return e.toString();
    } catch (e) {
      print('Error');
    }
  }
}
