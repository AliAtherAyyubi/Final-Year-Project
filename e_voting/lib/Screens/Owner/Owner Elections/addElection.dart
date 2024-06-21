import 'package:e_voting/Controllers/election_control.dart';
import 'package:e_voting/Controllers/org_controller.dart';
import 'package:e_voting/Database/org_db.dart';
import 'package:e_voting/Screens/Owner/Owner%20Elections/displayElection.dart';
import 'package:e_voting/Screens/Owner/ownerScreen.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/Services/dateTime.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

class OwnerElection extends StatefulWidget {
  const OwnerElection({super.key});

  @override
  State<OwnerElection> createState() => _OwnerElectionState();
}

class _OwnerElectionState extends State<OwnerElection> {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController description = TextEditingController();

  late DateTime _start;
  late DateTime _end;
  bool loading = false;
  bool isOrgExist = false;

  //
  void isOrg() async {
    bool isOrg = await OrgController().isOrgExist();
    setState(() {
      isOrgExist = isOrg;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // isOrg();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: ScreenTitle(title: ''),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Add Election',
              style: AppStyle().h2,
            ),
            SizedBox(
              height: 20,
            ),
            Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextLabel(
                      field: 'Title',
                    ),
                    AuthTextField(
                      controller: name,
                      keyboardType: TextInputType.name,
                      labelText: 'Election Title',
                      maxlength: 40,
                      validator: (value) {
                        if (value.isEmpty) return 'field can\'t be empty';
                      },
                    ),
                    TextLabel(
                      field: 'Start Date',
                    ),
                    AuthTextField(
                      controller: startDate,
                      labelText: 'Start date',
                      readOnly: true,
                      icon: Icons.calendar_month_outlined,
                      onTap: () async {
                        _start = await TimeService().selectDate(context);
                        setState(() {});
                        startDate.text =
                            DateFormat('dd-MMM-yyyy').format(_start);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select start date';
                        }
                        return null;
                      },
                    ),
                    TextLabel(
                      field: 'End Date',
                    ),
                    AuthTextField(
                      controller: endDate,
                      keyboardType: TextInputType.datetime,
                      readOnly: true,
                      labelText: 'End date',
                      icon: Icons.calendar_month_outlined,
                      onTap: () async {
                        _end = await TimeService().selectDate(context);
                        setState(() {});

                        endDate.text = DateFormat('dd-MMM-yyyy').format(_end);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select end date';
                        }
                        if (TimeService().getDifference(_start, _end) > 5) {
                          return 'Choose a correct ending date!';
                        }
                        return null;
                      },
                    ),
                    TextLabel(
                      field: 'Description',
                    ),
                    AuthTextField(
                      controller: description,
                      keyboardType: TextInputType.name,
                      labelText: 'Description',
                      maxline: 5,
                      maxlength: 210,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'field can\'t be empty!';
                        }
                        if (value.toString().length < 50) {
                          return 'Description should at least of 50 characters';
                        }
                        return null;
                      },
                    ),
                    MyButton(
                      onPress: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          await ElectionController().createElection(
                              name.text, _start, _end, description.text);
                          setState(() {
                            loading = false;
                          });
                          clearText();
                          Get.off(OwnerMainScreen(),
                              transition: Transition.fade);
                        }
                      },
                      text: 'Create an Election',
                      width: 100.w,
                      loading: loading,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void clearText() {
    name.text = "";
    startDate.text = "";
    endDate.text = "";
    description.text = "";
  }
}
