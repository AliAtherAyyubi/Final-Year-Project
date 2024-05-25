import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class userDatabase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserData data = Get.put(UserData());
  UserModel user = UserModel();

  ///
  Future<void> createUserById(UserModel user) async {
    firestore.collection('users').doc(user.userId).set({
      'userId': user.userId,
      'username': user.userName!.toLowerCase(),
      'cnic': user.cnic,
      'email': user.email,
      // 'password': user.password,
      'imageUrl': user.imageUrl,
      'phone': user.phone,
      'role': user.role!.toLowerCase()
      // 'accountCreated': user.accountCreated,
    });
  }

  // To update user info //

  Future<void> updateUser(String field, String value) async {
    String uid = data.userID.toString();
    DocumentReference docRef = firestore.collection('users').doc(uid);
    docRef.update({field: value}).then(
      (_) {
        print('Updated Successfully');
      },
    ).catchError((_) {
      print('Cannot updated');
    });
    user = await getUserById(uid);
    await UserLocalData().setLocalUser(user);
  }

  Future<UserModel> getUserById(String uid) async {
    DocumentSnapshot doc = await firestore.collection('users').doc(uid).get();
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

  Future<bool> checkUserbyEmail(String email) async {
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) return true;

    return false;
  }
}
