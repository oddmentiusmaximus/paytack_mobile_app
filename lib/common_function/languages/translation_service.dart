import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en_us.dart';

class TranslationService extends Translations {
  static final fallbackLocale = Locale('en', 'US');
  @override
  Map<String, Map<String, String>> get keys => {
    'en_us': en_us,
  };
}