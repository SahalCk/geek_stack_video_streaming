// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geekstack/utils/colors.dart';
import 'package:geekstack/utils/sized_boxes.dart';
import 'package:geekstack/utils/text_styles.dart';
import 'package:geekstack/view_models/login_screen_view_model.dart';
import 'package:geekstack/views/widgets/geek_stack_button.dart';
import 'package:geekstack/views/widgets/geek_stack_text_form_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final _key = GlobalKey<FormState>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          SystemUiOverlayStyle.light.copyWith(statusBarColor: backgroundColor),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Adaptive.w(7)),
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    sizedBoxHeight60,
                    SizedBox(
                        width: Adaptive.w(40),
                        height: Adaptive.h(8),
                        child: Image.asset('assets/netflix_logo.png')),
                    sizedBoxHeight120,
                    Text('Login to Admin Panel', style: loginPageTextStyle),
                    sizedBoxHeight80,
                    GeekStackTextFormField(
                        hint: 'Enter Email',
                        fieldName: 'Email',
                        prefixIcon: const Icon(Icons.mail_rounded, size: 25),
                        controller: emailController),
                    sizedBoxHeight20,
                    GeekStackPasswordTextFormField(
                        hint: 'Enter Password',
                        prefixIcon: const Icon(Icons.lock, size: 25),
                        passwordController: passwordController),
                    sizedBoxHeight140,
                    GeekStackButton(
                        function: () {
                          if (_key.currentState!.validate()) {
                            showDialog(
                                context: context,
                                builder: (context) => Center(
                                      child: LottieBuilder.asset(
                                          'animations/laoding.json',
                                          width: Adaptive.w(50),
                                          height: Adaptive.h(20)),
                                    ));
                            Provider.of<LoginScreenViewModel>(context,
                                    listen: false)
                                .loginButtonClicked(
                                    context,
                                    emailController.text,
                                    passwordController.text);
                          }
                        },
                        text: 'Login')
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
