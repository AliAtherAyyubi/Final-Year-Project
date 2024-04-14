import 'package:get/get.dart';

class UserData extends GetxController {
  var username = 'user name'.obs;
  var userID = "".obs;
  void setname(n) {
    username.value = n.toString();
    print(username);
  }

  //set User ID //
  void setUserId(id) {
    userID.value = id.toString();
    print('UserID: $userID');
  }
}
