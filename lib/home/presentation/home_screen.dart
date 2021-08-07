import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paytack/home/presentation/bottom_navigation_screen.dart';

class HomePageLanding extends StatefulWidget {
  const HomePageLanding({Key? key}) : super(key: key);

  @override
  _HomePageLandingState createState() => _HomePageLandingState();
}

class _HomePageLandingState extends State<HomePageLanding> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      bottomNavigationBar: BottomNavigationScreen(),
    );
  }
}
