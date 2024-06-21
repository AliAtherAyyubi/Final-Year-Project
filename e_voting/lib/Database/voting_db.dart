import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Controllers/election_control.dart';
import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Models/organization.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Models/vote.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:e_voting/Services/dateTime.dart';

class VoteDatabase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Create a vote of Voter//

  Future<void> createVote(VoteModel vote) async {
    try {
      await firestore.collection('vote').add({
        'userId': vote.userId,
        'electionId': vote.electionId,
        'candidateId': vote.candidateId,
        'orgId': vote.orgId,
        'votedFor': vote.votedFor,
        'createdOn': vote.time
      });
      print('Voted Success');
    } catch (e) {
      MyAlert.showToast(0, 'Error while creating Vote');
      print('Error');
    }
  }

  // Fetching Vote of Voter //
  Future<VoteModel> getVoteByUserId(String uid) async {
    QuerySnapshot querySnapshot = await firestore
        .collection('vote')
        .where('userId', isEqualTo: uid)
        .get();
    //
    var voteId = querySnapshot.docs.first.id;
    DocumentSnapshot doc = await firestore.collection('vote').doc(voteId).get();
    return VoteModel(
      userId: doc['userId'],
      electionId: doc['electionId'],
      candidateId: doc['candidateId'],
      orgId: doc['orgId'],
      votedFor: doc['votedFor'],
      time: doc['createdOn'],
    );
  }

  // Fetching All votes of Elections //
  Future<List<VoteModel>?> fetchAllVotes() async {
    List<VoteModel> votingList = [];
    try {
      QuerySnapshot querySnapshot = await firestore.collection('vote').get();
      //
      final docs = querySnapshot.docs;
      //
      if (docs.isNotEmpty) {
        for (var doc in docs) {
          votingList.add(VoteModel(
            userId: doc.get('userId'),
            electionId: doc.get('electionId'),
            candidateId: doc.get('candidateId'),
            orgId: doc.get('orgId'),
            votedFor: doc.get('votedFor'),
            time: doc.get('createdOn'),
          ));
        }
        return votingList;
      }
      return null;
    } catch (e) {
      MyAlert.showToast(0, 'System Error');
    }
    return null;
  }

  Future<bool> isVoteExist(String uid) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('vote')
          .where('userId', isEqualTo: uid)
          .get();

      if (querySnapshot.docs.isEmpty) return true;
      return false;
    } catch (e) {
      print('Error while fetching userVote');
    }
    return false;
  }
  //

  Future<Map?> ReceiptDetails() async {
    try {
      Map ReceiptData;
      VoteModel vote;
      OrgModel? org;
      UserModel user = await UserLocalData().fetchLocalUser();

      //

      vote = await getVoteByUserId(user.userId!);
      org = await OrgDatabase().fetchOrgById();
      //
      ReceiptData = {
        'orgName': "${vote.time!.toDate().year} ${org!.orgName} Elections",
        'votedOn': TimeService().getFormatedDate(vote.time!),
        'votedFor': vote.votedFor,
        'userName': user.userName,
      };
      return ReceiptData;
    } catch (e) {
      MyAlert.showToast(0, 'Network or System Error');
      print('Error while fetching userVote');
      return null;
    }
  }
}
