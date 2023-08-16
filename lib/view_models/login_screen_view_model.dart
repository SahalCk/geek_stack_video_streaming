// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geekstack/views/screens/screen_home.dart';
import 'package:geekstack/views/widgets/geek_stack_snack_bars.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreenViewModel extends ChangeNotifier {
  bool obscureValue = true;

  void changeObscure() {
    if (obscureValue == false) {
      obscureValue = true;
      notifyListeners();
    } else {
      obscureValue = false;
      notifyListeners();
    }
  }

  Future<void> loginButtonClicked(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      successSnackBar(context, 'Login Success');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.of(context).pop();
        errorSnackBar(context, 'Incorrect Email');
      } else if (e.code == 'wrong-password') {
        Navigator.of(context).pop();
        errorSnackBar(context, 'Incorrect Password');
      } else {
        Navigator.of(context).pop();
        errorSnackBar(context, e.toString());
      }
    }
  }

  Future<void> googleSigninButtonPressed(BuildContext context) async {
    UserCredential? userCredential = await loginWithGoogle(context);
    Navigator.of(context).pop();
    if (userCredential != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      errorSnackBar(context, 'Something went wrong');
    }
  }

  Future<UserCredential?> loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      errorSnackBar(context, e.toString());
      return null;
    }
  }
}
