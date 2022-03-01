import 'package:ecommerce/presentaion/misc/colors.dart';
import 'package:ecommerce/presentaion/widget/app_text.dart';
import 'package:ecommerce/service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PlayAnimation<double>(
          tween: Tween(begin: 0, end: 1),
          curve: Curves.bounceInOut,
          builder: (context, child, value) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          },
          duration: const Duration(milliseconds: 1000),
          child: Container(
            margin: const EdgeInsets.all(20),
            child: ListView(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                AppText(
                    size: 40,
                    text: "Signup",
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                AppText(
                    size: 15,
                    text: "Please sign up to continue",
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthenticationService>().signUp(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim());
                        },
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.main),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        child: AppText(
                            size: 15,
                            text: "Signup",
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                        size: 15,
                        text: "Or Signup with",
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInButton(Buttons.Google, onPressed: () {
                      context
                          .read<AuthenticationService>()
                          .signUpWithGoogle()
                          .then((value) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/login", (route) => route.isCurrent);
                      });
                    }),
                    SignInButton(Buttons.FacebookNew, onPressed: () {})
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                        size: 16,
                        text: "Already signup?",
                        color: Colors.black38,
                        fontWeight: FontWeight.normal),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      child: AppText(
                          size: 16,
                          text: "Log in",
                          color: Colors.blue,
                          fontWeight: FontWeight.normal),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
