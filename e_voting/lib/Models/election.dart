import 'package:cloud_firestore/cloud_firestore.dart';

class ElectionModel {
  String? electionId;
  String? electionName;
  // String? address;
  String? description;
  Timestamp? startDate;
  Timestamp? endDate;
  String? status;
  String? orgId;

  ElectionModel(
      {this.electionId,
      this.electionName,
      // this.address,
      this.description,
      this.startDate,
      this.endDate,
      this.status,
      this.orgId});
}
