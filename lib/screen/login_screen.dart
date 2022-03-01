import 'package:ecommerce/presentaion/misc/colors.dart';
import 'package:ecommerce/presentaion/widget/app_text.dart';
import 'package:ecommerce/presentaion/widget/loading_page.dart';
import 'package:ecommerce/service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: isLoading
            ? const LoadingPage()
            : PlayAnimation<double>(
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
                        height: 80,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            onTap: () {
                              scrollController.jumpTo(
                                  scrollController.position.maxScrollExtent);
                            },
                            controller: emailController,
                            decoration:
                                const InputDecoration(labelText: "Email"),
                          ),
                          TextField(
                            onTap: () {
                              scrollController.jumpTo(
                                  scrollController.position.maxScrollExtent);
                            },
                            obscureText: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            controller: passwordController,
                            decoration:
                                const InputDecoration(labelText: "Password"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            child: AppText(
                                size: 12,
                                text: "Forgot Password?",
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          )
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
                                context.read<AuthenticationService>().signIn(
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                              size: 15,
                              text: "Or Signin with",
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
                          SignInButton(Buttons.Google, onPressed: () async {
                            await context
                                .read<AuthenticationService>()
                                .signInWithGoogle();
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
                              text: "Dont have account?",
                              color: Colors.black38,
                              fontWeight: FontWeight.normal),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            child: AppText(
                                size: 16,
                                text: "Sign up",
                                color: Colors.blue,
                                fontWeight: FontWeight.normal),
                            onTap: () {
                              Navigator.pushNamed(context, "/signup");
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
