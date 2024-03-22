import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ContactPage extends StatelessWidget {
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
      child: Container(
        padding: EdgeInsets.all(10),
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
            Container(
              height: 50,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: socialIcons.length,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        backgroundColor: AppStyle.primaryColor,
                        radius: 30,
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
              height: 40,
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
            Container(
              alignment: Alignment.center,
              width: 80.w,
              child: Form(
                child: Column(
                  children: [
                    VoteTextField(
                        keyboardType: TextInputType.name, labelText: 'Name'),
                    VoteTextField(
                        keyboardType: TextInputType.emailAddress,
                        labelText: 'Email Address'),
                    VoteTextField(
                        keyboardType: TextInputType.text, labelText: 'Subject'),
                    VoteTextField(
                        keyboardType: TextInputType.multiline,
                        labelText: 'Message'),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: MyButton(
                        text: 'Send',
                        width: 20.w,
                        elevation: 0,
                        height: 40,
                        textClr: Colors.green.shade800,
                        backClr: Color(0xff90EE90),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
