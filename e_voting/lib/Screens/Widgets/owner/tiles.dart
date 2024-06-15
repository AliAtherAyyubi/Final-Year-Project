import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OwnerTiles extends StatelessWidget {
  String fieldName;
  final IconData icon;
  //
  OwnerTiles({super.key, required this.fieldName, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 40,
        color: AppStyle.iconClr,
      ),
      title: Text(
        fieldName,
        style: AppStyle().h3.copyWith(fontWeight: FontWeight.w400),
      ),
      trailing: const Icon(
        Icons.arrow_forward,
        size: 30,
        weight: 20,
        color: AppStyle.iconClr,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      tileColor: Color.fromARGB(255, 168, 243, 206),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent)),
    );
  }
}
