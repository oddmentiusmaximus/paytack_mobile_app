import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/common_function/widget/textinput.dart';

import 'navigation.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Terms & conditions", isTrue: true),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 2.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ExpansionTile(
                      textColor: pPrimaryColor,
                      trailing: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: pIconColor),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                      ),
                      childrenPadding: EdgeInsets.symmetric(horizontal: 9.0),
                      title: TView(
                          title: data[index]['title'],
                          color: pTextColor,
                          size: 14.0,
                          align: TextAlign.start),
                      children: [
                        
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TView(
                            title: data[index]['description'],
                            color: pTextColor,
                            size: 12.0,
                            align: TextAlign.start,
                            isMaxLines: true,
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
