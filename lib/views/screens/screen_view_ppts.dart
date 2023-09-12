import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geekstack/utils/colors.dart';
import 'package:geekstack/utils/sized_boxes.dart';
import 'package:geekstack/view_models/upload_ppt_view_model.dart';
import 'package:geekstack/views/widgets/geek_stack_snack_bars.dart';
import 'package:geekstack/views/widgets/geek_stack_text_form_field.dart';
import 'package:geekstack/views/widgets/ppt_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UploadedPPTsScreen extends StatelessWidget {
  UploadedPPTsScreen({super.key});
  final fileNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pptUploadController =
        Provider.of<UploadPPTViewModel>(context, listen: false);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: backgroundColor),
        child: Scaffold(
          body: SafeArea(
              child: Padding(
                  padding: EdgeInsets.all(Adaptive.h(2)),
                  child: Column(children: [
                    Text('Uploaded PPTs',
                        style: TextStyle(color: primaryColor, fontSize: 20)),
                    sizedBoxHeight20,
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('PPTs')
                          .snapshots(),
                      builder: (context, snapshot) {
                        pptUploadController.addValuesToList(snapshot);
                        if (snapshot.connectionState ==
                                ConnectionState.active ||
                            snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return Expanded(
                              child: GridView.builder(
                                itemCount: pptUploadController.allPPTs.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: Adaptive.w(3),
                                        mainAxisSpacing: Adaptive.h(1.5)),
                                itemBuilder: (context, index) {
                                  return PPTWidget(
                                      title: pptUploadController
                                          .allPPTs[index].fileName,
                                      pages: 42,
                                      fileUrl: pptUploadController
                                          .allPPTs[index].filePath);
                                },
                              ),
                            );
                          } else {
                            return const ScaffoldMessenger(
                                child: Text('Something went wrong'));
                          }
                        } else {
                          return Expanded(
                              child: Center(
                            child: LottieBuilder.asset(
                                'animations/laoding.json',
                                width: Adaptive.w(50),
                                height: Adaptive.h(20)),
                          ));
                        }
                      },
                    )
                  ]))),
          floatingActionButton: SizedBox(
            width: Adaptive.w(48),
            child: FloatingActionButton.extended(
                backgroundColor: primaryColor,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: const Text('Upload New PPT',
                            style: TextStyle(color: Colors.white)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        contentPadding: EdgeInsets.all(Adaptive.w(4)),
                        children: [
                          sizedBoxHeight10,
                          GeekStackTextFormField(
                              hint: 'Enter Presentation Name',
                              fieldName: 'Presentation Name',
                              prefixIcon:
                                  const Icon(Icons.file_open_rounded, size: 25),
                              controller: fileNameController),
                          sizedBoxHeight15,
                          SizedBox(
                            height: Adaptive.h(6),
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 2, color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                onPressed: () {
                                  Provider.of<UploadPPTViewModel>(context,
                                          listen: false)
                                      .selectPPTFile();
                                },
                                child: Consumer<UploadPPTViewModel>(
                                    builder: (context, value, child) {
                                  return Text(
                                    value.selectedPPT == null
                                        ? 'Choose PPT'
                                        : 'Change PPT',
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 17),
                                  );
                                })),
                          ),
                          Consumer<UploadPPTViewModel>(
                              builder: (context, value, child) {
                            return value.selectedPPTName != null
                                ? Text(
                                    value.selectedPPTName!,
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontStyle: FontStyle.italic),
                                  )
                                : const SizedBox();
                          }),
                          sizedBoxHeight30,
                          SizedBox(
                            height: Adaptive.h(6),
                            child: Consumer<UploadPPTViewModel>(
                              builder: (context, value, child) {
                                return ElevatedButton(
                                    onPressed: () async {
                                      if (fileNameController.text.isNotEmpty) {
                                        if (value.selectedPPT != null) {
                                          showDialog(
                                              context: context,
                                              builder: (context) => Center(
                                                    child: LottieBuilder.asset(
                                                        'animations/laoding.json',
                                                        width: Adaptive.w(50),
                                                        height: Adaptive.h(20)),
                                                  ));
                                          await Provider.of<UploadPPTViewModel>(
                                                  context,
                                                  listen: false)
                                              .uploadPPTDetails(
                                                  fileNameController.text,
                                                  context);
                                        } else {
                                          errorSnackBar(
                                              context, 'Choose PPT file');
                                        }
                                      } else {
                                        errorSnackBar(
                                            context, 'Enter File Name');
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        backgroundColor: primaryColor),
                                    child: const Text('Upload',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)));
                              },
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
                label: Row(
                  children: [
                    const Icon(Icons.file_open_rounded,
                        color: Colors.red, size: 32),
                    SizedBox(
                      width: Adaptive.w(2),
                    ),
                    const Text('Upload New PPT',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ],
                )),
          ),
        ));
  }
}
