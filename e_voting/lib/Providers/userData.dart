import 'package:get/get.dart';

class UserData extends GetxController {
  var username = 'user name'.obs;
  var userID = "".obs;
  var userImage = "".obs;

  var orgId = ''.obs;

  void setOrgId(id) {
    print(id);
    username.value = id;
  }

  void setname(n) {
    username.value = n;
  }

  //set User ID //
  void setUserId(id) {
    userID.value = id;
    // print('UserID: $userID');
  }

  void setUserImage(image) {
    userImage.value = image;
    // print(userImage.value);
  }
}
