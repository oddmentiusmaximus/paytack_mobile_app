import 'package:flutter/material.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/languages/strings.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: intro_first,
    title: welcome_text,
    description: intro_first_text,
  ),
  Slide(
    imageUrl: intro_second,
    title: intro_second_title,
    description: intro_second_text,
  ),
  Slide(
    imageUrl: intro_third,
    title: intro_third_title,
    description: intro_third_text,
  ),
  Slide(
    imageUrl: intro_first,
    title: intro_four_title,
    description: intro_four_text,
  ),
];
