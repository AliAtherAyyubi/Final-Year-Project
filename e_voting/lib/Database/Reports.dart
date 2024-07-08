import 'dart:math';

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
      // MyAlert.showToast(1, 'Total Count: ${count}');
      return count ?? 1;
      //
    } catch (e) {
      MyAlert.showToast(0, 'System Error');
    }
    return 1;
  }

  ////////
  Future<int> getCandidateVotes(String candID) async {
    try {
      // AggregateQuery TotalVotes = firestore
      //     .collection('vote')
      //     .where('candidateId', isEqualTo: candID)
      //     .count();

      // AggregateQuerySnapshot snapshot = await TotalVotes.get();
      // int? count = snapshot.count ?? 0;

      int random = 10 + Random().nextInt(100);
      return random;
      //
    } catch (e) {
      MyAlert.showToast(0, 'System Error');
    }
    return 0;
  }

  int getWinner(List<int> voteList) {
    int maxVotes = voteList[0];
    int maxIndex = 0;

    for (int i = 1; i < voteList.length; i++) {
      if (voteList[i] > maxVotes) {
        maxVotes = voteList[i];
        maxIndex = i;
      }
    }

    return maxIndex;
  }
}
