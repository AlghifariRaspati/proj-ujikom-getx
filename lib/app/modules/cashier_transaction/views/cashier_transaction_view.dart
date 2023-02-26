import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ujikom_getx/components/locked_textfield.dart';

import '../../../../components/textfield_clear.dart';

import '../../../../utils/colors.dart';
import '../controllers/cashier_transaction_controller.dart';

class CashierTransactionView extends GetView<CashierTransactionController> {
  CashierTransactionView({Key? key}) : super(key: key);

  final TextEditingController prodNameC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController numC = TextEditingController();
  final TextEditingController payC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.appFive,
        appBar: AppBar(
          title: const Text('Create Order'),
          backgroundColor: AppColor.appPrimary,
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: MyClearTextField(
                        keyboardType: TextInputType.name,
                        controller: nameC,
                        hintText: "Name",
                        onPressed: nameC.clear,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: MyClearTextField(
                        keyboardType: TextInputType.number,
                        controller: numC,
                        hintText: "Telephone",
                        onPressed: numC.clear,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              LockedTextfield(
                controller: prodNameC,
                hintText: "Category Name",
              ),
              SizedBox(
                height: 10.h,
              ),
              LockedTextfield(
                controller: priceC,
                hintText: "Price per/kg",
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              MyClearTextField(
                  onPressed: payC.clear,
                  controller: payC,
                  hintText: "Payment Amount",
                  keyboardType: TextInputType.number),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 50.h,
                child: ElevatedButton(
                    onPressed: () async {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.appSecondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9)),
                    ),
                    child: Obx(() => controller.isLoading.isFalse
                        ? const Text("Create Order")
                        : SizedBox(
                            height: 15.h,
                            width: 15.w,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1.w,
                            ),
                          ))),
              ),
            ],
          ),
        ));
  }
}
