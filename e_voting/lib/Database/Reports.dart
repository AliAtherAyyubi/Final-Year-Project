import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';

class ReportsDatabase {
  //
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  Future<int> getElectionTotalVotes(String elecID) async {
    try {
      AggregateQuery TotalVotes = firestore
          .collection('vote')
          .where('electionId', isEqualTo: elecID)
          .count();

      AggregateQuerySnapshot snapshot = await TotalVotes.get();
      int? count = snapshot.count == 0 ? 1 : snapshot.count;
      // MyAlert.showToast(1, 'Count: ${count}');
      return count ?? 1;
      //
    } catch (e) {
      MyAlert.showToast(0, 'Error while fetching');
    }
    return 1;
  }

  ////////
  Future<int> getCandidateVotes(String candID) async {
    try {
      AggregateQuery TotalVotes = firestore
          .collection('vote')
          .where('candidateId', isEqualTo: candID)
          .count();

      AggregateQuerySnapshot snapshot = await TotalVotes.get();

      return snapshot.count ?? 0;
      //
    } catch (e) {
      MyAlert.showToast(0, 'Error while fetching');
    }
    return 0;
  }
}
