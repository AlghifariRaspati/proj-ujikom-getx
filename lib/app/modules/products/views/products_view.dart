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
        title: const Text('Category'),
        backgroundColor: AppColor.appPrimary,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamProducts(),
          builder: (context, snapProducts) {
            // mengecek jika ada data
            if (snapProducts.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapProducts.data!.docs.isEmpty) {
              return const Center(
                child: Text("No Category"),
              );
            }

            // membuat list kategori dari stream data
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
                            // konten produk
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.namaProduk,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.appPrimary),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Price per/kg :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.appSecondary),
                                      ),
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
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Created at: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.appSecondary),
                                      ),
                                      Text(
                                        DateFormat("yyyy-MM-dd, HH:mm:ss")
                                            .format(product.createdAt),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Item ID: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.appSecondary),
                                      ),
                                      Text(product.id),
                                    ],
                                  ),
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
