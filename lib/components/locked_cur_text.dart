import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ujikom_getx/utils/colors.dart';
import 'package:intl/intl.dart';

class LockedCurTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const LockedCurTextfield({
    Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);

    final formattedValue = currencyFormat.format(
      double.tryParse(controller.text) ?? 0,
    );

    controller.text = formattedValue;

    return TextField(
      style: TextStyle(
          color: Colors.grey.withOpacity(1), fontWeight: FontWeight.w500),
      enabled: false,
      autocorrect: false,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: AppColor.appPrimary,
        ),
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 10.h,
        ),
        fillColor: AppColor.appBase,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.appThree),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      textAlign: TextAlign.left,
    );
  }
}
