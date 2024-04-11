import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserData extends ChangeNotifier {
  var username = 'user name';
  var userID = "";
  void setname(String n) {
    username = n;
    notifyListeners();
  }

  //set User ID //
  void setUserId(String id) {
    userID = id;
    print('UserID: $userID');
    notifyListeners();
  }
}
