import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/app_bar.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/discover/discover_page.dart';
import 'package:paytack/history_screen/presentation/view.dart';
import 'package:paytack/home/presentation/home_dashboard.dart';
import 'package:paytack/my_profile/presentation/my_profile.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int _selectedTabIndex = 0;

  List _pages = [
    HomeDashBoard(),
    GoogleMapsClonePage(),
    HistoryScreenPage(),
    MyProfileTab(),
  ];

  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedTabIndex],
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  Widget get bottomNavigationBar {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _selectedTabIndex,
          onTap: _changeIndex,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(rewards),
                size: 15,
                color: _selectedTabIndex == 0 ? pPrimaryColor : pBorderGrey,
              ),
              title: Text('Rewards',
                  style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: latoFont,
                      color: _selectedTabIndex == 0
                          ? pPrimaryColor
                          : pBottomNav)),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(discover),
                size: 15,
                color: _selectedTabIndex == 1 ? pPrimaryColor : pBorderGrey,
              ),
              title: Text('Discover',
                  style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: latoFont,
                      color: _selectedTabIndex == 1
                          ? pPrimaryColor
                          : pBottomNav)),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(history),
                  size: 15,
                  color:
                      _selectedTabIndex == 2 ? pPrimaryColor : pBorderGrey),
              title: Text('History',
                  style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: latoFont,
                      color: _selectedTabIndex == 2
                          ? pPrimaryColor
                          : pBottomNav)),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(meTab),
                size: 15,
                color: _selectedTabIndex == 3 ? pPrimaryColor : pBorderGrey,
              ),
              title: Text('Me',
                  style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: latoFont,
                      color: _selectedTabIndex == 3
                          ? pPrimaryColor
                          : pBottomNav)),
            ),
          ],
        ));
  }
}
