import 'dart:io';

import 'package:e_voting/Database/user_db.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageController {
  FirebaseStorage storage = FirebaseStorage.instance;
  UserData user = Get.put(UserData());
  // CRUD //
  Future<void> updateUserImage(String value) async {
    await userDatabase().updateUser('imageUrl', value);
  }

  //    Uploading User/Admin/Candidate image//
  Future<String?> uploadImage(filename, image) async {
    try {
      final ref = storage.ref('profile_images/$filename');
      await ref.putFile(image);
      // print(image.lengthSync());
      // Get download URL
      final String downloadURL = await ref.getDownloadURL();
      user.setUserImage(downloadURL);
      // Store download URL in Firestore
      updateUserImage(downloadURL);

      // Show success message or navigate to next screen
      print('Uploaded Image');
      return null;
    } on FirebaseException catch (error) {
      // Handle error
      print('Error uploading image: $error');
      return 'System Error';
    }
  }

  //    Fetching User/Admin/Candidate image//
  Future<String> fetchImage() async {
    String uid = Get.put(UserData()).userID.toString();
    // Get download URL
    UserModel user = await userDatabase().getUserById(uid);
    return user.imageUrl!;
  }

  // Future<void> downloadImageToLocalFile(String url) async {
  //   final String fileName = 'user_profile_image.jpg';
  //   final Directory systemTempDir = await getTemporaryDirectory();
  //   final File tempFile = File('${systemTempDir.path}/$fileName');

  //   http.Response response = await http.get(url);
  //   await tempFile.writeAsBytes(response.bodyBytes);
  // }
}
