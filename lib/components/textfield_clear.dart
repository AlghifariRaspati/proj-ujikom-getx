import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';

class MyClearTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;

  // ignore: prefer_typing_uninitialized_variables
  final suffixIcon;

  const MyClearTextField({
    Key? key,
    required this.suffixIcon,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.w,
      child: TextField(
        autocorrect: false,
        controller: controller,
        decoration: InputDecoration(
            filled: true,
            hintText: hintText,
            fillColor: AppColor.appBase,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.appGrey)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.appSecondary)),
            suffixIcon: suffixIcon),
      ),
    );
  }
}
