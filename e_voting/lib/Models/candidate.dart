class CandidateModel {
  String? candidateId;
  String? userId;
  // String? electionId;
  String? orgId;
  String? cnic;
  List<String>? description;
  int? voteCount;
  List<String>? links;

  CandidateModel({
    this.candidateId,
    this.userId,
    this.orgId,
    this.cnic,
    // this.electionId,
    this.description,
    this.voteCount,
    this.links,
  });
}
