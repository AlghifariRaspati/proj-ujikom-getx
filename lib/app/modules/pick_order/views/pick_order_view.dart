import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/colors.dart';
import '../../../data/models/product_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/pick_order_controller.dart';

class PickOrderView extends GetView<PickOrderController> {
  const PickOrderView({Key? key}) : super(key: key);

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
        centerTitle: false,
        title: Text(
          'Categories',
          style: TextStyle(
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w500,
              color: AppColor.appBase),
        ),
        backgroundColor: AppColor.appPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamProducts(),
          builder: (context, snapProducts) {
            // Check if there's data
            if (snapProducts.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.appPrimary,
                ),
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
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final product = allProducts[index];
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: 15.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(
                        Routes.cashier_transaction,
                        arguments: product,
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(15),
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
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColor.appPrimary,
                                        fontFamily: "Product Sans"),
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
                                            color: AppColor.appSecondary,
                                            fontFamily: "Product Sans"),
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
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontFamily: "Product Sans"),
                                      ),
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
