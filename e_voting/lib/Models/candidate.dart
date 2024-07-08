class CandidateModel {
  String? candidateId;
  String? name;
  String? imageUrl;
  String? adminId;
  String? elecId;
  String? publicDescription;
  String? biography;
  String? description;
  int? voteCount;
  List<dynamic>? links;

  CandidateModel({
    this.candidateId,
    this.adminId,
    this.elecId,
    this.name,
    this.imageUrl,
    this.publicDescription,
    this.biography,
    this.description,
    this.voteCount,
    this.links,
  });
}
