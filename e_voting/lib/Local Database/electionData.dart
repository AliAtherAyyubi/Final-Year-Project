import 'package:e_voting/Local%20Database/sharedHelp.dart';
import 'package:e_voting/Models/election.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalElectionData {
  SharedHelper prefs = SharedHelper();

  // Election Section //
  Future<void> setElections(List<ElectionModel> electionList) async {
    SharedPreferences sp = await prefs.initializer();

    String electionDataList = electionList.toString();

    await sp.setString('ElectionDataList', electionDataList);
  }

  //
  Future<List<ElectionModel>> fetchAllElections() async {
    //
    SharedPreferences sp = await prefs.initializer();
    String electionsString = sp.getString('ElectionDataList') ?? "";

    List<ElectionModel> electionList = electionsString as List<ElectionModel>;

    return electionList;
  }
  //

  Future<void> RemoveAllElections() async {
    SharedPreferences sp = await prefs.initializer();
    await sp.remove('ElectionDataList');
  }
}
