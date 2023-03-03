import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ujikom_getx/utils/colors.dart';

class MyPassTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget suffixIcon;
  final bool obscureText;

  const MyPassTextField({
    Key? key,
    required this.controller,
    required this.hintText,
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
        filled: true,
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        fillColor: Colors.grey.withOpacity(0.3),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.appSecondary),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
