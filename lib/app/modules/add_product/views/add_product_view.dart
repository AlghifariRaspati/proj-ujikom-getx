import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../../../../components/my_email_textfield.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  AddProductView({Key? key}) : super(key: key);
  final TextEditingController nameC = TextEditingController();
  final TextEditingController priceC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Category'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              MyEmailTextField(
                  keyboardType: TextInputType.name,
                  controller: nameC,
                  hintText: "Category Name"),
              SizedBox(
                height: 10.h,
              ),
              MyEmailTextField(
                  keyboardType: TextInputType.number,
                  controller: priceC,
                  hintText: "Price per/kg"),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 50.h,
                child: ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        if (nameC.text.isNotEmpty && priceC.text.isNotEmpty) {
                          controller.isLoading(true);
                          Map<String, dynamic> hasil =
                              await controller.addProduct({
                            "nama_produk": nameC.text,
                            "harga": int.tryParse(priceC.text) ?? 0,
                          });
                          controller.isLoading(false);

                          Get.back();
                          Get.back();

                          Get.snackbar(
                              hasil["error"] == true ? "Error" : "Success",
                              hasil["message"]);
                        } else {
                          Get.snackbar("Error", "All fields must be filled");
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9)),
                    ),
                    child: Obx(() => Text(controller.isLoading.isFalse
                        ? "Save"
                        : "Loading...."))),
              )
            ],
          ),
        ));
  }
}
