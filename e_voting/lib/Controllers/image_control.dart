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

  ////
  Future<String?> uploadImage(XFile image, String? imageUrl) async {
    try {
      final imagePath = File(image.path);
      String? downloadURL;
      //
      if (imageUrl == null) {
        final ref = storage.ref('profile_images/${image.name}');
        await ref.putFile(imagePath);
        // Get download URL
        downloadURL = await ref.getDownloadURL();
      } else {
        downloadURL = await updateImage(image, imageUrl);
      }

      //
      MyAlert.showToast(1, 'Uploaded image successfully!');
      return downloadURL;
    } on FirebaseException catch (error) {
      // Handle error
      MyAlert.showToast(0, 'System or Network error');

      return 'System Error';
    }
  }

//
  Future<String?> updateImage(XFile image, imageUrl) async {
    try {
      // Pick an image
      final imagePath = File(image.path);

      // Get a reference to the existing image
      Reference storageReference = storage.refFromURL(imageUrl);

      // Upload the new image to the same reference (this will overwrite the existing image)
      await storageReference.putFile(imagePath);

      // Get the new download URL (optional)
      String newImageUrl = await storageReference.getDownloadURL();

      return newImageUrl;
    } catch (e) {
      MyAlert.showToast(0, 'System Error');
    }
  }

  //    Fetching User/Admin/Candidate image//
  Future<void> deleteImageByURL(String imageUrl) async {
    try {
      Reference ref = storage.refFromURL(imageUrl);

      await ref.delete();
    } catch (e) {
      MyAlert.showToast(0, 'System Error');
    }
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
