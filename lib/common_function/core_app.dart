import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/languages/translation_service.dart';
import 'package:paytack/common_function/paytack_theme.dart';
import 'package:paytack/routes/app_screens.dart';

class AppConfig extends StatefulWidget {
  const AppConfig({Key? key}) : super(key: key);

  @override
  _AppConfigState createState() => _AppConfigState();
}

class _AppConfigState extends State<AppConfig> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetMaterialApp(
      theme: PayTackTheme.lightPayTackTheme,
      debugShowCheckedModeBanner: false,
      getPages: AppScreens.all,
      initialRoute: AppRoute.splash,
      enableLog: true,
      navigatorKey: Get.key,
      locale: Locale('en', 'US'),
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
    );
  }
}
