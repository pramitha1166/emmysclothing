import 'package:ecommerce/presentaion/misc/colors.dart';
import 'package:ecommerce/presentaion/widget/app_button.dart';
import 'package:ecommerce/presentaion/widget/app_large_text.dart';
import 'package:ecommerce/presentaion/widget/app_text.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = ['welcome-one.png', 'welcome-two.png', 'welcome-three.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: images.length,
        itemBuilder: (_, index) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("img/" + images[index]),
                    fit: BoxFit.cover)),
            child: Container(
              margin: const EdgeInsets.only(top: 150, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLargeText(text: "Trips"),
                      AppText(
                        size: 45,
                        text: "Mountain",
                        color: Colors.black26,
                        fontWeight: FontWeight.w300,
                      ),
                      Container(
                        width: 250,
                        margin: const EdgeInsets.only(top: 20),
                        child: AppText(
                            size: 13,
                            text:
                                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna.',
                            color: Colors.black26,
                            fontWeight: FontWeight.w400),
                      ),
                      const AppButton(
                          image: "img/button-one.png",
                          color: AppColors.mainColor,
                          width: 100)
                    ],
                  ),
                  Column(
                    children: List.generate(3, (dotIndex) {
                      return Container(
                        width: 10,
                        height: index == dotIndex ? 50 : 10,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                            color: index == dotIndex
                                ? AppColors.mainColor
                                : AppColors.mainColor.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10)),
                      );
                    }),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
