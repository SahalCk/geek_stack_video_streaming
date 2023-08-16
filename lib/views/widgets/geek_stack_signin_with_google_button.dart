import 'package:flutter/material.dart';
import 'package:geekstack/utils/colors.dart';
import 'package:geekstack/view_models/login_screen_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Adaptive.w(100),
      height: Adaptive.h(6.7),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13))),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => Center(
                      child: LottieBuilder.asset('animations/laoding.json',
                          width: Adaptive.w(50), height: Adaptive.h(20)),
                    ));
            Provider.of<LoginScreenViewModel>(context, listen: false)
                .googleSigninButtonPressed(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/google_logo.png',
                width: Adaptive.w(7),
                height: Adaptive.h(7),
              ),
              SizedBox(
                width: Adaptive.w(5),
              ),
              Text(
                'Sign in with Google',
                style: TextStyle(
                    color: hintColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
