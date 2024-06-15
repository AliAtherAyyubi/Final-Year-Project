import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Database/user_db.dart';
import 'package:e_voting/Local%20Database/sharedHelp.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalData {
  // Store User Data locally using following function //

  SharedHelper helper = SharedHelper();

  Future<void> setLocalUser(UserModel user) async {
    var prefs = await helper.initializer();

    Map<String, dynamic> data = {
      'userId': user.userId,
      'username': user.userName,
      'cnic': user.cnic,
      'email': user.email,
      'imageUrl': user.imageUrl,
      'phone': user.phone,
      'role': user.role
    };

    //
    var userData = helper.convertJsonToString(data);
    // Store the converted data in SharedPreferences
    await prefs.setString('userData', userData);
  }

  // fetch user local data //

  Future<UserModel> fetchLocalUser() async {
    var prefs = await helper.initializer();

    String data = prefs.getString('userData')!;

    Map<String, dynamic> doc = helper.convertStringToJson(data);

    return UserModel(
        userId: doc['userId'],
        cnic: doc['cnic'],
        email: doc['email'],
        // password: doc['password'],
        userName: doc['username'],
        imageUrl: doc['imageUrl'],
        phone: doc['phone'],
        role: doc['role']
        // accountCreated: doc['accountCreated'],
        );
  }

  Future<void> removeUser() async {
    SharedPreferences prefs = await helper.initializer();
    // Check if user data exists in SharedPreferences
    await prefs.remove('userData');
    print('User Removed from local  DB');
  }

  Future<bool> checkUserLoggedIn() async {
    SharedPreferences prefs = await helper.initializer();
    // Check if user data exists in SharedPreferences
    bool isUser = prefs.containsKey('userData');
    return isUser;
  }

  Future<bool> isOwner() async {
    UserModel user = UserModel();
    user = await UserLocalData().fetchLocalUser();
    if (user.role!.toLowerCase() == 'owner') return true;
    return false;
  }

  Future<void> setUserId() async {
    UserModel user = await fetchLocalUser();
    String id = user.userId.toString();
    //
    Get.put(UserData()).setUserId(id);
  }

  Future<String> getUserId() async {
    UserModel user = await fetchLocalUser();
    String id = user.userId.toString();
    //
    return id;
  }

  Future<void> setUserOrgID(String orgID) async {
    SharedPreferences prefs = await helper.initializer();

    await prefs.setString('UserOrgID', orgID);
  }

  Future<String> getUserOrgID() async {
    SharedPreferences prefs = await helper.initializer();

    String OrgID = prefs.getString('UserOrgID') ?? "";
    print('User ORG ID: $OrgID');
    return OrgID;
  }
}
