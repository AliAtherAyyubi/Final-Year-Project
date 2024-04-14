import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Models/election.dart';

class ElectionController {
  ElectionModel e = ElectionModel();

  Future<void> createElection(name, detail, st, sdate, edate) async {
    var orgid = await OrgDatabase().GetOrgId();

    e.electionName = name;
    e.description = detail;
    e.orgId = orgid;
    e.status = st;
    e.startDate = sdate;
    e.endDate = edate;

    ElectionDatabase().electionDB(e);
  }
}
