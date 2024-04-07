import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Services/user_db.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  FirebaseFirestore db = FirebaseFirestore.instance;

  UserModel user = UserModel();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> RegisterUser(
      String name, String cnic, String email, String password) async {
    try {
      // UserCredential authResult = await _auth.createUserWithEmailAndPassword(
      //     email: email, password: password);

      final userdata = <String, dynamic>{
        "Username": name,
        "cnic": cnic,
        'email': email,
        'password': password
      };

// Add a new document with a generated ID
      db.collection("users").add(userdata).then((DocumentReference doc) =>
          print('DocumentSnapshot added with ID: ${doc.id}'));

      // userDatabase().CreateUserById(user);

      print('Registered Successfully');
      return user;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
