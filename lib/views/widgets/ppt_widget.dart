import 'package:flutter/material.dart';
import 'package:geekstack/utils/sized_boxes.dart';
import 'package:geekstack/views/screens/screen_view_ppt.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PPTWidget extends StatelessWidget {
  final String title;
  final int pages;
  final String fileUrl;
  const PPTWidget(
      {super.key,
      required this.title,
      required this.pages,
      required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ViewPPTScreen(
                fileName: title,
                url:
                    'https://docs.google.com/presentation/d/1P8t6qkqoNY_Qww6xtYD9WRvA0WxZLu1-/edit?usp=drive_link&ouid=104039944042402240964&rtpof=true&sd=true')));
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Adaptive.w(2.5), vertical: Adaptive.h(1.2)),
        height: Adaptive.h(12),
        width: Adaptive.w(35),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/ppt.png',
              width: Adaptive.w(13),
            ),
            sizedBoxHeight20,
            Text(
              title,
              style:
                  const TextStyle(height: 0, color: Colors.white, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
