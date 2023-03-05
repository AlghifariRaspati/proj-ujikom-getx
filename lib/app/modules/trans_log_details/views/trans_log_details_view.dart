import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:ujikom_getx/app/data/models/transactions_model.dart';

import '../../../../utils/colors.dart';
import '../controllers/trans_log_details_controller.dart';

class TransLogDetailsView extends GetView<TransLogDetailsController> {
  TransLogDetailsView({Key? key}) : super(key: key);
  final TransLogsModel product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appFive,
      appBar: AppBar(
        title: const Text('Details of Transaction Log',
          style: TextStyle(
              fontFamily: "Product Sans", fontWeight: FontWeight.w400),),
        backgroundColor: AppColor.appPrimary,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ListTile(
                title: const Text('Product Name'),
                subtitle: Text(product.email),
              ),
              const Divider(),
              ListTile(
                title: const Text('Price per/kg'),
                subtitle: Text(product.hargaProduk.toString()),
              ),
              const Divider(),
              ListTile(
                title: const Text('Created at'),
                subtitle: Text(DateFormat("yyyy-MM-dd HH:mm:ss")
                    .format(product.createdAt)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
