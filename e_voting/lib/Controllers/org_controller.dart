import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Models/organization.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:get/get.dart';

class OrgController {
  OrgModel org = OrgModel();
  UserData userData = Get.put(UserData());
  // creating organization //
  Future<void> createOrg(name, address, description) async {
    var id = await UserLocalData().getUserId();

    org.orgName = name;
    org.address = address;
    org.description = description;
    org.adminId = id;

    await OrgDatabase().createOrgDB(org);
  }
  //

  Future<bool> isOrgExist() async {
    var res = await OrgDatabase().GetOrgId();
    if (res != null) return true;
    return false;
  }

  String getOrgId() {
    String id = userData.orgId.toString();
    print(id);
    return id;
  }
}
