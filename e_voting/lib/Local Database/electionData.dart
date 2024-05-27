import 'package:e_voting/Local%20Database/sharedHelp.dart';
import 'package:e_voting/Models/election.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ElectionLocalData {
  SharedHelper prefs = SharedHelper();

  // Election Section //
  Future<void> addLocalElection(ElectionModel election) async {
    SharedPreferences sp = await prefs.initializer();
    List<String> electionDataList = [];

    Map<String, dynamic> electionMapData = {
      'electionId': election.electionId,
      'electionName': election.electionName,
      'description': election.description,
      'startDate': election.startDate,
      'endDate': election.endDate,
      'status': election.status,
      'orgId': election.orgId,
    };
    String electionData = prefs.convertJsonToString(electionMapData);
    electionDataList.add(electionData);

    await sp.setStringList('ElectionDataList', electionDataList);
  }

  //
  Future<List<ElectionModel>> fetchLocalElections() async {
    SharedPreferences sp = await prefs.initializer();
    List<String> electionDataList = sp.getStringList('ElectionDataList') ?? [];

    List<ElectionModel> elections = [];
    if (electionDataList.isNotEmpty) {
      for (String electionData in electionDataList) {
        Map<String, dynamic> electionMapData =
            prefs.convertStringToJson(electionData);
        elections.add(ElectionModel(
          electionId: electionMapData['electionId'],
          electionName: electionMapData['electionName'],
          description: electionMapData['description'],
          startDate: electionMapData['startDate'],
          endDate: electionMapData['endDate'],
          status: electionMapData['status'],
          orgId: electionMapData['orgId'],
        ));
      }
    }

    return elections;
  }
  //

  Future<void> updateLocalElection(ElectionModel election) async {
    SharedPreferences sp = await prefs.initializer();
    List<String> electionDataList = sp.getStringList('ElectionDataList') ?? [];

    for (int i = 0; i < electionDataList.length; i++) {
      Map<String, dynamic> existingElectionMapData =
          prefs.convertStringToJson(electionDataList[i]);
      if (existingElectionMapData['electionId'] == election.electionName) {
        // Update the existing election data
        Map<String, dynamic> updatedElectionMapData = {
          'electionId': election.electionId,
          'electionName': election.electionName,
          'description': election.description,
          'startDate': election.startDate,
          'endDate': election.endDate,
          'status': election.status,
          'orgId': election.orgId,
        };
        String updatedElectionData =
            prefs.convertJsonToString(updatedElectionMapData);
        electionDataList[i] = updatedElectionData;
        await sp.setStringList('ElectionDataList', electionDataList);
        return;
      }
    }
  }

  //
  Future<void> deleteLocalElection(String electionId) async {
    SharedPreferences sp = await prefs.initializer();
    List<String> electionDataList = sp.getStringList('ElectionDataList') ?? [];

    for (int i = 0; i < electionDataList.length; i++) {
      Map<String, dynamic> existingElectionMapData =
          prefs.convertStringToJson(electionDataList[i]);
      if (existingElectionMapData['electionId'] == electionId) {
        // Remove the election data from the list
        electionDataList.removeAt(i);
        await sp.setStringList('ElectionDataList', electionDataList);
        return;
      }
    }
  }

  Future<void> deleteAllElections() async {
    SharedPreferences sp = await prefs.initializer();
    await sp.remove('ElectionDataList');
  }
}
