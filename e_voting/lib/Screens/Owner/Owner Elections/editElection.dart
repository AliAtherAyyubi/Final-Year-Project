import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/Controllers/election_control.dart';
import 'package:e_voting/Database/election_db.dart';
import 'package:e_voting/Models/election.dart';
import 'package:e_voting/Screens/Widgets/loading.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/Services/dateTime.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

class EditElections extends StatefulWidget {
  String electionId;
  EditElections({super.key, required this.electionId});

  @override
  State<EditElections> createState() => _EditElectionsState();
}

class _EditElectionsState extends State<EditElections> {
  ElectionModel? e;
//
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController description = TextEditingController();

  late DateTime _start;
  late DateTime _end;
  bool data = false;
  bool loading = false;

  Future<void> fetchElections() async {
    e = await ElectionDatabase().fetchElectionById(widget.electionId);
    setState(() {
      name.text = e!.electionName ?? "";
      startDate.text = TimeService().getOnlyDate(e!.startDate!);
      endDate.text = TimeService().getOnlyDate(e!.endDate!);
      description.text = e!.description ?? "";
      data = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchElections();
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
              'Edit Election',
              style: AppStyle().h2,
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
                        TextLabel(
                          field: 'Title',
                        ),
                        AuthTextField(
                          controller: name,
                          keyboardType: TextInputType.name,
                          labelText: 'Election Title',
                          maxlength: 50,
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
                          onTap: () async {
                            _end = await TimeService().selectDate(context);
                            setState(() {});
                            endDate.text =
                                DateFormat('dd-MMM-yyyy').format(_end);
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
                          labelText: 'Description (Min 50 words)',
                          maxline: 8,
                          maxlength: 250,
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
                              e!.electionId = widget.electionId;
                              e!.electionName = name.text;
                              e!.startDate =
                                  TimeService().convertToTimestamp(_start);
                              e!.endDate =
                                  TimeService().convertToTimestamp(_end);
                              e!.description = description.text;
                              await ElectionDatabase().updateElectionByID(e!);
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                          text: 'Update Election',
                          width: 100.w,
                          loading: loading,
                        ),
                      ],
                    ))
                : Loading(
                    color: AppStyle.iconClr,
                  ),
          ],
        ),
      ),
    );
  }
}
