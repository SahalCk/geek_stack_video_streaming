// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geekstack/models/ppt_model.dart';
import 'package:geekstack/views/widgets/geek_stack_snack_bars.dart';

class UploadPPTViewModel extends ChangeNotifier {
  File? selectedPPT;
  String? selectedPPTName;
  List<PPTModel> allPPTs = [];

  Future<void> uploadPPTDetails(String fileName, BuildContext context) async {
    try {
      final downloadURL = await uploadPPTFile(fileName);
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      firebaseFirestore
          .collection('PPTs')
          .add({"pptName": fileName, "pptPath": downloadURL});
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      selectedPPT = null;
      selectedPPTName = null;
      notifyListeners();
      successSnackBar(context, '$fileName Uploaded Successfully');
    } catch (e) {
      Navigator.of(context).pop();
      selectedPPT = null;
      selectedPPTName = null;
      notifyListeners();
      errorSnackBar(context, e.toString());
    }
  }

  Future<String> uploadPPTFile(String fileName) async {
    final reference =
        FirebaseStorage.instance.ref().child("PPTs/$fileName.ppt");
    final uplaodTask = reference.putFile(selectedPPT!);
    await uplaodTask.whenComplete(() {});
    final downloadUrl = await reference.getDownloadURL();
    return downloadUrl;
  }

  Future<void> selectPPTFile() async {
    final pickedFile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['ppt', 'pptx']);

    if (pickedFile != null) {
      selectedPPTName = pickedFile.files[0].name;
      File file = File(pickedFile.files[0].path!);
      selectedPPT = file;
    }
    notifyListeners();
  }

  void addValuesToList(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    List<QueryDocumentSnapshot<Object?>>? list = snapshot.data?.docs.toList();
    allPPTs.clear();
    for (dynamic item in list!) {
      final model =
          PPTModel(fileName: item['pptName'], filePath: item['pptPath']);
      allPPTs.add(model);
    }
  }
}
