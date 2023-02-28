import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ujikom_getx/components/locked_cur_text.dart';

import 'package:ujikom_getx/components/locked_textfield.dart';

import '../../../../components/textfield_clear.dart';

import '../../../../utils/colors.dart';
import '../../../data/models/product_model.dart';
import '../controllers/cashier_transaction_controller.dart';

class CashierTransactionView extends GetView<CashierTransactionController> {
  CashierTransactionView({Key? key}) : super(key: key);

  final TextEditingController prodNameC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController numC = TextEditingController();
  final TextEditingController payC = TextEditingController();
  final TextEditingController kgC = TextEditingController();
  final TextEditingController returnC = TextEditingController();

  final ProductModel product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    prodNameC.text = product.namaProduk;
    priceC.text = product.harga.toString();
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
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: MyClearTextField(
                        keyboardType: TextInputType.name,
                        controller: nameC,
                        labelText: "Customer Name",
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
                        labelText: "Telephone",
                        onPressed: numC.clear,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: MyClearTextField(
                        onPressed: kgC.clear,
                        controller: kgC,
                        labelText: "Weight Amount",
                        keyboardType: TextInputType.number),
                  )),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: MyClearTextField(
                        onPressed: payC.clear,
                        controller: payC,
                        labelText: "Payment Amount",
                        keyboardType: TextInputType.number),
                  ))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                thickness: 1,
                color: AppColor.appSecondary,
              ),
              SizedBox(
                height: 10.h,
              ),
              LockedTextfield(
                controller: prodNameC,
                labelText: "Category Name",
              ),
              SizedBox(
                height: 10.h,
              ),
              LockedCurTextfield(
                controller: priceC,
                labelText: "Price per/kg",
              ),
              SizedBox(
                height: 10.h,
              ),
              LockedCurTextfield(
                  controller: returnC, labelText: "Change Amount"),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                thickness: 1,
                color: AppColor.appSecondary,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(
                        color: AppColor.appSecondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "PLACEHOLDER",
                    style: TextStyle(
                        color: AppColor.appPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
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
