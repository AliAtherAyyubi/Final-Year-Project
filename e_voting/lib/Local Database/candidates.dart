import 'dart:convert';

import 'package:e_voting/Local%20Database/sharedHelp.dart';
import 'package:e_voting/Models/candidate.dart';
import 'package:e_voting/Models/election.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalCandidate {
  SharedHelper prefs = SharedHelper();

  // Candidate Section //

  Future<void> setCandidates(List<CandidateModel> candList) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    // // List<String> candidateDataList =
    // //     candList.map((candidate) => jsonEncode(candidate.toJson())).toList();

    // await sp.setStringList('CandidateDataList', candidateDataList);
  }

//
  // Future<List<CandidateModel>> fetchAllCandidates() async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();

  //   List<String> candidateDataList =
  //       sp.getStringList('CandidateDataList') ?? [];

  //   return candidateDataList.map((candidate) {
  //     Map<String, dynamic> json = jsonDecode(candidate);
  //     return CandidateModel.fromJson(json);
  //   }).toList();
  // }
  //

  Future<void> RemoveAllElections() async {
    SharedPreferences sp = await prefs.initializer();
    await sp.remove('CandidateDataList');
  }

  //
  Future<bool> isExist() async {
    SharedPreferences sp = await prefs.initializer();

    bool isExist = sp.containsKey('CandidateDataList');
    return isExist;
  }
}
