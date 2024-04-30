import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Models/organization.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OrgDatabase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createOrgDB(OrgModel org) async {
    try {
      String? checkOrg = await GetOrgId();

      if (checkOrg == null) {
        // Retrieve the orgId from the first matching document
        await firestore.collection('organization').add({
          'name': org.orgName,
          'description': org.description,
          'adminId': org.adminId
        });
        print('Added Organization');
      } else {
        // No documents found with the provided adminId
        print('You can only create one organization at one time only!');
      }
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
        String orgId = querySnapshot.docs.first.id;
        return orgId;
      } else {
        // No documents found with the provided adminId
        print('No organization found');
        return null;
      }
      // print('${id}');
    } on FirebaseException catch (e) {
      print('Error:${e.toString()}');
      return null;
    } catch (e) {
      print('Error');
      return null;
    }
  }
  // Fetch Organization //

  Future<OrgModel?> fetchOrg() async {
    try {
      var orgid = await GetOrgId();

      DocumentSnapshot doc =
          await firestore.collection('organization').doc(orgid).get();

      return OrgModel(
          orgName: doc['name'],
          description: doc['description'],
          adminId: doc['adminId']);
      // print('${id}');
    } on FirebaseException catch (e) {
      print('Error while fetching organization details');
      return null;
    } catch (e) {
      print('Error');
      return null;
    }
  }
  // Update Organization //

  Future<void> updateOrg(OrgModel org) async {
    try {
      var orgid = await GetOrgId();

      await firestore.collection('organization').doc(orgid).update({
        'name': org.orgName,
        'description': org.description,
        // 'adminId': org.adminId
      });

      print('updated Organization');
    } on FirebaseException catch (e) {
      print('Error from firebase cannot update');
    }
  }

  // Delete Organization //

  Future<void> deleteOrg() async {
    try {
      var orgid = await GetOrgId();

      await firestore.collection('organization').doc(orgid).delete();

      print('Deleted Organization');
    } on FirebaseException catch (e) {
      print('Error from firebase cannot update');
    }
  }
}
