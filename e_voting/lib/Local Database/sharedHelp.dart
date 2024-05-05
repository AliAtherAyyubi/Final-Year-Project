import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  Future<SharedPreferences> initializer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  String convertJsonToString(Map<String, dynamic> jsonData) {
    return json.encode(jsonData);
  }

// Convert string from SharedPreferences back to JSON
  Map<String, dynamic> convertStringToJson(String jsonString) {
    return json.decode(jsonString);
  }
}
