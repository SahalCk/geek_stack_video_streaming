import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geekstack/utils/colors.dart';
import 'package:geekstack/view_models/splash_screen_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashScreenViewModel>(context, listen: false)
        .navigateToLoginPage(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          SystemUiOverlayStyle.light.copyWith(statusBarColor: backgroundColor),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
                height: Adaptive.h(40),
                width: Adaptive.w(75),
                child: LottieBuilder.asset('animations/netflix.json',
                    repeat: false)),
          ),
        ),
      ),
    );
  }
}
