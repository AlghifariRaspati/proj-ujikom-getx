import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ujikom_getx/utils/colors.dart';

class MyClearTextField extends StatelessWidget {
  final dynamic controller;
  final String labelText;
  final TextInputType keyboardType;

  final void Function()? onPressed;

  const MyClearTextField(
      {Key? key,
      required this.onPressed,
      required this.controller,
      required this.labelText,
      required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        autocorrect: false,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            filled: true,
            labelText: labelText,
            labelStyle: TextStyle(color: AppColor.appPrimary),
            fillColor: AppColor.appBase,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.appPrimary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.appPrimary),
            ),
            suffixIcon: IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.clear,
                color: AppColor.appPrimary,
              ),
            )),
      ),
    );
  }
}
