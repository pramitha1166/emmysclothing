import 'dart:ffi';

import 'package:ecommerce/presentaion/animation/fade_text_animation.dart';
import 'package:ecommerce/presentaion/animation/fade_text_animation_rain.dart';
import 'package:ecommerce/presentaion/misc/colors.dart';
import 'package:ecommerce/presentaion/widget/app_text.dart';
import 'package:ecommerce/screen/authentication_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class WelComeScreen extends StatefulWidget {
  const WelComeScreen({Key? key}) : super(key: key);

  @override
  _WelComeScreenState createState() => _WelComeScreenState();
}

class _WelComeScreenState extends State<WelComeScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;

  CustomAnimationControl _customAnimationControl =
      CustomAnimationControl.play; //state variable

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(color: AppColors.main),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              FadeTextRain(
                  duration: const Duration(microseconds: 500),
                  curve: Curves.bounceInOut,
                  appText: AppText(
                      size: 45,
                      text: "Welcome",
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              FadeText(
                  duration: const Duration(microseconds: 500),
                  curve: Curves.easeIn,
                  appText: AppText(
                      size: 20,
                      text: "The Sri Lanka's best online store.",
                      color: Colors.white,
                      fontWeight: FontWeight.normal)),
              const SizedBox(
                height: 400,
              ),
              PlayAnimation<double>(
                delay: const Duration(seconds: 1),
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                tween: Tween(begin: -350, end: 20),
                builder: (context, child, value) {
                  return Transform.translate(
                    offset: Offset(value, 0),
                    child: child,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 40),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.only(left: 150),
                        child: AppText(
                            size: 20,
                            text: "Tap to start",
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      )),
                      MirrorAnimation<double>(
                        tween: Tween(begin: 1, end: 1.5),
                        curve: Curves.elasticInOut,
                        duration: const Duration(seconds: 1),
                        builder: (context, child, value) {
                          return Transform.scale(
                            scale: value,
                            child: child,
                          );
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white),
                          child: IconButton(
                              onPressed: () {
                                /*Navigator.pushNamed(context, '/login',
                                    arguments: "data");*/

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/login",
                                  (route) => route.isFirst,
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_forward,
                                color: AppColors.main,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void toggleDirection() {
    setState(() {
      _customAnimationControl =
          (_customAnimationControl == CustomAnimationControl.play)
              ? CustomAnimationControl.playReverse
              : CustomAnimationControl.play;
    });
  }
}
