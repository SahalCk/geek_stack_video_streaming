import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewPPTScreen extends StatelessWidget {
  final String fileName;
  final String url;
  const ViewPPTScreen({super.key, required this.url, required this.fileName});

  @override
  Widget build(BuildContext context) {
    final StreamController<String> _streamController =
        StreamController<String>();
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(url));
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: StreamBuilder(
                stream: _streamController.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return OrientationBuilder(
                      builder: (BuildContext context, Orientation orientation) {
                    bool isPortrait = orientation == Orientation.portrait;
                    log(isPortrait.toString());
                    return isPortrait
                        ? Stack(
                            children: [
                              WebViewWidget(controller: controller),
                              Positioned(
                                  child: Container(
                                width: Adaptive.w(100),
                                height: Adaptive.h(6),
                                color: const Color.fromARGB(255, 34, 34, 34),
                                child: Center(
                                  child: Text(
                                    fileName,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                              Positioned(
                                  bottom: 60,
                                  left: Adaptive.w(34),
                                  right: 0,
                                  child: Container(
                                      height: Adaptive.h(4.5),
                                      color: Colors.transparent))
                            ],
                          )
                        : Stack(
                            children: [
                              WebViewWidget(controller: controller),
                              Positioned(
                                  bottom: Adaptive.h(17),
                                  left: Adaptive.w(17),
                                  right: Adaptive.w(53),
                                  child: Container(
                                      height: Adaptive.h(12),
                                      color: Colors.transparent))
                            ],
                          );
                  });
                })));
  }
}
