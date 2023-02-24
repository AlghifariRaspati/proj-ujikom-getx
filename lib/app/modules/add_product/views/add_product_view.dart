import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/textfield_clear.dart';
import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  AddProductView({Key? key}) : super(key: key);
  final TextEditingController nameC = TextEditingController();
  final TextEditingController priceC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              MyClearTextField(
                keyboardType: TextInputType.name,
                controller: nameC,
                hintText: "Product Name",
                onPressed: nameC.clear,
              ),
              SizedBox(
                height: 10.h,
              ),
              MyClearTextField(
                keyboardType: TextInputType.number,
                controller: priceC,
                hintText: "Price per/kg",
                onPressed: priceC.clear,
              ),
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
                    child: Obx(() => controller.isLoading.isFalse
                        ? const Text("Save")
                        : SizedBox(
                            height: 15.h,
                            width: 15.w,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1.w,
                            ),
                          ))),
              )
            ],
          ),
        ));
  }
}
