import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
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
import 'package:paytack/routes/app_screens.dart';

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
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          /// Backpress
          return Scaffold(
            body: _pages[_selectedTabIndex],
            bottomNavigationBar: bottomNavigationBar,
          );
        }

        /// No internet connection design
        else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform(
                      transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                      child: Image(
                        image: AssetImage('assets/images/no_internet.gif'),
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  TView(
                    title: "No Internet Connection",
                    size: 14.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TView(
                    title:
                        "Make sure Wi-Fi or cellular data is \n turned on and then try again",
                    size: 14.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed(AppRoute.splash);
                    },
                    child: TView(
                      title: "Retry Again",
                      color: Colors.white,
                      size: 15.0,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          pPrimaryColor), // <-- Button col,
                    ),
                  ),
                ],
              ),
            )),
            bottomNavigationBar: bottomNavigationBar,
          );
        }
      },
      child: Text('You are offline'),
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
                size: 18,
                color: _selectedTabIndex == 0 ? pPrimaryColor : pBorderGrey,
              ),
              title: TView(
                title: 'Rewards',
                size: 11,
                color: _selectedTabIndex == 0 ? pTextColor : pBottomNav,
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(discover),
                size: 18,
                color: _selectedTabIndex == 1 ? pPrimaryColor : pBorderGrey,
              ),
              title: TView(
                title: 'Discover',
                size: 11,
                color: _selectedTabIndex == 1 ? pTextColor : pBottomNav,
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(history),
                  size: 18,
                  color: _selectedTabIndex == 2 ? pPrimaryColor : pBorderGrey),
              title: TView(
                title: 'History',
                size: 11,
                color: _selectedTabIndex == 2 ? pTextColor : pBottomNav,
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(meTab),
                size: 18,
                color: _selectedTabIndex == 3 ? pPrimaryColor : pBorderGrey,
              ),
              title: TView(
                title: 'Me',
                size: 11,
                color: _selectedTabIndex == 3 ? pTextColor : pBottomNav,
              ),
            ),
          ],
        ));
  }
}
