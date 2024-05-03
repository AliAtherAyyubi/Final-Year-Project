import 'package:get/get.dart';

class electionData extends GetxController {
  var electionList = [].obs;

  void setElections(List<Map<String, dynamic>> elections) {
    electionList.value = elections;
  }
}
