// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geekstack/models/movie_model.dart';
import 'package:geekstack/views/widgets/geek_stack_snack_bars.dart';
import 'package:image_picker/image_picker.dart';

class UploadVideoViewModel extends ChangeNotifier {
  Uint8List? imageToUpload;
  String? thumpnailImage;
  String? movie;
  double? videoUplaodPercentage;
  List<MovieModel> allMovies = [];
  List<QueryDocumentSnapshot<Object?>>? snapShotList;

  Future<void> uploadThumpnailImage(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      errorSnackBar(context, 'Something went wrong!');
      return;
    }

    String imagePath = image.path;
    thumpnailImage = imagePath;
    imageToUpload = await image.readAsBytes();
    notifyListeners();
  }

  Future<void> uploadMovie(BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) {
      return;
    }

    String videoPath = video.path;
    movie = videoPath;
    notifyListeners();
  }

  Future<void> uplaodVideo(BuildContext context, String movieTitle) async {
    try {
      videoUplaodPercentage = 0.0;
      notifyListeners();
      String thumpnailPath =
          await uploadImageToStorage(movieTitle, imageToUpload!);
      videoUplaodPercentage = 0.3;
      notifyListeners();
      final currentTime = DateTime.now();
      String videoPath =
          await uploadCompressedVideoToFirebase(currentTime.toString(), movie!);
      videoUplaodPercentage = 0.8;
      notifyListeners();
      await FirebaseFirestore.instance.collection('Movies').add({
        "MovieName": movieTitle,
        "Thumpnail": thumpnailPath,
        "VideoPath": videoPath
      });
      videoUplaodPercentage = 1.0;
      notifyListeners();
      Navigator.of(context).pop();
      successSnackBar(context, 'Movie Uplaoded Successfull!');
    } catch (e) {
      Navigator.of(context).pop();
      errorSnackBar(context, e.toString());
    }
  }

  Future<String> uploadCompressedVideoToFirebase(
      String videoID, String videoPath) async {
    try {
      UploadTask videoUplaodTask = FirebaseStorage.instance
          .ref()
          .child('Movies')
          .child(videoID)
          .putFile(File(videoPath));
      TaskSnapshot snapshot = await videoUplaodTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return '';
    }
  }

  Future<String> uploadImageToStorage(
      String movieName, Uint8List fileName) async {
    try {
      movieName = movieName.replaceAll(' ', '_');
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('MovieThumpnails')
          .child(movieName);
      UploadTask uploadTask = ref.putData(fileName);
      TaskSnapshot snapshot = await uploadTask;
      String dowloadUrl = await snapshot.ref.getDownloadURL();
      return dowloadUrl;
    } catch (e) {
      return '';
    }
  }

  void addValuesToList(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    List<QueryDocumentSnapshot<Object?>>? list = snapshot.data?.docs.toList();
    snapShotList = list;
    allMovies.clear();
    for (dynamic item in list!) {
      final model = MovieModel(
          thumpnail: item['Thumpnail'],
          videoUrl: item['VideoPath'],
          videoTitle: item['MovieName']);
      allMovies.add(model);
    }
  }
}
