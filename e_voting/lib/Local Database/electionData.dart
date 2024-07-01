import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Local%20Database/sharedHelp.dart';
import 'package:e_voting/Models/election.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalElectionData {
  SharedHelper prefs = SharedHelper();

  // Election Section //
  Future<void> setAllElections(QuerySnapshot querySnapshot) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> electionDataList = [];

    var docs = querySnapshot.docs;

    for (var doc in docs) {
      Map<String, dynamic> data = {
        'electionId': doc.get('electionId'),
        'name': doc.get('name'),
        'startDate': doc.get('startDate'),
        'endDate': doc.get('endDate'),
        'description': doc.get('description'),
        'orgId': doc.get('orgId'),
      };

      //
      String stringData = prefs.convertJsonToString(data);
      electionDataList.add(stringData);
    }

    await sp.setStringList('ElectionDataList', electionDataList);
  }

  //
  Future<List<ElectionModel>> fetchAllElections() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    List<String>? electionDataList = sp.getStringList('ElectionDataList') ?? [];
    List<ElectionModel> electionList = [];
    /////
    for (var data in electionDataList) {
      Map<String, dynamic> doc = prefs.convertStringToJson(data);
      electionList.add(ElectionModel(
          electionName: doc['name'],
          description: doc['description'],
          electionId: doc['electionId'],
          orgId: doc['orgId'],
          startDate: doc['startDate'],
          endDate: doc['endDate'],
          status: doc['status']));
    }
    //
    return electionList;
  }

  //
  Future<void> RemoveAllElections() async {
    SharedPreferences sp = await prefs.initializer();
    await sp.remove('ElectionDataList');
  }

  //
  Future<bool> isExist() async {
    SharedPreferences sp = await prefs.initializer();

    bool isExist = sp.containsKey('ElectionDataList');
    return isExist;
  }
}
