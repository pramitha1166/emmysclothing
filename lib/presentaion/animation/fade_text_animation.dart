import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeText extends StatefulWidget {
  Widget appText;
  Curve curve;
  Duration duration;

  FadeText(
      {Key? key,
      required this.appText,
      required this.curve,
      required this.duration})
      : super(key: key);

  @override
  _FadeTextState createState() => _FadeTextState();
}

class _FadeTextState extends State<FadeText> {
  @override
  Widget build(BuildContext context) {
    return PlayAnimation<double>(
      tween: Tween(begin: -150, end: 20),
      duration: widget.duration,
      curve: widget.curve,
      builder: (context, child, value) {
        return Transform.translate(
          offset: Offset(value, 0),
          child: child,
        );
      },
      child: widget.appText,
    );
  }
}
