import 'package:flutter/material.dart';

import '../utils/colors.dart';

class MyEmailTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  // ignore: prefer_typing_uninitialized_variables
  final keyboardType;

  const MyEmailTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      autocorrect: false,
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          fillColor: AppColor.appBase,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.appGrey)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlue))),
    );
  }
}
