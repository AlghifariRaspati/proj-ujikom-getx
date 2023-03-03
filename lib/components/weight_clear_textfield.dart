import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ujikom_getx/utils/colors.dart';

class WeightClearTextfield extends StatelessWidget {
  final dynamic controller;
  final String labelText;
  final TextInputType keyboardType;
  final void Function()? onPressed;
  final void Function(String)? onChanged;

  const WeightClearTextfield({
    Key? key,
    required this.onPressed,
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        autocorrect: false,
        keyboardType: keyboardType,
        controller: controller,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'[,. ]')),
        ],
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
          suffixText: 'Kg',
          suffixStyle: TextStyle(
              color: AppColor.appSecondary, fontWeight: FontWeight.bold),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
