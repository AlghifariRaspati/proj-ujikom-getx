import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/colors.dart';
import '../../../data/models/product_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appFive,
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: AppColor.appPrimary,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamProducts(),
          builder: (context, snapProducts) {
            // Check if there's data
            if (snapProducts.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapProducts.data!.docs.isEmpty) {
              return const Center(
                child: Text("No Product"),
              );
            }

            // Create a list of products from the stream data
            final allProducts = List<ProductModel>.from(
              snapProducts.data!.docs.map(
                (doc) => ProductModel.fromJson(doc.data()),
              ),
            );

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: allProducts.length,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final product = allProducts[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.only(bottom: 20.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(
                        Routes.products_detail,
                        arguments: product,
                      );
                    },
                    borderRadius: BorderRadius.circular(9),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            // product content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.namaProduk,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text("Price per/kg :"),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp.',
                                          decimalDigits: 0,
                                        ).format(int.parse(
                                            product.harga.toString())),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
