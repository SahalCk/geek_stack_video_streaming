import 'package:flutter/material.dart';
import 'package:geekstack/utils/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GeekStackVideoCard extends StatelessWidget {
  final String thumpnail;
  final String videoUrl;
  final String videoTitle;
  const GeekStackVideoCard(
      {super.key,
      required this.thumpnail,
      required this.videoUrl,
      required this.videoTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adaptive.h(30),
      width: Adaptive.w(100),
      decoration: BoxDecoration(
          color: cardColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  child: SizedBox(
                      width: Adaptive.w(100),
                      height: Adaptive.h(24),
                      child: Image.network(thumpnail, frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                        return child;
                      }, loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: LottieBuilder.asset(
                                'animations/laoding.json',
                                width: Adaptive.w(40),
                                height: Adaptive.h(18)),
                          );
                        }
                      }, fit: BoxFit.fill)))
            ],
          ),
          Expanded(
              child: Center(
                  child: SizedBox(
            width: Adaptive.w(90),
            child: Text(videoTitle,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(color: primaryColor, fontSize: 19)),
          )))
        ],
      ),
    );
  }
}
