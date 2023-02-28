import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ujikom_getx/utils/colors.dart';

class CurTextfield extends StatelessWidget {
  final dynamic controller;
  final String labelText;
  final TextInputType keyboardType;

  final void Function()? onPressed;

  const CurTextfield(
      {Key? key,
      required this.onPressed,
      required this.controller,
      required this.labelText,
      required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);

    final formattedValue = currencyFormat.format(
      double.tryParse(controller.text) ?? 0,
    );

    controller.text = formattedValue;
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
      textAlign: TextAlign.left,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CurrencyFormatter(
          decimalDigits: 0,
          locale: 'id_ID',
          symbol: 'Rp.',
        ),
      ],
    ));
  }
}

class CurrencyFormatter extends TextInputFormatter {
  final NumberFormat _numberFormat;

  CurrencyFormatter({
    int decimalDigits = 0,
    String locale = '',
    String symbol = '',
  }) : _numberFormat = NumberFormat.currency(
            decimalDigits: decimalDigits, locale: locale, symbol: symbol);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final parsedValue = int.tryParse(newValue.text);
    if (parsedValue == null) {
      // Return the old value if the new value cannot be parsed.
      return oldValue;
    }
    final formattedValue = _numberFormat.format(parsedValue);
    final selectionIndex = newValue.selection.baseOffset -
        newValue.text.length +
        formattedValue.length;
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
