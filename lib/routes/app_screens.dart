import 'package:get/get.dart';
import 'package:paytack/add_card_intro/presentation/add_card_link.dart';
import 'package:paytack/add_card_intro/presentation/add_card_tink.dart';
import 'package:paytack/add_card_intro/presentation/web_view.dart';
import 'package:paytack/cashout_screens/application/binding.dart';
import 'package:paytack/cashout_screens/presentation/bank_details_cashout.dart';
import 'package:paytack/cashout_screens/presentation/view.dart';
import 'package:paytack/discover/discover_page.dart';
import 'package:paytack/discover/search_page.dart';
import 'package:paytack/food_detail_page/application/bindings/detail_page_binding.dart';
import 'package:paytack/food_detail_page/presentation/detail_page.dart';
import 'package:paytack/home/application/bindings/dashboard_binding.dart';
import 'package:paytack/home/presentation/demo_bank.dart';
import 'package:paytack/home/presentation/home_screen.dart';

import 'package:paytack/intro_screen/presentation/getting_started_screen.dart';
import 'package:paytack/login_screen/presentation/login_screen.dart';
import 'package:paytack/login_screen/application/bindings/login_binding.dart';
import 'package:paytack/login_screen/presentation/set_forgot_screen.dart';
import 'package:paytack/my_profile/presentation/change_email/change_email.dart';
import 'package:paytack/my_profile/presentation/change_phone_no/change_phone_no.dart';
import 'package:paytack/my_profile/presentation/change_pin/change_pin.dart';
import 'package:paytack/my_profile/presentation/need_help/need_help.dart';
import 'package:paytack/my_profile/presentation/refer_earn/refer_earn.dart';
import 'package:paytack/my_profile/presentation/terms_and_condition/terms_and_condition.dart';
import 'package:paytack/near_by_all/presentation/near_by_screen.dart';
import 'package:paytack/optional_details_screen/presentation/optional_details.dart';
import 'package:paytack/permissions_screen/application/binding.dart';
import 'package:paytack/permissions_screen/presentation/permissions_screen.dart';

import 'package:paytack/set_pin/presentation/set_pin_screen.dart';
import 'package:paytack/sign_up/application/bindings/signin_binding.dart';
import 'package:paytack/sign_up/presentation/sign_up.dart';
import 'package:paytack/splash_screen/splash_screen.dart';

part 'app_route.dart';

class AppScreens {
  static final all = [
    GetPage(
      name: AppRoute.splash,
      page: () => SplashScreen(),
      //binding: LocalAuthBinding(),
    ),
    GetPage(
        name: AppRoute.login,
        page: () => LoginScreen(),
        binding: LoginBinding()),
    GetPage(name: AppRoute.onBoarding, page: () => GettingStartedScreen()),
    GetPage(
        name: AppRoute.signUp,
        page: () => SignUpScreen(),
        binding: SignUpBinding()),
    GetPage(
      name: AppRoute.setPin,
      page: () => SetPinScreen(),
    ),
    GetPage(
      name: AppRoute.webview,
      page: () => TinkIntegration(),
    ),
    GetPage(
      name: AppRoute.search_page,
      page: () => SearchPage(),
    ),
    GetPage(
        name: AppRoute.homeLanding,
        page: () => HomePageLanding(),
        binding: DashBoardBinding()),

    // GetPage(name: AppRoute.verifyOtp, page: () => VerifyOtpScreen()),
    GetPage(name: AppRoute.login, page: () => LoginScreen()),
    GetPage(name: AppRoute.nearByAll, page: () => NearByAll()),
    GetPage(name: AppRoute.changeEmail, page: () => ChangeEmailID()),
    GetPage(
        name: AppRoute.detailPage,
        page: () => DetailPage(),
        binding: DetailPageBinding()),
    GetPage(name: AppRoute.addCard, page: () => AddCardIntro()),
    GetPage(
        name: AppRoute.permissions,
        page: () => PermissionsScreen(),
        binding: PermissionBinding()),
    GetPage(
        name: AppRoute.optionalDetails, page: () => OptionalDetailsScreen()),
    GetPage(name: AppRoute.discover_page, page: () => GoogleMapsClonePage()),
    GetPage(name: AppRoute.need_help, page: () => NeedHelp()),
    GetPage(name: AppRoute.refer_earn, page: () => ReferEarn()),
    GetPage(name: AppRoute.terms_condition, page: () => TermsAndCondition()),
    GetPage(name: AppRoute.changePin, page: () => ChangePinPage()),
    GetPage(name: AppRoute.changePhoneNo, page: () => ChangePhoneNoPage()),
    GetPage(name: AppRoute.bankDetailsPage, page: () => CashoutBankDetails()),
    GetPage(name: AppRoute.addTinkCard, page: () => AddTinkCard()),
    GetPage(name: AppRoute.setForgotPassword, page: () => SetForgotPinScreen()),
    GetPage(name: AppRoute.nordiGen, page: () => BankAppExample()),
    GetPage(
        name: AppRoute.cashoutPage,
        page: () => CashoutScreenPage(),
        binding: CashoutScreenBinding()),
  ];
}
