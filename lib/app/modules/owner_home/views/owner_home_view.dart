import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/owner_home_controller.dart';

class OwnerHomeView extends GetView<OwnerHomeController> {
  const OwnerHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OwnerHomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OwnerHomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
