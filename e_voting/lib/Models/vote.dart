import 'package:cloud_firestore/cloud_firestore.dart';

class VoteModel {
  String? voteId;
  String? userId;
  String? electionId;
  String? candidateId;
  String? orgId;
  String? votedFor;
  Timestamp? time;

  VoteModel(
      {this.voteId,
      this.userId,
      this.electionId,
      this.candidateId,
      this.orgId,
      this.votedFor,
      this.time});
}
