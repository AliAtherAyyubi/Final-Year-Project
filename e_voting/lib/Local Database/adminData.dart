import 'package:e_voting/Local%20Database/sharedHelp.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Models/organization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLocalData {
  SharedHelper prefs = SharedHelper();

  Future<void> setLocalOrg(OrgModel org) async {
    SharedPreferences sp = await prefs.initializer();
    //
    Map<String, dynamic> orgMapData = {
      'name': org.orgName,
      'address': org.address,
      'description': org.description,
      'orgId': org.orgId,
      'adminId': org.adminId,
    };

    String OrgData = prefs.convertJsonToString(orgMapData);

    await sp.setString('OrgData', OrgData);
  }

  // Fetch Org

  Future<OrgModel> fetchLocalOrg() async {
    SharedPreferences sp = await prefs.initializer();
    //

    String? stringData = sp.getString('OrgData');
    Map<String, dynamic> OrgData = prefs.convertStringToJson(stringData!);
    //
    return OrgModel(
      orgName: OrgData['name'],
      address: OrgData['address'],
      description: OrgData['description'],
      adminId: OrgData['adminId'],
      orgId: OrgData['orgId'],
    );
  }

  Future<void> removeOrg() async {
    SharedPreferences sp = await prefs.initializer();
    sp.remove('OrgData');
  }

  Future<bool> isOrgExist() async {
    SharedPreferences sp = await prefs.initializer();
    bool isExist = sp.containsKey('OrgData');
    print("org Exist:$isExist");
    return isExist;
  }
}
