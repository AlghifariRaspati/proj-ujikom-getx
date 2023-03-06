import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/clear_textfield.dart';
import '../../../../components/textfield_clear.dart';
import '../../../../utils/colors.dart';
import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  AddProductView({Key? key}) : super(key: key);
  final TextEditingController nameC = TextEditingController();
  final TextEditingController priceC = TextEditingController();

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
          'Add Category',
          style: TextStyle(
              fontFamily: "Product Sans", fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        backgroundColor: AppColor.appPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
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
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        child: ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                if (nameC.text.isNotEmpty && priceC.text.isNotEmpty) {
                  controller.isLoading(true);
                  Map<String, dynamic> hasil = await controller.addProduct({
                    "nama_produk": nameC.text,
                    "harga": int.tryParse(priceC.text) ?? 0,
                  });
                  controller.isLoading(false);

                  Get.back();
                  Get.back();

                  Get.snackbar(hasil["error"] == true ? "Error" : "Success",
                      hasil["message"]);
                } else {
                  Get.snackbar("Error", "All fields must be filled");
                }
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(280.w, 40.h),
              backgroundColor: AppColor.appSecondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)),
            ),
            child: Obx(() => controller.isLoading.isFalse
                ? const Text(
                    "Save",
                    style: TextStyle(fontFamily: "Product Sans"),
                  )
                : const SizedBox(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ))),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
