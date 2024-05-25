import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Database/user_db.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Providers/candidateData.dart';
import 'package:get/get.dart';

class CandidateController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserModel user = UserModel();
  candidateData candi_data = Get.put(candidateData());
  // function //
  Future<void> fetchCandidates() async {
    List<Map<String, dynamic>> candidatesList = [];

    QuerySnapshot querySnapshot = await firestore.collection('candidate').get();
    //
    if (querySnapshot.docs.isNotEmpty) {
      //
      // for loop // for adding data //
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        var uid = querySnapshot.docs[i].get('userId');
        user = await userDatabase().getUserById(uid);
        //
        Map<String, dynamic> candidateInfo = {
          'id': querySnapshot.docs[i].id,
          'name': user.userName.toString().capitalize ?? "",
          'description': querySnapshot.docs[i].get('description') ?? "",
          'links': querySnapshot.docs[i].get('links') ?? "",
          'votes': querySnapshot.docs[i].get('voteCount') ?? "",
          // Add more fields as needed
        };
        candidatesList.add(candidateInfo);
      }
      candi_data.setCandidates(candidatesList);
      // return candidatesList;
    } else
      print('no Candidates exist');
  }
}
