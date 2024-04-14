import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Models/user.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class userDatabase {
  // MyUser user = MyUser();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> CreateUserById(UserModel user) async {
    firestore.collection('users').doc(user.userId).set({
      'userId': user.userId,
      'username': user.userName!.toLowerCase(),
      'cnic': user.cnic,
      'email': user.email,
      // 'password': user.password,
      'imageUrl': user.imageUrl,
      'phone': user.phone,
      'role': user.role
      // 'accountCreated': user.accountCreated,
    });
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
}
