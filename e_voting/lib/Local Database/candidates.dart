import 'package:e_voting/Local%20Database/sharedHelp.dart';
import 'package:e_voting/Models/candidate.dart';
import 'package:e_voting/Models/election.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalCandidate {
  SharedHelper prefs = SharedHelper();

  // Election Section //
  Future<void> setCandidates(List<CandidateModel> candList) async {
    SharedPreferences sp = await prefs.initializer();

    String candidateData = candList.toString();

    await sp.setString('CandidateList', candidateData);
  }

  //
  Future<List<CandidateModel>> fetchAllElections() async {
    //
    SharedPreferences sp = await prefs.initializer();
    String candString = sp.getString('CandidateList') ?? "";

    List<CandidateModel> candidateList = candString as List<CandidateModel>;
    print('Candidate List: ${candidateList.length}');
    return candidateList;
  }
  //

  Future<void> RemoveAllElections() async {
    SharedPreferences sp = await prefs.initializer();
    await sp.remove('CandidateList');
  }

  //
  Future<bool> isExist() async {
    SharedPreferences sp = await prefs.initializer();

    bool isExist = sp.containsKey('CandidateList');
    return isExist;
  }
}
