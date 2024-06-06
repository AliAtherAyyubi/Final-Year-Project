import 'dart:io';

import 'package:e_voting/Database/user_db.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

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
      // Store download URL in Firestore
      await updateUserImage(downloadURL);
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

  // Storing Image Locally //
  Future<void> downloadAndSaveImage(String imageUrl) async {
    // final response = await storage.refFromURL(imageUrl).getDownloadURL();
    final imageResponse = await HttpClient().getUrl(Uri.parse(imageUrl));
    final imageFile = File(
        '${(await getTemporaryDirectory()).path}/${path.basename(imageUrl)}');
    final downloadedImage = await imageResponse.close();
    await imageFile.writeAsBytes(downloadedImage as List<int>);
  }

  Future<File> getLocalImageFile(String imageUrl) async {
    final imageName = path.basename(imageUrl);
    final localImagePath = '${(await getTemporaryDirectory()).path}/$imageName';
    final localImageFile = File(localImagePath);
    print(localImageFile.path);
    return localImageFile;
  }
}
