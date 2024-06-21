import 'package:e_voting/Controllers/org_controller.dart';
import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Local%20Database/adminData.dart';
import 'package:e_voting/Models/organization.dart';
import 'package:e_voting/Screens/Owner/ownerScreen.dart';
import 'package:e_voting/Screens/Widgets/alertDialog.dart';
import 'package:e_voting/Screens/Widgets/loading.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OwnerOrganization extends StatefulWidget {
  const OwnerOrganization({super.key});

  @override
  State<OwnerOrganization> createState() => _OwnerOrganizationState();
}

class _OwnerOrganizationState extends State<OwnerOrganization> {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController description = TextEditingController();

  bool loading = false;
  bool isOrgExist = false;
  void isOrg() async {
    bool exist = await AdminLocalData().isOrgExist();

    setState(() {
      isOrgExist = exist;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isOrg();
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: ScreenTitle(title: ''),
        ),
        body: isOrgExist
            ? EditOrg()
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Add Organization',
                    style: AppStyle().h2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          AuthTextField(
                            controller: name,
                            keyboardType: TextInputType.name,
                            labelText: 'Title',
                            maxlength: 30,
                            validator: (value) {
                              if (value.isEmpty) return 'field can\'t be empty';
                            },
                          ),
                          AuthTextField(
                            controller: address,
                            keyboardType: TextInputType.name,
                            labelText: 'Organization Address (Optional)',
                            maxlength: 50,
                          ),
                          AuthTextField(
                            controller: description,
                            keyboardType: TextInputType.name,
                            labelText: 'Description (Optional)',
                            maxline: 8,
                            maxlength: 200,
                          ),
                          MyButton(
                            onPress: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                await OrgController().createOrg(
                                    name.text, address.text, description.text);

                                clearText();
                                setState(() {
                                  loading = false;
                                });
                                Get.off(() => OwnerMainScreen(),
                                    transition: Transition.fade);
                              }
                            },
                            text: 'Create Organization',
                            width: 100.w,
                            loading: loading,
                          )
                        ],
                      )),
                ],
              ),
      ),
    );
  }

  void clearText() {
    name.text = "";
    address.text = '';
    description.text = '';
  }
}

class EditOrg extends StatefulWidget {
  const EditOrg({super.key});

  @override
  State<EditOrg> createState() => _EditOrgState();
}

class _EditOrgState extends State<EditOrg> {
  OrgModel? org = OrgModel();
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController description = TextEditingController();

  bool loading = false;
  bool data = false;
  bool readOnly = true;
  bool border = true;
  bool isEdit = false;
  Color fillColor = Colors.white;
  //
  Future<void> fetchOrg() async {
    setState(() {
      data = false;
    });
    org = await AdminLocalData().fetchLocalOrg();
    setState(() {
      name.text = org!.orgName ?? '';
      address.text = org!.address ?? '';
      description.text = org!.description ?? '';
      data = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrg();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                'Edit Organization',
                style: AppStyle().h2,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  readOnly = false;
                  // border = false;
                  fillColor = Colors.grey.shade200;
                  isEdit = true;
                });
              },
              icon: Icon(
                Icons.edit,
                color: AppStyle.iconClr,
              ),
              iconSize: 30,
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        data
            ? Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: AppStyle()
                          .h2
                          .copyWith(fontSize: 25, color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AuthTextField(
                      controller: name,
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      labelText: 'Title',
                      maxlength: 30,
                      readOnly: readOnly,
                      border: border,
                      fillColor: fillColor,
                      validator: (value) {
                        if (value.isEmpty) return 'field can\'t be empty';
                      },
                    ),
                    Text(
                      'Address',
                      style: AppStyle()
                          .h2
                          .copyWith(fontSize: 25, color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AuthTextField(
                      controller: address,
                      keyboardType: TextInputType.name,
                      labelText: 'Organization Address',
                      maxlength: 50,
                      obscureText: false,
                      readOnly: readOnly,
                      border: border,
                      fillColor: fillColor,
                    ),
                    Text(
                      'Description',
                      style: AppStyle()
                          .h2
                          .copyWith(fontSize: 25, color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AuthTextField(
                      controller: description,
                      keyboardType: TextInputType.name,
                      labelText: 'Description',
                      maxline: 8,
                      maxlength: 200,
                      obscureText: false,
                      readOnly: readOnly,
                      border: border,
                      fillColor: fillColor,
                    ),
                    MyButton(
                      onPress: isEdit
                          ? () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                await OrgDatabase().updateOrg(
                                    name.text, address.text, description.text);
                                setState(() {
                                  loading = false;
                                });
                                await fetchOrg();
                                setState(() {
                                  readOnly = true;
                                  fillColor = Colors.white;
                                });
                              }
                            }
                          : null,
                      text: 'Update',
                      width: 100.w,
                      loading: loading,
                    )
                  ],
                ))
            : Loading(
                color: AppStyle.iconClr,
              ),
      ],
    );
  }
}
