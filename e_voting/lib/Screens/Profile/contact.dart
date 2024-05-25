import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/Services/textControl.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ContactPage extends StatefulWidget {
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  var text = TextController().cnic;
  // const ContactPage({super.key});
  List<IconData> socialIcons = [
    FontAwesomeIcons.facebookF,
    FontAwesomeIcons.instagram,
    FontAwesomeIcons.twitter,
    FontAwesomeIcons.linkedinIn
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SOCIAL NETWORKS',
              style: AppStyle.textStyle2.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: socialIcons.length,
                  // padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 15),
                      child: CircleAvatar(
                        backgroundColor: AppStyle.primaryColor,
                        radius: 25,
                        child: Icon(
                          socialIcons[index],
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'CONTACT ME!',
              style: AppStyle.textStyle2.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              child: Column(
                children: [
                  FlatTextField(
                      controller: text,
                      keyboardType: TextInputType.name,
                      labelText: 'Name'),
                  FlatTextField(
                      keyboardType: TextInputType.emailAddress,
                      labelText: 'Email Address'),
                  FlatTextField(
                      keyboardType: TextInputType.text, labelText: 'Subject'),
                  FlatTextField(
                      keyboardType: TextInputType.text,
                      maxline: 4,
                      labelText: 'Message'),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: MyButton(
                      text: 'Send',
                      width: 30.w,
                      elevation: 0,
                      height: 40,
                      textClr: AppStyle.textClr,
                      backClr: Color.fromARGB(255, 191, 246, 191),
                      onPress: () {
                        Get.snackbar(
                          'Sent',
                          'Your message sent successfully',
                          backgroundColor: Colors.grey.shade300,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
