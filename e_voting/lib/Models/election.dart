import 'package:cloud_firestore/cloud_firestore.dart';

class ElectionModel {
  String? electionId;
  String? electionName;
  String? description;
  Timestamp? startDate;
  Timestamp? endDate;
  String? status;
  String? orgId;

  ElectionModel({
    this.electionId,
    this.electionName,
    this.description,
    this.startDate,
    this.endDate,
    this.status,
    this.orgId,
  });

  // Convert a ElectionModel to a Map.
  Map<String, dynamic> toJson() {
    return {
      'electionId': electionId,
      'electionName': electionName,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
      'orgId': orgId,
    };
  }

  // Extract a ElectionModel from a Map.
  factory ElectionModel.fromJson(Map<String, dynamic> json) {
    return ElectionModel(
      electionId: json['electionId'],
      electionName: json['electionName'],
      description: json['description'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      status: json['status'],
      orgId: json['orgId'],
    );
  }
}
