import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Local%20Database/adminData.dart';
import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Models/organization.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Owner/Owner%20Elections/displayElection.dart';
import 'package:e_voting/Screens/Owner/Owner%20Elections/addElection.dart';
import 'package:e_voting/Screens/Owner/org.dart';
import 'package:e_voting/Screens/Widgets/owner/tiles.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class OwnerMainPage extends StatefulWidget {
  @override
  State<OwnerMainPage> createState() => _OwnerMainPageState();
}

class _OwnerMainPageState extends State<OwnerMainPage> {
  // const OwnerMainPage({super.key});
  UserModel user = UserModel();
  OrgModel org = OrgModel();
  //d
  String? imageUrl;
  String? orgName;
  String userName = '';
  //

  void setOrgId() async {
    UserData user = Get.put(UserData());
    var id = await OrgDatabase().GetOrgId();
    print(id);
    user.setOrgId(id);
    // if (user.orgId.toString() == "") {

    // }
  }

  Future<void> fetchUser() async {
    user = await UserLocalData().fetchLocalUser();
    // org = await AdminLocalData().fetchLocalOrg();
    print(user.userName);
    setState(() {
      userName = user.userName.toString().capitalize!;
      // orgName = org.orgName.toString().capitalize;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setOrgId();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: RefreshIndicator(
        onRefresh: () => fetchUser(),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: Container(
              height: 250,
              padding: EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff488F3C), Color(0xff78CB9A)]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orgName ?? "Your Organization",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'HR Department',
                    style: GoogleFonts.inter(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const GFAvatar(
                    backgroundImage: AssetImage('assets/icons/profile.png'),
                    radius: 15,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Welcome, $userName',
                    style:
                        AppStyle().txt1.copyWith(color: Colors.grey.shade600),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Now voting become easier",
                style: AppStyle()
                    .h3
                    .copyWith(color: AppStyle.textClr, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => Get.to(() => OwnerOrganization(),
                    transition: Transition.rightToLeft),
                child: OwnerTiles(
                    fieldName: 'Create/Edit Organization',
                    icon: Icons.business_outlined),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () => Get.to(() => OwnerElectionList(),
                    transition: Transition.rightToLeft),
                child: OwnerTiles(
                    fieldName: 'Create/Edit Elections',
                    icon: Icons.how_to_vote),
              ),
              SizedBox(
                height: 5,
              ),
              OwnerTiles(
                  fieldName: 'Create/Edit Candidates', icon: Icons.person),
            ],
          ),
        ),
      ),
    );
  }
}
