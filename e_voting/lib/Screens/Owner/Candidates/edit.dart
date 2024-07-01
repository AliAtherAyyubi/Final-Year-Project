import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:e_voting/Controllers/image_control.dart';
import 'package:e_voting/Database/candidate_db.dart';
import 'package:e_voting/Models/candidate.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditCandidateScreen extends StatefulWidget {
  CandidateModel? candidate;
  EditCandidateScreen({super.key, this.candidate});

  @override
  State<EditCandidateScreen> createState() => _EditCandidateScreenState();
}

class _EditCandidateScreenState extends State<EditCandidateScreen> {
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
  TextEditingController linkedIn = TextEditingController();
  TextEditingController imageName = TextEditingController();

  bool loading = false;
  XFile? image;

  fetchCandidate() {
    c = widget.candidate!;
    //
    name.text = c.name ?? "";
    bio.text = c.biography ?? "";
    publicDesc.text = c.publicDescription ?? "";
    description.text = c.description ?? "";
    facebook.text = c.links![0] ?? "";
    twitter.text = c.links![1] ?? "";
    linkedIn.text = c.links![2] ?? "";

    ////
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCandidate();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              SizedBox(
                height: 10,
              ),
              MyBackButton(),
              SizedBox(
                height: 10,
              ),
              Text(
                'Edit a Candidate',
                style: AppStyle().h2,
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: CircularProfileAvatar(
                  widget.candidate!.imageUrl ??
                      "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
                  radius: 80,
                  elevation: 10,
                ),
              ),
              SizedBox(
                height: 15,
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
                        icon: Icons.image,
                        readOnly: true,
                        onTap: () async {
                          image = await ImageController().pickGalleryImage();
                          setState(() {
                            imageName.text = image!.name;
                          });
                        },
                      ),
                      TextLabel(
                        field: 'Name',
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
                        field: 'Short Biography',
                      ),
                      AuthTextField(
                        controller: bio,
                        labelText: 'Biography',
                        keyboardType: TextInputType.text,
                        maxline: 4,
                      ),
                      TextLabel(
                        field: 'Public Description',
                      ),
                      AuthTextField(
                        controller: publicDesc,
                        keyboardType: TextInputType.text,
                        maxline: 3,
                        maxlength: 80,
                        labelText: 'Public Description',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Can\'t be empty!';
                          }
                          return null;
                        },
                      ),
                      TextLabel(
                        field: 'Description',
                      ),
                      AuthTextField(
                        controller: description,
                        keyboardType: TextInputType.text,
                        labelText: 'Description',
                        maxline: 5,
                        // maxlength: 250,
                      ),
                      TextLabel(
                        field: 'Social Links',
                      ),
                      AuthTextField(
                        controller: twitter,
                        keyboardType: TextInputType.text,
                        icon: FontAwesomeIcons.twitter,
                        labelText: 'Twitter link',
                      ),
                      AuthTextField(
                        controller: facebook,
                        keyboardType: TextInputType.text,
                        icon: FontAwesomeIcons.facebook,
                        labelText: 'Facebook link',
                      ),
                      AuthTextField(
                        controller: linkedIn,
                        keyboardType: TextInputType.text,
                        icon: FontAwesomeIcons.linkedinIn,
                        labelText: 'LinkedIn (Optional)',
                      ),
                      MyButton(
                        onPress: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            String? imageUrl = image != null
                                ? await ImageController()
                                    .uploadCandidateImage(image!)
                                : c.imageUrl;
                            c.name = name.text;
                            c.biography = bio.text;
                            c.publicDescription = publicDesc.text;
                            c.description = description.text;
                            c.links = [
                              facebook.text,
                              twitter.text,
                              linkedIn.text
                            ];
                            c.imageUrl = imageUrl;
                            await CandidateDB().updateCandidateById(c);
                            setState(() {
                              image = null;
                              loading = false;
                            });
                          }
                        },
                        text: 'Update a Candidate',
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
}
