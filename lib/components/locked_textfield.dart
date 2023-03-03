import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ujikom_getx/utils/colors.dart';

class LockedTextfield extends StatelessWidget {
  final TextEditingController controller;

  final String labelText;
  const LockedTextfield(
      {super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: AppColor.appSecondary),
      enabled: false,
      autocorrect: false,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: AppColor.appPrimary,
        ),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        fillColor: AppColor.appBase,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.appThree),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
