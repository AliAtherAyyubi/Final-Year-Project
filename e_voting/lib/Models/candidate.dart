class CandidateModel {
  String? candidateId;
  String? name;
  String? imageUrl;
  String? orgId;
  String? publicDescription;
  String? biography;
  String? description;
  int? voteCount;
  List<dynamic>? links;

  CandidateModel({
    this.candidateId,
    this.orgId,
    this.name,
    this.imageUrl,
    this.publicDescription,
    this.biography,
    this.description,
    this.voteCount,
    this.links,
  });

  // Convert a CandidateModel to a Map.
  Map<String, dynamic> toJson() {
    return {
      'candidateId': candidateId,
      'name': name,
      'imageUrl': imageUrl,
      'orgId': orgId,
      'publicDescription': publicDescription,
      'biography': biography,
      'description': description,
      'voteCount': voteCount,
      'links': links,
    };
  }

  // Extract a CandidateModel from a Map.
  factory CandidateModel.fromJson(Map<String, dynamic> json) {
    return CandidateModel(
      candidateId: json['candidateId'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      orgId: json['orgId'],
      publicDescription: json['publicDescription'],
      biography: json['biography'],
      description: json['description'],
      voteCount: json['voteCount'],
      links: json['links'],
    );
  }
}
