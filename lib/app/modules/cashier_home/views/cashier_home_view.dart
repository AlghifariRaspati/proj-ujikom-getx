import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cashier_home_controller.dart';

class CashierHomeView extends GetView<CashierHomeController> {
  const CashierHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CashierHomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CashierHomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
