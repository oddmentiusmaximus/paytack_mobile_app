import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paytack/intro_screen/presentation/intro_screen_first.dart';

class SlideItem extends StatelessWidget {
  final int index;

  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return IntroFirst(index:index);
  }
}
