import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Models/organization.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OrgController {
  OrgModel org = OrgModel();
  // creating organization //
  Future<void> createOrg() async {
    var id = Get.put(UserData()).userID.toString();

    org.orgName = 'ElectiCast';
    org.description = 'ElectiCast is a cutting-edge mobile voting platform ';
    org.adminId = id;

    OrgDatabase().createOrgDB(org);
  }
}
