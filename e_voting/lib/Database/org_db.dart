import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Controllers/org_controller.dart';
import 'package:e_voting/Controllers/userController.dart';
import 'package:e_voting/Database/owner_db.dart';
import 'package:e_voting/Local%20Database/adminData.dart';
import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Models/organization.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OrgDatabase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserLocalData user = UserLocalData();
  AdminLocalData admin = AdminLocalData();
  OrgModel orgModel = OrgModel();
  //
  Future<void> createOrgDB(OrgModel org) async {
    try {
      String? isOrg = await GetOrgId();
      if (isOrg == null) {
        // Retrieve the orgId from the first matching document
        DocumentReference docRef =
            await firestore.collection('organization').add({
          'name': org.orgName,
          'address': org.address,
          'description': org.description,
          'adminId': org.adminId
        });
        docRef.update({'orgId': docRef.id});

        ///
        await OwnerDatabase().setOwnerOrgID(org.adminId.toString(), docRef.id);
        //
        await admin.setLocalOrg(org);
        MyAlert.showToast(1, 'Saved Successfully');
      } else {
        // No documents found with the provided adminId
        MyAlert.showToast(0, 'Your Organization is already registered!');
      }
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'System or Network error');
    }
  }

  Future<String?> GetOrgId() async {
    try {
      var adminid = await UserLocalData().getUserId();

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

  Future<OrgModel> fetchOrgById() async {
    try {
      var orgid = await GetOrgId();
      DocumentSnapshot doc =
          await firestore.collection('organization').doc(orgid).get();
      if (doc.exists) {
        return OrgModel(
            orgName: doc['name'],
            address: doc['address'],
            description: doc['description'],
            adminId: doc['adminId'],
            orgId: doc['orgId']);
      }
      return orgModel;
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Something went wrong!');
      return orgModel;
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
      OrgModel org = await admin.fetchLocalOrg();
      org.orgName = name;
      org.address = address;
      org.description = desc;
      await admin.setLocalOrg(org);
      MyAlert.showToast(1, 'Updated Successfully');
    } on FirebaseException catch (e) {
      MyAlert.showToast(0, 'Something went wrong!');
    }catch(e){
      MyAlert.showToast(0, 'Something went wrong!');

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
