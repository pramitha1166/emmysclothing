import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeTextRain extends StatefulWidget {
  Widget appText;
  Curve curve;
  Duration duration;

  FadeTextRain(
      {Key? key,
      required this.appText,
      required this.curve,
      required this.duration})
      : super(key: key);

  @override
  _FadeTextRainState createState() => _FadeTextRainState();
}

class _FadeTextRainState extends State<FadeTextRain> {
  @override
  Widget build(BuildContext context) {
    return PlayAnimation<double>(
      tween: Tween(begin: -200, end: 0),
      duration: widget.duration,
      curve: widget.curve,
      builder: (context, child, value) {
        return Transform.translate(
          offset: Offset(20, value),
          child: child,
        );
      },
      child: widget.appText,
    );
  }
}
