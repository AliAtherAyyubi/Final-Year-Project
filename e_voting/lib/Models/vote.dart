class VoteModel {
  String? voteId;
  String? userId;
  String? electionId;
  String? candidateId;
  int? totalVotes;
  DateTime? Timestamp;

  VoteModel(
      {this.voteId,
      this.userId,
      this.electionId,
      this.candidateId,
      this.totalVotes,
      this.Timestamp});
}
