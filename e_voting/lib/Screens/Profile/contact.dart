import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  List<dynamic> links = [];

  // const ContactPage({super.key});
  List<IconData> socialIcons = [
    FontAwesomeIcons.facebookF,
    // FontAwesomeIcons.instagram,
    FontAwesomeIcons.twitter,
    FontAwesomeIcons.linkedinIn
  ];
//
  ContactPage({required this.links});
  //

  Future<void> openLink(String url) async {
    //
    Uri _url = Uri.parse(url);
    bool isExist = await launchUrl(_url);
    if (!isExist) {
      throw Exception('Could not launch $_url');
    }
  }

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
                    return GestureDetector(
                      onTap: () async {
                        await openLink(links[index] ?? "");
                      },
                      child: Container(
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
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
