import 'dart:io';

import 'package:e_voting/Database/user_db.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController {
  FirebaseStorage storage = FirebaseStorage.instance;
  UserData user = Get.put(UserData());
  // CRUD //
  Future<void> updateUserImage(String value) async {
    await userDatabase().updateUser('imageUrl', value);
  }

  //    Uploading User/Admin/Candidate image to Firebase Storage>//
  Future<String?> uploadUserImage(filename, image) async {
    try {
      final ref = storage.ref('profile_images/$filename');
      await ref.putFile(image);
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

//    Uploading User/Admin/Candidate image to Firebase Storage>//
  Future<String?> uploadCandidateImage(XFile image) async {
    try {
      final imagePath = File(image.path);
      //
      final ref = storage.ref('profile_images/${image.name}');
      await ref.putFile(imagePath);
      // Get download URL
      final String downloadURL = await ref.getDownloadURL();
      // Show success message or navigate to next screen
      return downloadURL;
    } on FirebaseException catch (error) {
      // Handle error
      MyAlert.showToast(0, 'System error');
      print('Error uploading image: $error');
      return null;
    } catch (e) {
      MyAlert.showToast(0, 'System error');
      return null;
    }
  }

  //    Fetching User/Admin/Candidate image//
  Future<String> fetchImage() async {
    String uid = Get.put(UserData()).userID.toString();
    // Get download URL
    UserModel user = await userDatabase().getUserById(uid);
    return user.imageUrl!;
  }

  Future<XFile?> pickCameraImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image != null) {
      return image;
    }
    MyAlert.showToast(0, 'No Image selected');
    return null;
  }

  Future<XFile?> pickGalleryImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      return image;
    }
    MyAlert.showToast(0, 'No Image selected');

    return null;
  }
  // // Storing Image Locally //
  // Future<void> downloadAndSaveImage(String imageUrl) async {
  //   // final response = await storage.refFromURL(imageUrl).getDownloadURL();
  //   final imageResponse = await HttpClient().getUrl(Uri.parse(imageUrl));
  //   final imageFile = File(
  //       '${(await getTemporaryDirectory()).path}/${path.basename(imageUrl)}');
  //   final downloadedImage = await imageResponse.close();
  //   await imageFile.writeAsBytes(downloadedImage as List<int>);
  // }

  // Future<File> getLocalImageFile(String imageUrl) async {
  //   final imageName = path.basename(imageUrl);
  //   final localImagePath = '${(await getTemporaryDirectory()).path}/$imageName';
  //   final localImageFile = File(localImagePath);
  //   print(localImageFile.path);
  //   return localImageFile;
  // }
}
