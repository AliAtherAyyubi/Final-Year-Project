import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Controllers/org_controller.dart';
import 'package:e_voting/Controllers/userController.dart';
import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Models/organization.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OrgDatabase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserLocalData user = UserLocalData();
  Future<void> createOrgDB(OrgModel org) async {
    try {
      String? checkOrg = await GetOrgId();

      if (checkOrg == null) {
        // Retrieve the orgId from the first matching document
        await firestore.collection('organization').add({
          'name': org.orgName,
          'address': org.address,
          'description': org.description,
          'adminId': org.adminId
        });
        MyAlert.showToast(1, 'Saved Successfully');
        print('Added Organization');
      } else {
        // No documents found with the provided adminId
        MyAlert.showToast(0, 'Your Organization is already registered!');

        print('You can only create one organization at one time only!');
      }
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'System or Network error');

      print('Error from firebase,${e.toString()}');
    }
  }

  Future<String?> GetOrgId() async {
    try {
      var adminid = await UserController().getUserID();
      print('adminId: ${adminid}');

      QuerySnapshot querySnapshot = await firestore
          .collection('organization')
          .where('adminId', isEqualTo: adminid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Retrieve the orgId from the first matching document
        String orgId = querySnapshot.docs.first.id;
        return orgId;
      }
      return null;
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'System or Network error');

      return null;
    } catch (e) {
      print('Error');
      return null;
    }
  }
  // Fetch Organization //

  Future<OrgModel?> fetchOrgById() async {
    try {
      var orgid = await GetOrgId();
      DocumentSnapshot doc =
          await firestore.collection('organization').doc(orgid).get();

      return OrgModel(
          orgName: doc['name'],
          address: doc['address'],
          description: doc['description']);
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Something went wrong!');

      print('Error while fetching organization details');
      return null;
    } catch (e) {
      print('Error');
      return null;
    }
  }
  // Update Organization //

  Future<void> updateOrg(name, address, desc) async {
    try {
      var orgid = await GetOrgId();

      await firestore.collection('organization').doc(orgid).update({
        'name': name,
        'address': address,
        'description': desc,
        // 'adminId': org.adminId
      });
      MyAlert.showToast(1, 'Updated Successfully');
      print('updated Organization');
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Something went wrong!');

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
