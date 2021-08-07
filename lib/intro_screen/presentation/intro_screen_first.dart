import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/intro_screen/presentation/slide_model.dart';

class IntroFirst extends StatefulWidget {
  int index;

  IntroFirst({Key? key, this.index = 0}) : super(key: key);

  @override
  _IntroFirstState createState() => _IntroFirstState();
}

class _IntroFirstState extends State<IntroFirst> {
  @override
  Widget build(BuildContext context) {
    Widget? widgets;
    if (widget.index == 0) {
      widgets = first(widget.index);
    } else if (widget.index == 1) {
      widgets = second(widget.index);
    } else if (widget.index == 2) {
      widgets = third(widget.index);
    }else if(widget.index == 3){
      widgets = first(widget.index);
    }
    return Container(padding: EdgeInsets.all(22.0), child: widgets);
  }

  first(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          slideList[index].imageUrl,
          fit: BoxFit.contain,
          height: 100,
          width: 50,
        ),
        pVerticalSpace(
          height: 25.0,
        ),
        TView(
          title: slideList[index].title,
          color: pTextColor,
          weight: FontWeight.bold,
          align: TextAlign.left,
          size: 36.0,
        ),
        pVerticalSpace(
          height: 20.0,
        ),
        TView(
          title: slideList[index].description,
          align: TextAlign.left,
          color: pTextColor,
          size: 18.0,
        ),
      ],
    );
  }

  second(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        pVerticalSpace(
          height: 60.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TView(
            title: slideList[index].title,
            color: pTextColor,
            weight: FontWeight.bold,
            align: TextAlign.left,
            size: 36.0,

          ),
        ),
        pVerticalSpace(
          height: 15.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TView(
            title: slideList[index].description,
            align: TextAlign.left,
            color: pTextColor,
            size: 18.0,
          ),
        ),
        pVerticalSpace(
          height: 10.0,
        ),
        Expanded(
            child: Center(
                child:
                    Image.asset(slideList[index].imageUrl, fit: BoxFit.cover))),
        pVerticalSpace(
          height: 40.0,
        ),
      ],
    );
  }

  third(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        pVerticalSpace(
          height: 60.0,
        ),
        TView(
          title: slideList[index].title,
          color: pTextColor,
          weight: FontWeight.bold,
          align: TextAlign.left,
          size: 36.0,
        ),
        pVerticalSpace(
          height: 15.0,
        ),
        TView(
          title: slideList[index].description,
          align: TextAlign.left,
          color: pTextColor,
          size: 18.0,
        ),
        pVerticalSpace(
          height: 10.0,
        ),
        Expanded(
            child: Center(
                child:
                    Image.asset(slideList[index].imageUrl, fit: BoxFit.cover))),
        pVerticalSpace(
          height: 40.0,
        ),
      ],
    );
  }
}
