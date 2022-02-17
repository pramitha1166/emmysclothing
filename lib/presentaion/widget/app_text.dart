import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  final FontWeight fontWeight;

  AppText(
      {Key? key,
      required this.size,
      required this.text,
      required this.color,
      required this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: size,
          fontFamily: 'OpenSans',
          letterSpacing: 0),
    );
  }
}
