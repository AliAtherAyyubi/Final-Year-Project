import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Database/user_db.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
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
  Future<String?> RegisterUser(
      String name, String cnic, String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // checking user is verified or not //
      if (authResult.user != null) {
        user.userId = authResult.user!.uid;
        user.userName = name;
        user.cnic = cnic;
        user.email = email;
        //
        userDatabase().createUserById(user);
        // Meanwhile Sign in //
        print('Registered Successfully');
        await Signin(email, password);
        return null;
      }
    } on FirebaseAuthException catch (e) {
      // Catch FirebaseAuthException to handle specific errors
      if (e.code == 'email-already-in-use') {
        // Email is already in use, handle this case
        print('Email is not valid');
        return 'Email already exist'; // Return error message
      } else {
        // Handle other FirebaseAuthException errors
        print('Email is not valid');
        return 'Error: ${e.message}'; // Return error message
      }
    }
  }

  // Sign in Function //

  Future<String?> Signin(String email, String password) async {
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

        return 'Signed in successfully';
      }
      return null;
    } on FirebaseAuthException catch (e) {
      print('System Error: ${e.toString()}');
      return null;
    } catch (e) {
      print('System or Network Error');
      return null;
    }
  }
  // Log out //

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print('User signed out successfully ');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  // To update user //

  Future<void> updateUserName(String value) async {
    await userDatabase().updateUser('username', value);
    userState.setname(value);
  }

  Future<void> updateUserCnic(String value) async {
    await userDatabase().updateUser('cnic', value);
  }

  Future<void> updateUserEmail(String value) async {
    User user = _auth.currentUser!;
    await user.updateEmail(value);

    await user.sendEmailVerification();
    // await userDatabase().updateUser('email', value);
  }

  Future<void> updateUserPassword(String value) async {
    await _auth.currentUser!.updatePassword(value);
  }

  Future<void> updateUserImage(String value) async {
    await userDatabase().updateUser('imageUrl', value);
  }

  Future<void> updateUserPhone(String value) async {
    await userDatabase().updateUser('phone', value);
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
