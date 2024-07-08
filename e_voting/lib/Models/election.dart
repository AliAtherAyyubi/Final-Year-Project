import 'package:cloud_firestore/cloud_firestore.dart';

class ElectionModel {
  String? electionId;
  String? electionName;
  String? position;
  String? description;
  Timestamp? startDate;
  Timestamp? endDate;
  String? status;
  String? orgId;
  String? adminId;

  ElectionModel({
    this.electionId,
    this.electionName,
    this.position,
    this.description,
    this.startDate,
    this.endDate,
    this.status,
    this.orgId,
    this.adminId,
  });
}
