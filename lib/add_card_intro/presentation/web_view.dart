import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:malgudi/colors.dart';
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
    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context);
      },
      child: Scaffold(
        /*appBar: AppBar(
          leading: Container(),
          backgroundColor: kPrimaryColor,
          title: const Text('Malgudi'),
        ),*/
        body: SafeArea(
          child: WebView(
            initialUrl: 'https://www.malgudi.in/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
              controllerGlobal = webViewController;
            },
          ),
        ),
      ),
    );
  }
}
