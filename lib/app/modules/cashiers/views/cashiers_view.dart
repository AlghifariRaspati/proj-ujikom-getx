import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cashiers_controller.dart';

class CashiersView extends GetView<CashiersController> {
  const CashiersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CashiersView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CashiersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
