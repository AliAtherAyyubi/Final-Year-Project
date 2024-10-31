import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
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
      final ref = storage.ref('profile_images/${image.name}');
      await ref.putFile(imagePath);
      // Get download URL
      downloadURL = await ref.getDownloadURL();
      // if (imageUrl == null) {

      // } else {
      //   downloadURL = await updateImage(image, imageUrl);
      // }

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

    final file = File(image!.path);
    if (image != null) {
      File? compressedImage = await compressImage(file);
      return XFile(compressedImage!.path);
    }
    MyAlert.showToast(0, 'No Image selected');
    return null;
  }

  Future<XFile?> pickGalleryImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    final file = File(image!.path);
    if (image != null) {
      File? compressedImage = await compressImage(file);
      return XFile(compressedImage!.path);
    }
    MyAlert.showToast(0, 'No Image selected');

    return null;
  }

  ///
  Future<File?> compressImage(File imageFile,
      {int quality = 80, int maxWidth = 600}) async {
    try {
      // Read the image as bytes
      Uint8List imageBytes = await imageFile.readAsBytes();

      // Decode the image
      img.Image? image = img.decodeImage(imageBytes);

      if (image == null) return null;

      // Resize the image to the maxWidth while maintaining the aspect ratio
      img.Image resizedImage = img.copyResize(image, width: maxWidth);

      // Compress the image to the given quality
      List<int> compressedImageBytes =
          img.encodeJpg(resizedImage, quality: quality);

      // Save the compressed image as a new file
      File compressedFile =
          await File(imageFile.path).writeAsBytes(compressedImageBytes);

      return compressedFile;
    } catch (e) {
      print("Error compressing image: $e");
      return null;
    }
  }

  ///
  String convertToBase64(File imageFile) {
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    return base64Image;
  }
}
