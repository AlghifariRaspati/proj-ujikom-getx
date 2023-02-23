import 'package:flutter/material.dart';

import '../utils/colors.dart';

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
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        fillColor: Colors.grey.withOpacity(0.3),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
