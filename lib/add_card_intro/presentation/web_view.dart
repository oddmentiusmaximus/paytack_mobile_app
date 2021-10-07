import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TinkIntegration extends StatefulWidget {
  const TinkIntegration({Key? key}) : super(key: key);

  @override
  _TinkIntegrationState createState() => _TinkIntegrationState();
}

class _TinkIntegrationState extends State<TinkIntegration> {
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
            initialUrl:
                'https://link.tink.com/1.0/account-check/?client_id=d19e4b22e7074164826c4074b2d6cffb&redirect_uri=https%3A%2F%2Fconsole.tink.com%2Fcallback&market=SE&locale=en_US&test=true',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
              controllerGlobal = webViewController;
            },
            onPageFinished: (val) {
              //Get.back();
              if (val.contains('error') || val.contains('message')) {
                var tokan = val.split('?error')[1];
                print(tokan[1]);
                print(tokan[3]);
                int idx = val.indexOf("?");
                List parts = [
                  val.substring(0, idx).trim(),
                  val.substring(idx + 1).trim()
                ];
                Navigator.pop(context, "Account Verification Failed");
              } else {
                if (val.contains('account_verification_report_id')) {
                  String result = val.substring(0, val.indexOf('='));
                  Navigator.pop(context, result);
                }
              }
            },
          ),
        ),
      ),
    );
  }

  void readJS() async {
    String html = await controllerGlobal!.evaluateJavascript(
        "window.document.getElementsByTagName('html')[0].outerHTML;");
    print(html);
  }
}
