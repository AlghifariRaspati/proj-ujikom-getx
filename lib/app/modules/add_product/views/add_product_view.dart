import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../components/my_email_textfield.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  AddProductView({Key? key}) : super(key: key);
  final TextEditingController nameC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();
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
              MyEmailTextField(
                  keyboardType: TextInputType.name,
                  controller: nameC,
                  hintText: "Product Name"),
              const SizedBox(
                height: 10,
              ),
              MyEmailTextField(
                  keyboardType: TextInputType.number,
                  controller: priceC,
                  hintText: "Product Price"),
              const SizedBox(
                height: 10,
              ),
              MyEmailTextField(
                  keyboardType: TextInputType.number,
                  controller: qtyC,
                  hintText: "Product Quantity"),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      if (nameC.text.isNotEmpty &&
                          priceC.text.isNotEmpty &&
                          qtyC.text.isNotEmpty) {
                        controller.isLoading(true);
                        Map<String, dynamic> hasil =
                            await controller.addProduct({
                          "nama_produk": nameC.text,
                          "harga": int.tryParse(priceC.text) ?? 0,
                          "jumlah_produk": int.tryParse(qtyC.text) ?? 0
                        });
                        controller.isLoading(false);

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
                  child: const Text("Save"),
                ),
              )
            ],
          ),
        ));
  }
}
