import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/widget/mytext.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  final Size preferredSize;

  Header({Key? key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      // centerTitle: true,
      title: Container(
        child: Row(
          children: [
            Image.asset(logo_mark),
          ],
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(left: 10.0),
          child: const Icon(
            Icons.search,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10.0, left: 10.0),
          child: const Icon(
            Icons.notifications_none_outlined,
          ),
        ),
      ],
    );
  }
}

class UiHeader extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final String? subTitle;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Size preferredSize;
  final Widget? icon;
  final Widget? leadingIcon;

  UiHeader({
    this.title,
    this.subTitle,
    this.bottom,
    this.actions,
    this.icon,
    this.leadingIcon,
    Key? key,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: leadingIcon,
      title: Row(
        children: [
          icon! != null ? icon! : Container(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title != null
                  ? TView(
                      title: title!,
                      color: Colors.white,
                      weight: FontWeight.bold,
                    )
                  : Container(),
              subTitle != null
                  ? TView(
                      title: subTitle!,
                      color: Colors.white,
                    )
                  : Container(),
            ],
          )
        ],
      ),
      automaticallyImplyLeading: true,
      // bottom: bottom,
      // actions: [
      //   ...actions,
      // ],
    );
  }
}

class UiHeaderWithLeading extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final String? subTitle;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Size preferredSize;
  final Widget? icon;
  final Widget? leadingIcon;

  UiHeaderWithLeading({
    this.title,
    this.subTitle,
    this.bottom,
    this.actions,
    this.icon,
    Key? key,
    this.leadingIcon,
  })  : preferredSize = Size.fromHeight(80.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: leadingIcon!,
        onPressed: () {
          Get.back();
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon! != null ? icon! : Container(),
          SizedBox(
            width: 6,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title != null
                  ? TView(
                      title: title!,
                      color: Colors.white,
                      weight: FontWeight.bold,
                    )
                  : Container(),
              subTitle != null
                  ? TView(
                      title: subTitle!,
                      color: Colors.white,
                    )
                  : Container(),
            ],
          )
        ],
      ),
      automaticallyImplyLeading: true,
      // bottom: bottom,
      // actions: [
      //   ...actions,
      // ],
    );
  }
}
