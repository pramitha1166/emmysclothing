import 'package:ecommerce/presentaion/misc/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
          child: Row(
            children: [
              const Icon(
                Icons.menu,
                size: 20,
                color: Colors.black38,
              ),
              Expanded(child: Container()),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.mainColor.withOpacity(0.5)),
              )
            ],
          ),
        )
      ],
    ));
  }
}
