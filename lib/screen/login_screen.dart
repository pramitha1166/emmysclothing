import 'package:ecommerce/presentaion/misc/colors.dart';
import 'package:ecommerce/presentaion/widget/app_text.dart';
import 'package:ecommerce/service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: ListView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            children: [
              const SizedBox(
                height: 150,
              ),
              AppText(
                  size: 40,
                  text: "Login",
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              AppText(
                  size: 15,
                  text: "Please sign in to continue",
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  TextField(
                    onTap: () {
                      scrollController
                          .jumpTo(scrollController.position.maxScrollExtent);
                    },
                    controller: emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                  TextField(
                    onTap: () {
                      scrollController
                          .jumpTo(scrollController.position.maxScrollExtent);
                    },
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: "Password"),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthenticationService>().signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim());
                      },
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.main),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                      child: AppText(
                          size: 15,
                          text: "Login",
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
