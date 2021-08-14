import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    // give the current args from currentScreen
    String args = Get.arguments;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  Image.network(
                    args,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: Get.height * 0.4,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                      child: Material(
                        color: Colors.white, // Button color
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Center(
                                  child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                              ))),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  children: <Widget>[],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
