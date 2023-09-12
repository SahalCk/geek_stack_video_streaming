import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geekstack/utils/colors.dart';
import 'package:geekstack/utils/sized_boxes.dart';
import 'package:geekstack/view_models/upload_movie_view_model.dart';
import 'package:geekstack/views/screens/screen_upload_video.dart';
import 'package:geekstack/views/screens/screen_view_ppts.dart';
import 'package:geekstack/views/screens/screen_watch_movie.dart';
import 'package:geekstack/views/widgets/geek_stack_video_card.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieController =
        Provider.of<UploadVideoViewModel>(context, listen: false);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          SystemUiOverlayStyle.light.copyWith(statusBarColor: backgroundColor),
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(Adaptive.h(2)),
          child: Column(
            children: [
              Text('Uploaded Videos',
                  style: TextStyle(color: primaryColor, fontSize: 20)),
              sizedBoxHeight20,
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Movies').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      movieController.addValuesToList(snapshot);
                      return Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WatchMovieScreen(
                                                    index: index)));
                                  },
                                  child: GeekStackVideoCard(
                                      thumpnail: movieController
                                          .allMovies[index].thumpnail,
                                      videoUrl: movieController
                                          .allMovies[index].videoUrl,
                                      videoTitle: movieController
                                          .allMovies[index].videoTitle),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return sizedBoxHeight10;
                              },
                              itemCount: movieController.allMovies.length));
                    } else {
                      return const ScaffoldMessenger(
                          child: Text('Something went wrong'));
                    }
                  } else {
                    return Expanded(
                        child: Center(
                      child: LottieBuilder.asset('animations/laoding.json',
                          width: Adaptive.w(50), height: Adaptive.h(20)),
                    ));
                  }
                },
              )
            ],
          ),
        )),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Adaptive.w(48),
              child: FloatingActionButton.extended(
                  backgroundColor: primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UploadedPPTsScreen()));
                  },
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.video_file_rounded,
                          color: Colors.red, size: 32),
                      SizedBox(
                        width: Adaptive.w(2),
                      ),
                      const Text('View Videos',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  )),
            ),
            sizedBoxHeight10,
            SizedBox(
              width: Adaptive.w(48),
              child: FloatingActionButton.extended(
                  backgroundColor: primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UploadedPPTsScreen()));
                  },
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.file_open_rounded,
                          color: Colors.red, size: 32),
                      SizedBox(
                        width: Adaptive.w(2),
                      ),
                      const Text('View PPTs',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  )),
            ),
            sizedBoxHeight10,
            SizedBox(
              width: Adaptive.w(48),
              child: FloatingActionButton.extended(
                  backgroundColor: primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UploadVideoScreen()));
                  },
                  label: Row(
                    children: [
                      const Icon(Icons.movie, color: Colors.red, size: 32),
                      SizedBox(
                        width: Adaptive.w(2),
                      ),
                      const Text('Add New Movie',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
