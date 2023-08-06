import 'dart:developer';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geekstack/utils/colors.dart';
import 'package:geekstack/utils/sized_boxes.dart';
import 'package:geekstack/view_models/upload_movie_view_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WatchMovieScreen extends StatelessWidget {
  final int index;
  const WatchMovieScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final movieController =
        Provider.of<UploadVideoViewModel>(context, listen: false);
    log(movieController.allMovies[index].videoUrl);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: backgroundColor),
        child: Scaffold(
            body: SafeArea(
                child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white)),
              Text(movieController.allMovies[index].videoTitle,
                  style: TextStyle(color: primaryColor, fontSize: 20)),
              IconButton(
                  onPressed: () {},
                  icon:
                      const Icon(Icons.download_rounded, color: Colors.white)),
            ],
          ),
          sizedBoxHeight20,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Adaptive.h(1.8)),
            child: Column(
              children: [
                Container(
                  width: Adaptive.w(100),
                  height: Adaptive.h(28),
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: BetterPlayer.network(
                      movieController.allMovies[index].videoUrl,
                      betterPlayerConfiguration: BetterPlayerConfiguration(
                          placeholder: Image.network(
                              movieController.allMovies[index].thumpnail,
                              fit: BoxFit.fill),
                          showPlaceholderUntilPlay: true,
                          fit: BoxFit.fill)),
                ),
                sizedBoxHeight20,
                SizedBox(
                  width: Adaptive.w(100),
                  child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                      style: TextStyle(color: hintColor)),
                )
              ],
            ),
          ),
        ]))));
  }
}
