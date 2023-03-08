import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:ujikom_getx/app/data/models/transactions_model.dart';

import '../../../../utils/colors.dart';
import '../controllers/trans_log_details_controller.dart';

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

class TransLogDetailsView extends GetView<TransLogDetailsController> {
  TransLogDetailsView({Key? key}) : super(key: key);
  final TransLogsModel product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appFive,
      appBar: AppBar(
        leading: IconButton(
          iconSize: 24,
          color: AppColor.appBase,
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Details of Transaction Log',
          style: TextStyle(
              fontFamily: "Product Sans", fontWeight: FontWeight.w500),
        ),
        backgroundColor: AppColor.appPrimary,
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 1,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer',
                        style: TextStyle(
                            fontFamily: "Product Sans",
                            fontSize: 14.sp,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      Text(
                        product.namaPelanggan,
                        style: const TextStyle(fontFamily: "Product Sans"),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Telephone',
                        style: TextStyle(
                            fontFamily: "Product Sans",
                            fontSize: 14.sp,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      Row(
                        children: [
                          const Text(
                            "+62 ",
                            style: TextStyle(fontFamily: "Product Sans"),
                          ),
                          Text(
                            product.nomorTelepon.toString(),
                            style: const TextStyle(fontFamily: "Product Sans"),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Created at',
                        style: TextStyle(
                            fontFamily: "Product Sans",
                            fontSize: 14.sp,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      Text(
                        DateFormat("yyyy-MM-dd, HH:mm:ss")
                            .format(product.createdAt),
                        style: const TextStyle(fontFamily: "Product Sans"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: const MySeparator(color: Colors.grey),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.namaProduk,
                            style: TextStyle(
                                fontFamily: "Product Sans",
                                fontSize: 14.sp,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          Row(
                            children: [
                              Text(
                                product.berat.toString(),
                                style: TextStyle(
                                  fontFamily: "Product Sans",
                                  fontSize: 14.sp,
                                  color: AppColor.appThree,
                                ),
                              ),
                              Text(
                                "kg",
                                style: TextStyle(
                                  fontFamily: "Product Sans",
                                  fontSize: 14.sp,
                                  color: AppColor.appThree,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Price",
                            style: TextStyle(
                                fontFamily: "Product Sans",
                                fontSize: 14.sp,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          Text(
                            NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp.',
                              decimalDigits: 0,
                            ).format(int.parse(product.totalHarga.toString())),
                            style: TextStyle(
                              fontFamily: "Product Sans",
                              fontSize: 14.sp,
                              color: AppColor.appThree,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payment Amount",
                            style: TextStyle(
                                fontFamily: "Product Sans",
                                fontSize: 14.sp,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          Text(
                            NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp.',
                              decimalDigits: 0,
                            ).format(int.parse(product.uangBayar.toString())),
                            style: TextStyle(
                              fontFamily: "Product Sans",
                              fontSize: 14.sp,
                              color: AppColor.appThree,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: const MySeparator(color: Colors.grey),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Total Change",
                        style: TextStyle(
                            fontFamily: "Product Sans",
                            fontSize: 16.sp,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp.',
                          decimalDigits: 0,
                        ).format(int.parse(product.kembalian.toString())),
                        style: TextStyle(
                            color: AppColor.appThree,
                            fontFamily: "Product Sans",
                            fontWeight: FontWeight.bold,
                            fontSize: 24.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
