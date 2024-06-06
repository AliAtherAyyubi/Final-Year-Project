import 'package:flutter/material.dart';

class EmptyImage extends StatelessWidget {
  const EmptyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('assets/images/empty.png'),
      height: 300,
      width: 300,
    );
  }
}
