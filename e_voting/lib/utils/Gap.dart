import 'package:flutter/material.dart';

class gap extends StatelessWidget {
  final double Height;
  final double Width;
  const gap({super.key, required this.Height, required this.Width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Height,
      width: Width,
    );
  }
}
