import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ujikom_getx/utils/colors.dart';

class PaymentClearTextfield extends StatelessWidget {
  final dynamic controller;
  final String labelText;
  final TextInputType keyboardType;

  final void Function(String)? onChanged;

  const PaymentClearTextfield(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.keyboardType,
      this.onChanged})
      : super(key: key);

  String? validateNonZero(String? value) {
    if (value == null || value.isEmpty) {
      return 'Value cannot be empty.';
    } else if (value == "0") {
      return 'Value must be greater than zero.';
    } else if (value.startsWith("0")) {
      return 'Value must not start with zero.';
    }
    return null;
  }

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
        validator: validateNonZero,
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
        ),
        onChanged: onChanged,
      ),
    );
  }
}
