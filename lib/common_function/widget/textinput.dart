import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paytack/common_function/constants.dart';

class TInput extends StatelessWidget {
  final bool isEdit;
  final bool isError;
  final Widget? suffixIcon;
  final String label;
  final String? hintText;
  final Function? onChange;
  final double fieldWidth;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final int minLines;
  final int maxLines;
  final FocusNode? focusNode;
  final bool isInput;
  final bool disable;
  final bool isPadding;
  final String? type;
  final GlobalKey _globalKey = GlobalKey();

  TInput(
      {Key? key,
      this.isEdit = true,
      this.isError = false,
      this.minLines = 1,
      this.isInput = false,
      this.maxLines = 1,
      this.focusNode,
      this.inputFormatters,
      this.suffixIcon,
      this.fieldWidth = 45.0,
      this.keyboardType,
      this.controller,
      this.textInputAction,
      this.isPadding = false,
      this.label = "",
      this.hintText,
      required this.onChange,
      this.disable = false,
      this.type = 'B2'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: isPadding
          ? EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 4.0,
              ),
              child: _inputFormField(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputFormField(BuildContext context) {
    return Container(
      height: fieldWidth,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          readOnly: disable,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction,
          onChanged: (value) {
            if (value.toString() != 'null' || value.isNotEmpty) {
              onChange!(value);
            }
          },
          validator: (value) {
            return null;
          },
          minLines: minLines,
          maxLines: maxLines,
          focusNode: focusNode,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
            hintText: hintText,
            hintStyle: commonTextStyle(
              type: type!,
              weight: FontWeight.normal,
            ).copyWith(color: pDisableColor),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: pBorderGrey),
                borderRadius: BorderRadius.circular(10.0)
                //  when the TextFormField in unfocused
                ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: pPrimaryColor),
                borderRadius: BorderRadius.circular(10.0)

                //  when the TextFormField in focused
                ),
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: pBorderGrey)),
          ),
        ),
      ),
    );
  }
}

class DropdownItem {
  final String id;
  final String description;

  DropdownItem({
    required this.id,
    required this.description,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DropdownItem &&
        other.id == id &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ description.hashCode;
}
