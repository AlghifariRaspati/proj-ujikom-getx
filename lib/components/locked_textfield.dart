import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LockedTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const LockedTextfield({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      autocorrect: false,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        fillColor: Colors.grey.withOpacity(0.3),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
