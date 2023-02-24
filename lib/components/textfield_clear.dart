import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyClearTextField extends StatelessWidget {
  final dynamic controller;
  final String hintText;
  final TextInputType keyboardType;

  final onPressed;

  const MyClearTextField(
      {Key? key,
      required this.onPressed,
      required this.controller,
      required this.hintText,
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
            hintText: hintText,
            fillColor: Colors.grey.withOpacity(0.3),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
            suffixIcon: IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.clear,
              ),
            )),
      ),
    );
  }
}
