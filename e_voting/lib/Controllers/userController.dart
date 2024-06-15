import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Database/owner_db.dart';
import 'package:e_voting/Local%20Database/adminData.dart';
import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Models/organization.dart';
import 'package:e_voting/Models/owner.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Database/user_db.dart';
import 'package:e_voting/Screens/Auth/login.dart';
import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Owner/ownerScreen.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:e_voting/Services/Internet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel user = UserModel();
  OrgModel orgModel = OrgModel();

  // Getx States Manager //
  UserData userState = Get.put(UserData());

  /// Registration of User into Database //
  Future<void> RegisterUser(
    String name,
    String cnic,
    String role,
    String email,
    String password,
  ) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      user.userId = authResult.user!.uid;
      user.userName = name;
      user.cnic = cnic;
      user.email = email;
      user.role = role;
      //
      await userDatabase().createUserById(user);

      // creating Owner if user is Owner///
      if (role.toLowerCase() == 'owner') {
        OwnerModel ownerModel = OwnerModel();
        ownerModel.userID = user.userId;
        await OwnerDatabase().createOwner(ownerModel);
      }
      // Meanwhile Sign in //
      //
      MyAlert.showToast(1, 'Your account is created successfully!');
      await sendVerificationEmail(_auth);

      Get.to(() => LoginPage(), transition: Transition.rightToLeft);
      /////
    } on FirebaseAuthException catch (e) {
      // Catch FirebaseAuthException to handle specific errors
      if (e.code == 'email-already-in-use') {
        MyAlert.showToast(0, 'Email already exist');
      } else {
        MyAlert.showToast(0, 'System or Network Error');
      }
    }
  }

  Future<void> sendVerificationEmail(FirebaseAuth auth) async {
    try {
      await auth.currentUser!.sendEmailVerification();
      MyAlert.showToast(
          1, 'An Email is sent to your address! Verify it and then Log in');
    } on FirebaseAuthException catch (e) {
      MyAlert.showToast(0, 'System Error');
    }
  }
  // Sign in Function //w

  Future<void> Signin(String email, String password) async {
    try {
      bool checkInternet = await Internet().checkInternetConnection();
      if (checkInternet) {
        UserCredential credential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        // Checking Crdentials //
        if (credential.user != null && credential.user!.emailVerified) {
          user = await userDatabase().getUserById(credential.user!.uid);

          await UserLocalData().setLocalUser(user);
          // // Set User ID //
          userState.setUserId(credential.user!.uid);

          //
          bool isAdmin = await UserLocalData().isOwner();
          if (isAdmin) {
            orgModel = await OrgDatabase().fetchOrgById();
            if (orgModel.orgId != null) {
              await AdminLocalData().setLocalOrg(orgModel);
            }
          }
          // MyAlert.Alert('Success', 'Signed in successfully!');
          Get.off(() => isAdmin ? OwnerMainScreen() : Dashboard(),
              transition: Transition.rightToLeft);

          // MyAlert.showToast(1, 'Email Verified!');
        } else {
          MyAlert.showToast(0, 'Your email is not verified!');
        }
      }
    } on FirebaseAuthException catch (e) {
      MyAlert.showToast(0, 'Invalid Username and Password!');
      print('Error signing in firebase: $e');
    } catch (e) {
      MyAlert.showToast(0, 'System Error');
      print('Error signing in: $e');
    }
  }
  // Log out //

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await UserLocalData().removeUser();
      await AdminLocalData().removeOrg();
      userState.dispose;
      // Get.find<candidateData>().dispose();
      print('User signed out successfully ');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

// Function to change the user's password
  Future<void> updateUserPassword(String newPassword) async {
    try {
      // Get the current user
      User? user = _auth.currentUser;
      // Change the user's password
      await user!.updatePassword(newPassword);
      MyAlert.showToast(1, 'Updated Successfully!');

      // Password changed successfully
    } catch (e) {
      // Error changing password
      MyAlert.showToast(0, 'System or Network error');
    }
  }

// Function to send a password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      // Check if the email address is associated with an existing account
      final isUserExist = await userDatabase().checkUserbyEmail(email);

      if (isUserExist) {
        // Send the password reset email
        await _auth.sendPasswordResetEmail(email: email);

        // Password reset email sent successfully
        MyAlert.showToast(1, "Email sent to your email address");
        Future.delayed(Duration(seconds: 3), () {
          Get.to(() => LoginPage());
        });
      } else {
        MyAlert.showToast(
            0, "This email didn\'t exist. Enter email correctly!");
      }
    } on FirebaseException catch (e) {
      // Error sending password reset email
      MyAlert.showToast(0, 'System or Network Error');
    }
  }

  //
  // To update user //

  Future<void> updateUserEmail(String value) async {
    User user = _auth.currentUser!;
    await user.updateEmail(value);

    await user.sendEmailVerification();
    // await userDatabase().updateUser('email', value);
  }
}
