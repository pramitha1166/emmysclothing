import 'package:ecommerce/presentaion/misc/colors.dart';
import 'package:ecommerce/screen/authentication_wrapper.dart';
import 'package:ecommerce/screen/sign_up_screen.dart';
import 'package:ecommerce/screen/wecome_screen.dart';
import 'package:ecommerce/service/authentication_service.dart';
import 'package:ecommerce/service/product_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  FirebaseFirestore.instanceFor(app: app);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
        StreamProvider<QuerySnapshot?>.value(
            value: ProductService().sneakers_products, initialData: null),
        StreamProvider<QuerySnapshot?>.value(
            value: ProductService().watches_products, initialData: null)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(primary: AppColors.main),
            scaffoldBackgroundColor: const Color.fromARGB(253, 255, 255, 255)),
        initialRoute: "/",
        routes: {"/": (context) => const WelComeScreen()},
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return PageTransition(
                  child: const WelComeScreen(), type: PageTransitionType.fade);
            case '/login':
              return PageTransition(
                  child: const AuthenticationWrapper(),
                  type: PageTransitionType.rightToLeft);
            case '/signup':
              return PageTransition(
                  child: const SignUpScreen(),
                  type: PageTransitionType.rightToLeft);
          }
          return null;
        },
      ),
    );
  }
}
