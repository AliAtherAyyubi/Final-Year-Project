import 'package:e_voting/Database/user_db.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ImageController {
  FirebaseStorage storage = FirebaseStorage.instance;

  // CRUD //
  Future<void> updateUserImage(String value) async {
    await userDatabase().updateUser('imageUrl', value);
  }

  //    Uploading User/Admin/Candidate image//
  Future<void> uploadImage(filename, image) async {
    try {
      // Upload image to Firebase Storage
      final ref = storage.ref('profile_images/$filename');
      await ref.putData(image);

      // Get download URL
      final String downloadURL = await ref.getDownloadURL();

      // Store download URL in Firestore
      updateUserImage(downloadURL);

      // Show success message or navigate to next screen
      print('Uploaded Image');
    } catch (error) {
      // Handle error
      print('Error uploading image: $error');
    }
  }

  //    Fetching User/Admin/Candidate image//
  Future<String> fetchImage() async {
    String uid = Get.put(UserData()).userID.toString();
    // Get download URL
    UserModel user = await userDatabase().getUserById(uid);

    return user.imageUrl!;
  }

  // to get from gallery and upload //
  Future<void> getImage() async {
    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      final file = result.files.first;

      // Check if the selected file is an image
      if (file.extension != 'jpg' &&
          file.extension != 'jpeg' &&
          file.extension != 'png' &&
          file.extension != 'gif') {
        print('Please select an image file.');
        return;
      }
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;
      // var fileName = 'user';
      uploadImage(fileName, fileBytes);
    } else {
      print('Please Select image only');
    }
  }
}
