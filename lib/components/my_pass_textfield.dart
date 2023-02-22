import 'package:flutter/material.dart';

import '../utils/colors.dart';

// ignore: must_be_immutable
class MyPassTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  // ignore: prefer_typing_uninitialized_variables
  final suffixIcon;
  // ignore: prefer_typing_uninitialized_variables
  final obscureText;

  const MyPassTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.suffixIcon,
      required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        fillColor: AppColor.appBase,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColor.appGrey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColor.appGrey)),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
