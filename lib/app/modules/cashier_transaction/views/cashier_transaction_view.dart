import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:ujikom_getx/components/locked_textfield.dart';
import 'package:ujikom_getx/components/payment_clear_textfield.dart';
import '../../../../components/clear_textfield.dart';
import '../../../../components/textfield_clear.dart';

import '../../../../components/weight_clear_textfield.dart';
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
  final TextEditingController totPriceC = TextEditingController();
  final TextEditingController changeC = TextEditingController();

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
              LockedTextfield(
                controller: prodNameC,
                labelText: "Category Name",
              ),
              SizedBox(
                height: 10.h,
              ),
              LockedTextfield(
                controller: priceC,
                labelText: "Price per/kg",
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
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: ClearTextfield(
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
                    child: WeightClearTextfield(
                      onPressed: kgC.clear,
                      controller: kgC,
                      labelText: "Weight Amount",
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        int weight = int.tryParse(text) ?? 0;
                        int price = int.tryParse(priceC.text) ?? 0;
                        totPriceC.text = (weight * price).toString();
                        int pay = int.tryParse(payC.text) ?? 0;
                        if (weight == 0 || pay == 0) {
                          changeC.text = "";
                        } else {
                          int change = pay - (weight * price);
                          changeC.text = change.toString();
                        }
                      },
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: LockedTextfield(
                        controller: totPriceC, labelText: "Price"),
                  ))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              PaymentClearTextfield(
                controller: payC,
                labelText: "Payment Amount",
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  int price = int.tryParse(totPriceC.text) ?? 0;
                  int pay = int.tryParse(text) ?? 0;
                  if (price == 0 || pay == 0 || pay < price) {
                    changeC.text = "";
                  } else {
                    int change = pay - price;
                    changeC.text = change.toString();
                  }
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              LockedTextfield(controller: changeC, labelText: "Change"),
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
              SizedBox(
                height: 40.h,
                child: ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        if (nameC.text.isNotEmpty &&
                            numC.text.isNotEmpty &&
                            kgC.text.isNotEmpty &&
                            payC.text.isNotEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: const Text(
                                        "are you sure to create this order?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () => Get.back(),
                                          child: Text("CANCEL",
                                              style: TextStyle(
                                                  color: AppColor.appPrimary))),
                                      TextButton(
                                          onPressed: () async {
                                            controller.isLoadingDelete(true);
                                            Map<String, dynamic> hasil =
                                                await controller
                                                    .addTransaction({
                                              "nama_pelanggan": nameC.text,
                                              "nomor_telepon":
                                                  int.tryParse(numC.text) ?? 0,
                                              "nama_produk": prodNameC.text,
                                              "harga_produk":
                                                  int.tryParse(priceC.text) ??
                                                      0,
                                              "total_harga": int.tryParse(
                                                      totPriceC.text) ??
                                                  0,
                                              "berat":
                                                  int.tryParse(kgC.text) ?? 0,
                                              "uang_bayar":
                                                  int.tryParse(payC.text) ?? 0,
                                            });
                                            controller.isLoadingDelete(false);

                                            Get.back(); // tutup dialog
                                            Get.back(); // kembali ke halaman sebelumnya

                                            Get.snackbar(
                                                hasil["error"] == true
                                                    ? "Error"
                                                    : "Success",
                                                hasil["message"],
                                                duration:
                                                    const Duration(seconds: 2));
                                          },
                                          child: Obx(() => controller
                                                  .isLoadingDelete.isFalse
                                              ? Text("CONFIRM",
                                                  style: TextStyle(
                                                      color:
                                                          AppColor.appPrimary))
                                              : Container(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  height: 15.h,
                                                  width: 15.w,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: AppColor.appPrimary,
                                                    strokeWidth: 2,
                                                  ),
                                                ))),
                                    ],
                                  ));
                        } else {
                          Get.snackbar("Error", "All fields must be filled");
                        }
                      }
                    },
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
