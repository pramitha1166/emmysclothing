import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final String image;
  final Color color;
  final double width;

  const AppButton(
      {Key? key, required this.image, required this.color, required this.width})
      : super(key: key);

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: widget.width,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: widget.color),
      child: Row(
        children: [
          Image.asset(
            widget.image,
            width: 100,
          )
        ],
      ),
    );
  }
}
