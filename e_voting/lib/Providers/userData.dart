import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  String username = 'user name';

  void setname(String n) {
    username = n;
    print(username);
    notifyListeners();
  }
}
