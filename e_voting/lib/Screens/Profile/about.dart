import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutContent extends StatelessWidget {
  const AboutContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // color: Colors.amber,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SHORT BIOGRAPHY',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'My name is Ana Pilar, but you can just call me Ani. I am 26 years old and I\'m currently living in Belgrano, CABA. This is my third year studying Architecture in the University UIX. Also, I am working as a part-time teacig assistant.',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'ELECTION MANIFESTO',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'I combine experience with passion. I am incredibly commited to advocating for you. My focus: better mental health resources, fairer assessments, and affordable on-campus living. Open communication, strong advocacy - that\'s my promise. Let\'s make our university thrive!',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
