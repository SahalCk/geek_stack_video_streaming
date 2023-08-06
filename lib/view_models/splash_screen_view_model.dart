// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geekstack/views/screens/screen_admin_login.dart';

class SplashScreenViewModel extends ChangeNotifier {
  Future<void> navigateToLoginPage(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AdminLoginScreen()));
  }
}
