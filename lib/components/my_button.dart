import 'package:flutter/material.dart';
import '../utils/colors.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final Color? color;
  final String text;

  const MyButton(
      {Key? key, required this.onTap, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: AppColor.appDarkGrey, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
