import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: AppColor.appSecondary,
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Product Sans'),
    );
  }
}
