import 'package:get/get.dart';

class candidateData extends GetxController {
  var candidatesList = [].obs;

  void setCandidates(List<Map<String, dynamic>> candidates) {
    candidatesList.value = candidates;
  }
}
