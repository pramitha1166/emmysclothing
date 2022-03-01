import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Sign in";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final User? user = _firebaseAuth.currentUser;

      return user;
    } on FirebaseException catch (e) {
      print(e.message);
      return null;
    }
  }

  Future<String> signOut() async {
    await _firebaseAuth.signOut().then((value) {
      _googleSignIn.signOut();
    });
    return "Sign out success";
  }

  Future<String> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return "Created User";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount == null) return false;
      final googleAuth = await googleSignInAccount.authentication;

      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credentials);
      return true;
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      return false;
    }
  }

  Future signUpWithGoogle() async {
    try {
      final googleSignInAccount =
          await _googleSignIn.signIn().catchError((onErr) => null);

      if (googleSignInAccount == null) return;
      final googleAuth = await googleSignInAccount.authentication;

      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
