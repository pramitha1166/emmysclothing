import 'package:ecommerce/presentaion/misc/colors.dart';
import 'package:ecommerce/screen/authentication_wrapper.dart';
import 'package:ecommerce/service/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(primary: AppColors.main),
            scaffoldBackgroundColor: const Color.fromARGB(253, 255, 255, 255)),
        home: const AuthenticationWrapper(),
      ),
    );
  }
}
