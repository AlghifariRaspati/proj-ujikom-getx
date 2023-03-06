import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:ujikom_getx/components/locked_textfield.dart';

import '../../../../components/clear_textfield.dart';
import '../../../../components/textfield_clear.dart';
import '../../../../utils/colors.dart';
import '../../../data/models/product_model.dart';
import '../controllers/products_detail_controller.dart';

class ProductsDetail extends GetView<ProductsDetailController> {
  ProductsDetail({Key? key}) : super(key: key);
  final TextEditingController nameC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController dateC = TextEditingController();

  final ProductModel product = Get.arguments;
  @override
  Widget build(BuildContext context) {
    nameC.text = product.namaProduk;
    priceC.text = product.harga.toString();
    dateC.text = DateFormat("yyyy-MM-dd HH:mm:ss").format(product.createdAt);

    return Scaffold(
        backgroundColor: AppColor.appFive,
        appBar: AppBar(
          title: const Text('Product Detail'),
          backgroundColor: AppColor.appPrimary,
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ClearTextfield(
              keyboardType: TextInputType.name,
              controller: nameC,
              labelText: "Product Name",
              onPressed: nameC.clear,
            ),
            SizedBox(
              height: 10.h,
            ),
            MyClearTextField(
              keyboardType: TextInputType.number,
              controller: priceC,
              labelText: "Price per/kg",
              onPressed: priceC.clear,
            ),
            SizedBox(
              height: 10.h,
            ),
            LockedTextfield(controller: dateC, labelText: "Created at"),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 40.h,
              child: ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoadingUpdate.isFalse) {
                      if (nameC.text.isNotEmpty && priceC.text.isNotEmpty) {
                        controller.isLoadingUpdate(true);
                        Map<String, dynamic> hasil =
                            await controller.editProduct({
                          "id": product.id,
                          "nama_produk": nameC.text,
                          "harga": int.tryParse(priceC.text) ?? 0
                        });
                        controller.isLoadingUpdate(false);

                        Get.back();

                        Get.snackbar(
                            hasil["error"] == true ? "Error" : "Success",
                            hasil["message"],
                            duration: const Duration(seconds: 2));
                      }
                    } else {
                      Get.snackbar("Error", "All fields must be filled",
                          duration: const Duration(seconds: 2));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.appSecondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9)),
                  ),
                  child: Obx(() => Text(controller.isLoadingUpdate.isFalse
                      ? "Save"
                      : "Loading..."))),
            ),
            TextButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: const Text(
                                "are you sure to delete this product?",
                                style: TextStyle(fontFamily: "Product Sans")),
                            actions: [
                              TextButton(
                                  onPressed: () => Get.back(),
                                  child: Text("CANCEL",
                                      style: TextStyle(
                                          color: AppColor.appPrimary,
                                          fontFamily: "Product Sans"))),
                              TextButton(
                                  onPressed: () async {
                                    controller.isLoadingDelete(true);
                                    Map<String, dynamic> hasil =
                                        await controller
                                            .deleteProduct(product.id);
                                    controller.isLoadingDelete(false);

                                    Get.back(); // tutup dialog
                                    Get.back(); // kembali ke halaman sebelumnya

                                    Get.snackbar(
                                        hasil["error"] == true
                                            ? "Error"
                                            : "Success",
                                        hasil["message"],
                                        duration: const Duration(seconds: 2));
                                  },
                                  child: Obx(() =>
                                      controller.isLoadingDelete.isFalse
                                          ? Text("DELETE",
                                              style: TextStyle(
                                                  color: AppColor.appPrimary,
                                                  fontFamily: "Product Sans"))
                                          : Container(
                                              padding: const EdgeInsets.all(2),
                                              height: 15.h,
                                              width: 15.w,
                                              child: CircularProgressIndicator(
                                                color: Colors.lightBlue,
                                                strokeWidth: 1.w,
                                              ),
                                            ))),
                            ],
                          ));
                },
                child: Text(
                  "Delete Product",
                  style: TextStyle(color: Colors.red[900]),
                ))
          ],
        ));
  }
}
