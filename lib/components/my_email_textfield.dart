import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ujikom_getx/utils/colors.dart';

class MyEmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const MyEmailTextField({
    Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      controller: controller,
      inputFormatters: [
        FilteringTextInputFormatter.deny(
            RegExp(r'[!#<>?":_`~;[\]\\|=+)(*&^%$#!,\s]')),
      ],
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: AppColor.appSecondary,
          fontFamily: "Product Sans",
          fontSize: 14.sp,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.appSecondary),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color: AppColor.appSecondary),
        ),
      ),
    );
  }
}
