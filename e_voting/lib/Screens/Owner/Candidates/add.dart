import 'dart:io';

import 'package:e_voting/Controllers/image_control.dart';
import 'package:e_voting/Database/candidate_db.dart';
import 'package:e_voting/Models/candidate.dart';
import 'package:e_voting/Screens/Owner/ownerScreen.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddCandidateScreen extends StatefulWidget {
  const AddCandidateScreen({super.key});

  @override
  State<AddCandidateScreen> createState() => _AddCandidateScreenState();
}

class _AddCandidateScreenState extends State<AddCandidateScreen> {
  //
  CandidateModel c = CandidateModel();
  //
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController publicDesc = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController twitter = TextEditingController();
  TextEditingController imageName = TextEditingController();

  bool loading = false;

  XFile? image;

  Future<void> addCandidate() async {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      setState(() {
        loading = true;
      });
      //
      String? imageUrl = image != null
          ? await ImageController().uploadCandidateImage(image!)
          : null;

      ///
      c.name = name.text;
      c.biography = bio.text;
      c.publicDescription = publicDesc.text;
      c.description = description.text;
      c.links = [facebook.text, twitter.text];
      c.imageUrl = imageUrl;

      ///
      await CandidateDB().createCandidate(c);
      setState(() {
        image = null;
        loading = false;
      });
      clearText();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            children: [
              SizedBox(
                height: 10,
              ),
              MyBackButton(),
              SizedBox(
                height: 10,
              ),
              Text(
                'Add a Candidate',
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
                        field: 'Select Image',
                      ),
                      AuthTextField(
                        controller: imageName,
                        keyboardType: TextInputType.name,
                        labelText: 'Select Image ',
                        readOnly: true,
                        icon: Icons.image,
                        onTap: () async {
                          image = await ImageController().pickGalleryImage();
                          setState(() {
                            imageName.text = image!.name;
                          });
                        },
                      ),
                      AuthTextField(
                        controller: name,
                        keyboardType: TextInputType.name,
                        labelText: 'Full Name of Candidate',
                        maxlength: 40,
                        validator: (value) {
                          if (value.isEmpty) return 'Can\'t be empty';
                          return null;
                        },
                      ),
                      TextLabel(
                        field: 'Public Description',
                      ),
                      AuthTextField(
                        controller: publicDesc,
                        keyboardType: TextInputType.text,
                        labelText: 'Public Description',
                        maxline: 4,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Can\'t be empty!';
                          }
                          return null;
                        },
                      ),
                      TextLabel(
                        field: 'Short Biography',
                      ),
                      AuthTextField(
                        controller: bio,
                        labelText: 'Biography (Optional)',
                        keyboardType: TextInputType.text,
                        maxline: 5,
                      ),
                      TextLabel(
                        field: 'Description (Optional)',
                      ),
                      AuthTextField(
                        controller: description,
                        keyboardType: TextInputType.text,
                        labelText: 'Candidate Description',
                        maxline: 6,
                        maxlength: 250,
                      ),
                      TextLabel(
                        field: 'Social Links',
                      ),
                      AuthTextField(
                        controller: twitter,
                        keyboardType: TextInputType.text,
                        icon: FontAwesomeIcons.twitter,
                        labelText: 'Twitter link (Optional)',
                      ),
                      AuthTextField(
                        controller: facebook,
                        keyboardType: TextInputType.text,
                        icon: FontAwesomeIcons.facebook,
                        labelText: 'Facebook link (Optional)',
                      ),
                      MyButton(
                        onPress: addCandidate,
                        text: 'Create a Candidate',
                        width: 100.w,
                        loading: loading,
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void clearText() {
    name.clear();
    publicDesc.text = "";
    bio.text = "";
    description.text = "";
    facebook.clear();
    twitter.clear();
  }
}
