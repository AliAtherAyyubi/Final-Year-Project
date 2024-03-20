import 'package:flutter/material.dart';

class gap extends StatelessWidget {
  final double? Height;
  final double? Width;
  const gap({super.key, this.Height, this.Width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Height,
      width: Width,
    );
  }
}
