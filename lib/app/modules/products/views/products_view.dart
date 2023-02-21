import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/product_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Category'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.streamProducts(),
              builder: (context, snapProducts) {
                //check if data is available
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

                // looping data
                List<ProductModel> allProducts = [];

                for (var element in snapProducts.data!.docs) {
                  allProducts.add(ProductModel.fromJson(element.data()));
                }
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Scrollbar(
                    interactive: true,
                    child: ListView.builder(
                        shrinkWrap:
                            true, // untuk mengecilkan konten dari listview
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: allProducts.length,
                        padding: const EdgeInsets.all(20),
                        itemBuilder: (context, index) {
                          ProductModel product = allProducts[index];
                          return Card(
                            elevation: 5,
                            margin: const EdgeInsets.only(bottom: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9)),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.products_detail,
                                    arguments:
                                        product //lempar data dari data produk
                                    );
                              },
                              borderRadius: BorderRadius.circular(9),
                              child: Container(
                                height: 100,
                                padding: const EdgeInsets.all(20),
                                child: Row(children: [
                                  // product content
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.namaProduk,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Text("Price per/kg :"),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(NumberFormat.currency(
                                                    locale: 'id',
                                                    symbol: 'Rp.',
                                                    decimalDigits: 0)
                                                .format(int.parse(
                                                    product.harga.toString()))),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          );
                        }),
                  ),
                );
              }),
        ));
  }
}
