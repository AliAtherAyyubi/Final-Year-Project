import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Models/user.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class userDatabase {
  // MyUser user = MyUser();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> CreateUserById(UserModel user) async {
    firestore.collection('users').doc(user.userId).set({
      'id': user.userId,
      'username': user.userName,
      'cnic': user.cnic,
      'email': user.email,
      'password': user.password,
      'imageUrl': user.imageURL,
      'phone': user.phone,
      // 'accountCreated': user.accountCreated,
    });
  }

  // Future<MyUser> getUserById(String uid) async {
  //   DocumentSnapshot doc = await firestore.collection('users').doc(uid).get();
  //   return MyUser(
  //     uid: doc['id'],
  //     email: doc['email'],
  //     password: doc['password'],
  //     username: doc['username'],
  //     displayName: doc['displayName'],
  //     friendUid: doc['friendUid'],
  //     avatarUrl: doc['avatarUrl'],
  //     phone: doc['phone'],
  //     gender: doc['gender'],
  //     address: doc['address'],
  //     chatRoomId: doc['chatRoomId'],
  //     accountCreated: doc['accountCreated'],
  //   );
  // }
}
