import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ujikom_getx/utils/colors.dart';

class MyPassTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget suffixIcon;
  final bool obscureText;

  const MyPassTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.suffixIcon,
    this.obscureText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      inputFormatters: [
        FilteringTextInputFormatter.deny(
            RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%$#@!,.\s]')),
      ],
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: AppColor.appSecondary,
          fontFamily: "Product Sans",
          fontSize: 14.sp,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.appSecondary),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color: AppColor.appSecondary),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
