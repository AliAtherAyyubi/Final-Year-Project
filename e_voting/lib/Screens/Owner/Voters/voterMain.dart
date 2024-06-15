import 'package:e_voting/Database/owner_db.dart';
import 'package:e_voting/Screens/Widgets/alertDialog.dart';
import 'package:e_voting/Screens/Widgets/empty.dart';
import 'package:e_voting/Screens/Widgets/loading.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/Services/validation.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';

class OwnerVoters extends StatefulWidget {
  const OwnerVoters({super.key});

  @override
  State<OwnerVoters> createState() => _OwnerVotersState();
}

class _OwnerVotersState extends State<OwnerVoters> {
  final formKey = GlobalKey<FormState>();
  List? voters;
  List? filteredVoters;
  bool data = false;
  TextEditingController cnic = TextEditingController();
  TextEditingController searchControl = TextEditingController();
  bool loading = false;
  //
  Future<void> fetchVoters() async {
    voters = await OwnerDatabase().fetchVoters();
    // print(elections[0].electionName);
    setState(() {
      // electionData = querySnapshot;
      filteredVoters = voters;
      data = true;
    });
  }

  Future<void> addVoter() async {
    if (formKey.currentState!.validate()) {
      await OwnerDatabase().addVoter(cnic.text);
      await fetchVoters();
      cnic.clear();
      Navigator.pop(context);
    }
  }

  void searchVoter() {
    List tempfilteredVoters = voters!
        .where((element) => element.toString().contains(searchControl.text))
        .toList();
    setState(() {
      filteredVoters = tempfilteredVoters;
    });
  }

  void removeVoter(id) {
    filteredVoters!.remove(id);
    setState(() {
      filteredVoters = filteredVoters;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchVoters();
    searchControl.addListener(searchVoter);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: ScreenTitle(
              title: '',
            )),
        //
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MyAlertDialogWidget(
                    title: 'Enter CNIC of Voter',
                    content: Form(
                      key: formKey,
                      child: FlatTextField(
                        controller: cnic,
                        keyboardType: TextInputType.number,
                        labelText: 'CNIC',
                        inputFormatter: Validation().cnicFormatter,
                        validator: (value) => Validation().isValidCnic(value),
                      ),
                    ),
                    onConfirm: addVoter,
                    loading: loading,
                  );
                });
          },
          child: Icon(Icons.add),
          backgroundColor: AppStyle.primaryColor,
        ),

        body: RefreshIndicator(
          onRefresh: () => fetchVoters(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // scrollDirection: Axis.vertical,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Add Voters By CNIC',
                  style: AppStyle().h2,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Form(
                    child: AuthTextField(
                      controller: searchControl,
                      keyboardType: TextInputType.number,
                      // inputFormat: Validation().cnicFormatter,
                      maxlength: 15,
                      icon: Icons.search,
                      border: true,
                      labelText: 'Search By CNIC',
                    ),
                  ),
                ),
                //
                data
                    ? voters == null
                        ? EmptyImage()
                        : Expanded(
                            child: ListView.builder(
                                itemCount: filteredVoters!.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  //      ////            ///
                                  var voterID = filteredVoters![index];
                                  return Dismissible(
                                    key: Key(voterID),
                                    direction: DismissDirection.endToStart,
                                    behavior: HitTestBehavior.deferToChild,
                                    onDismissed: (direction) async {
                                      removeVoter(voterID);
                                      await OwnerDatabase()
                                          .deleteVoter(voterID);
                                    },
                                    background: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      color: Colors.red,
                                      alignment: Alignment.centerRight,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: ListTile(
                                        titleAlignment:
                                            ListTileTitleAlignment.center,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 15),
                                        leading: const Icon(
                                          Icons.person,
                                          size: 50,
                                        ),
                                        title: Text(
                                          voterID,
                                          style: AppStyle()
                                              .h3
                                              .copyWith(color: Colors.black),
                                        ),
                                        tileColor: Colors.green.shade200,
                                        trailing: IconButton(
                                          onPressed: () {
                                            cnic.text = voterID;
                                            // cnic.selection = TextSelection.collapsed(
                                            //     offset: cnic.text.length);
                                            var oldValue = voterID;
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return MyAlertDialogWidget(
                                                    title: 'Update CNIC',
                                                    content: Form(
                                                      key: formKey,
                                                      child: FlatTextField(
                                                        controller: cnic,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        labelText: 'CNIC',
                                                        inputFormatter:
                                                            Validation()
                                                                .cnicFormatter,
                                                        validator: (value) =>
                                                            Validation()
                                                                .isValidCnic(
                                                                    value),
                                                      ),
                                                    ),
                                                    confirmBtnText: 'Update',
                                                    onConfirm: () async {
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        await OwnerDatabase()
                                                            .updateVoter(
                                                                oldValue,
                                                                cnic.text);
                                                        await fetchVoters();
                                                        cnic.clear();
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                  );
                                                });
                                          },
                                          icon: Icon(Icons.edit),
                                          iconSize: 35,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                    : Loading()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
