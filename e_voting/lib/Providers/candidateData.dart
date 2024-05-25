import 'package:get/get.dart';

class candidateData extends GetxController {
  var candidatesList = [].obs;

  var candidateId = ''.obs;
  var candidateName = ''.obs;
  var candidateImage = ''.obs;

  void setCandidateId(id) {
    candidateId.value = id;
  }

  void setCandidateName(name) {
    candidateName.value = name;
  }

  void setCandidates(List<Map<String, dynamic>> candidates) {
    candidatesList.value = candidates;
  }
}
