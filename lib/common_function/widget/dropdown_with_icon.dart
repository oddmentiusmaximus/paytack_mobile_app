import 'package:flutter/material.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/common_function/widget/textinput.dart';

class MyDropDown extends StatelessWidget {
  List<DropdownItem> items;
  final IconData icon;
  final DropdownItem selectedValue;
  final String hintText;
  final Function onChange;

  MyDropDown(
      {Key? key,
      required this.items,
      required this.icon,
      this.hintText = "",
      required this.selectedValue,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 0.3,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            30.0,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 10.0),
          Icon(
            icon,
            color: Colors.red.withOpacity(0.7),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: DropdownButton<DropdownItem>(
              hint: TView(
                title: hintText,
                color: pTextColors,
                size: 12.0,
              ),
              isExpanded: true,
              value: selectedValue,
              items: items.map(
                (DropdownItem value) {
                  print(items.toString());
                  return new DropdownMenuItem<DropdownItem>(
                    value: value,
                    child: new Text(
                      value.description,
                      style: commonTextStyle(),
                      textScaleFactor: 1.0,
                    ),
                  );
                },
              ).toList(),
              onChanged: (value) {
                onChange(value);
              },
              underline: Container(),
            ),
          )
        ],
      ),
    );
  }
}

