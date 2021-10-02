import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatefulWidget {
  const AppWebView({Key? key}) : super(key: key);

  @override
  _AppWebViewState createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  WebViewController? controllerGlobal;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  WebViewController? webView;

  _onWillPop(BuildContext context) async {
    if (await controllerGlobal!.canGoBack()) {
      controllerGlobal!.goBack();
    } else {
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    var value = Get.arguments;
    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.indigoAccent,
        appBar: AppBar(
          leading: Container(),
          backgroundColor: pPrimaryColor,
          title: const Text('Profile'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  "https://p.kindpng.com/picc/s/180-1801316_elon-musk-png-clipart-elon-musk-transparent-png.png",
                  height: 150.0,
                  width: Get.width,
                ),
              ),
              pVerticalSpace(height: 20.0),
              TView(
                title: "Elon Musk",
                size: 35.0,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TView(
                    title: "Address:",
                    size: 22.0,
                    color: Colors.white,
                  ),
                  TView(
                    title: "Pretoria, South Africa",
                    size: 22.0,
                    color: Colors.white,
                  ),
                ],
              ),
              pVerticalSpace(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TView(
                    title: "Company Name:",
                    size: 22.0,
                    color: Colors.white,
                  ),
                  TView(
                    title: "SpaceX",
                    size: 22.0,
                    color: Colors.white,
                  ),
                ],
              ),
              pVerticalSpace(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Icon(Icons.call,color: Colors.white,size: 50.0,),
                 pHorizontalSpace(width: 20.0),
                 Icon(Icons.email,color: Colors.white,size: 50.0,),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
