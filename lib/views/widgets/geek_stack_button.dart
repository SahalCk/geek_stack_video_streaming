import 'package:flutter/material.dart';
import 'package:geekstack/utils/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GeekStackButton extends StatelessWidget {
  final Function() function;
  final String text;
  const GeekStackButton(
      {super.key, required this.function, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Adaptive.w(100),
      height: Adaptive.h(6.7),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13))),
          onPressed: function,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.red, fontSize: 19, fontWeight: FontWeight.bold),
          )),
    );
  }
}
