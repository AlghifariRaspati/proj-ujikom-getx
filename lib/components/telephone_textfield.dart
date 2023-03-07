import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ujikom_getx/utils/colors.dart';

class TelephoneTextfield extends StatelessWidget {
  final dynamic controller;
  final String labelText;
  final TextInputType keyboardType;
  final void Function()? onPressed;
  final String? Function(String?)? validator; // Add validator parameter

  const TelephoneTextfield({
    Key? key,
    required this.onPressed,
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    this.validator, // Add validator parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        autocorrect: false,
        keyboardType: keyboardType,
        controller: controller,
        inputFormatters: [
          FilteringTextInputFormatter(
            RegExp(r'^[a-zA-Z0-9\-\s]+$'),
            allow: true,
          )
        ],
        maxLength: 12,
        validator: validator,
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
          ),
        ),
      ),
    );
  }
}

// Extract the validator function to a separate function
String? validateTelephoneNumber(String? value) {
  if (value == null || value.length < 11) {
    return 'Telephone number must have at least 11 characters';
  }
  return null;
}
