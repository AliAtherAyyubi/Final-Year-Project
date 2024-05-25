import 'package:get/get.dart';

class electionData extends GetxController {
  var electionList = [].obs;

  var electionId = "".obs;
  var electionTitle = "Election Title".obs;
  //
  void setElectionId(id) {
    electionId.value = id;
  }

  //
  void setElectionTitle(title) {
    electionTitle.value = title;
  }

//
  void setElections(List<Map<String, dynamic>> elections) {
    electionList.value = elections;
  }
}
