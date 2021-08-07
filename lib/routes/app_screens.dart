import 'package:get/get.dart';
import 'package:paytack/food_detail_page/presentation/detail_page.dart';
import 'package:paytack/home/presentation/home_screen.dart';
import 'package:paytack/intro_screen/presentation/getting_started_screen.dart';
import 'package:paytack/login_screen/login_screen.dart';
import 'package:paytack/near_by_all/presentation/near_by_screen.dart';
import 'package:paytack/set_pin/presentation/set_pin_screen.dart';
import 'package:paytack/sign_up/presentation/sign_up.dart';
import 'package:paytack/splash_screen/splash_screen.dart';
import 'package:paytack/verify_phone/presentation/verify_otp.dart';

part 'app_route.dart';

class AppScreens {
  static final all = [
    GetPage(
      name: AppRoute.splash,
      page: () => SplashScreen(),
      //binding: LocalAuthBinding(),
    ),
    GetPage(name: AppRoute.login, page: () => LoginScreen()),
    GetPage(name: AppRoute.onBoarding, page: () => GettingStartedScreen()),
    GetPage(name: AppRoute.signUp, page: () => SignUpScreen()),
    GetPage(name: AppRoute.setPin, page: () => SetPinScreen()),
    GetPage(name: AppRoute.homeLanding, page: () => HomePageLanding()),
    GetPage(name: AppRoute.verifyOtp, page: () => VerifyOtpScreen()),
    GetPage(name: AppRoute.login, page: () => LoginScreen()),
    GetPage(name: AppRoute.nearByAll, page: () => NearByAll()),
    GetPage(name: AppRoute.detailPage, page: () => DetailPage()),
  ];
}
