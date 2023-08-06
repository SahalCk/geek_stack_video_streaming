import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geekstack/utils/colors.dart';
import 'package:geekstack/utils/sized_boxes.dart';
import 'package:geekstack/view_models/upload_movie_view_model.dart';
import 'package:geekstack/views/widgets/geek_stack_button.dart';
import 'package:geekstack/views/widgets/geek_stack_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UploadVideoScreen extends StatelessWidget {
  const UploadVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieNameController = TextEditingController();
    final uploadVideoController =
        Provider.of<UploadVideoViewModel>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Adaptive.h(2)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Upload Movie',
                    style: TextStyle(color: primaryColor, fontSize: 20)),
                sizedBoxHeight20,
                GeekStackTextFormField(
                    hint: 'Enter Movie Name',
                    fieldName: 'Movie Name',
                    prefixIcon: const Icon(Icons.movie, size: 25),
                    controller: movieNameController),
                sizedBoxHeight20,
                InkWell(
                  onTap: () async {
                    await Provider.of<UploadVideoViewModel>(context,
                            listen: false)
                        .uploadThumpnailImage(context);
                  },
                  child: Consumer<UploadVideoViewModel>(
                    builder: (context, value, child) {
                      return Container(
                          height: Adaptive.h(30),
                          width: Adaptive.w(100),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: primaryColor,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(8)),
                          child: value.thumpnailImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.file(File(value.thumpnailImage!),
                                      fit: BoxFit.fill))
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: Adaptive.h(13),
                                        child:
                                            Image.asset('assets/upload.png')),
                                    const Text("Tap to Upload Thumpnail Image*",
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ));
                    },
                  ),
                ),
                sizedBoxHeight20,
                InkWell(
                  onTap: () async {
                    await uploadVideoController.uploadMovie(context);
                  },
                  child: Consumer<UploadVideoViewModel>(
                    builder: (context, value, child) {
                      return Container(
                          height: Adaptive.h(30),
                          width: Adaptive.w(100),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: primaryColor,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(8)),
                          child: value.movie != null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: Adaptive.h(13),
                                        child: Image.asset('assets/check.png')),
                                    sizedBoxHeight10,
                                    const Text(
                                        "Movie Selected.Tap to Change Movie",
                                        style: TextStyle(color: Colors.white))
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: Adaptive.h(13),
                                        child:
                                            Image.asset('assets/upload.png')),
                                    const Text("Tap to Upload Movie*",
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ));
                    },
                  ),
                ),
                sizedBoxHeight90,
                GeekStackButton(
                    function: () {
                      if (movieNameController.text.isNotEmpty &&
                          uploadVideoController.thumpnailImage != null &&
                          uploadVideoController.movie != null) {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) =>
                                Consumer<UploadVideoViewModel>(
                                  builder: (context, value, child) {
                                    return SimpleDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        contentPadding:
                                            EdgeInsets.all(Adaptive.w(2)),
                                        backgroundColor: Colors.white,
                                        children: [
                                          sizedBoxHeight30,
                                          Center(
                                            child: SizedBox(
                                              width: Adaptive.w(20),
                                              height: Adaptive.h(10),
                                              child: CircularProgressIndicator(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 245, 121, 112),
                                                color: Colors.red,
                                                value:
                                                    value.videoUplaodPercentage,
                                                strokeWidth: 10,
                                              ),
                                            ),
                                          ),
                                          sizedBoxHeight20,
                                          Text(
                                            value.videoUplaodPercentage != 1.0
                                                ? 'Movie is Uploading'
                                                : 'Movie Uploaded Successfully',
                                            textAlign: TextAlign.center,
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          sizedBoxHeight30,
                                        ]);
                                  },
                                ));
                        uploadVideoController.uplaodVideo(
                            context, movieNameController.text);
                      }
                    },
                    text: 'Upload Movie')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
