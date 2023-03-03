import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ujikom_getx/utils/colors.dart';

class MyEmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const MyEmailTextField({
    Key? key,
    required this.controller,
    required this.hintText,
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
          filled: true,
          hintText: hintText,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          fillColor: Colors.grey.withOpacity(0.3),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.appSecondary))),
    );
  }
}
