import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Controllers/election_control.dart';
import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Database/voting_db.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Models/vote.dart';
import 'package:e_voting/Screens/Voting/voteSuccess.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:get/get.dart';

class VoteController {
  VoteModel vote = VoteModel();
  ElectionModel? electionModel = ElectionModel();
  //
  Future<void> createVote(uid, elecId, cand_id, votedfor) async {
    bool isVoteExist = await VoteDatabase().isVoteExist(uid);
    // electionModel = await ElectionDatabase().fetchElectionById(elecId);
    if (isVoteExist) {
      vote.userId = uid;
      vote.electionId = elecId;
      vote.candidateId = cand_id;
      // vote.orgId = electionModel!.orgId;
      vote.votedFor = votedfor;
      vote.time = Timestamp.now();
      //
      await VoteDatabase().createVote(vote);
      Get.to(() => VoteSuccess(), transition: Transition.native);
    } else {
      MyAlert.showToast(0, 'You have already voted!');
    }
  }
}
