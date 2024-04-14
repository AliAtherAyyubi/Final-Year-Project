import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Database/user_db.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UserController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel user = UserModel();

  // Getx States Manager //
  UserData userState = Get.put(UserData());

  /// Registration of User into Database //
  Future<String?> RegisterUser(BuildContext context, String name, String cnic,
      String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (authResult.user != null) {
        user.userId = authResult.user!.uid;
        user.userName = name;
        user.cnic = cnic;
        user.email = email;
        // user.password = password;
        // user.accountCreated = Timestamp.now();
        userDatabase().CreateUserById(user);
        // Meanwhile Sign in //
        print('Registered Successfully');
        await Signin(context, email, password);

        return null;
      }

// Add a new document with a generated ID
      // await db.collection("users").add(userdata).then((DocumentReference doc) =>
      //     print('DocumentSnapshot added with ID: ${doc.id}'));
      // return user;
    } on FirebaseAuthException catch (e) {
      // Catch FirebaseAuthException to handle specific errors
      if (e.code == 'email-already-in-use') {
        // Email is already in use, handle this case
        return 'Email already exist'; // Return error message
      } else {
        // Handle other FirebaseAuthException errors
        print('Error: ${e.message}');
        return 'Error: ${e.message}'; // Return error message
      }
    }
  }

  // Sign in Function //

  Future<String?> Signin(
      BuildContext? context, String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Checking Crdentials //
      if (credential.user != null) {
        user = await userDatabase().getUserById(credential.user!.uid);
        //

        userState.setname(user.userName);
        // Set User ID //
        userState.setUserId(credential.user!.uid);

        // await db.collection('users').doc(credential.user!.uid).get().then(
        //   (DocumentSnapshot doc) {
        //     final data = doc.data() as Map<String, dynamic>;
        //     print(data);
        //   },
        //   onError: (e) => print("Error getting document: $e"),
        // );

        return 'Signed in successfully';
      }
      return null;
    } on FirebaseAuthException catch (e) {
      print('${e.toString()}');
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // Log out //

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      if (_auth.currentUser == null) print('User signed out successfully ');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  // to Delete accounts of all users //

// Future<void> deleteAllUserAccounts() async {
//   try {
//     // Get a list of all users
//     await user1.delete();

//     // Delete each user

//     print('user accounts deleted successfully.');
//   } catch (error) {
//     print('Failed to delete user accounts: $error');
//   }
// }
}
