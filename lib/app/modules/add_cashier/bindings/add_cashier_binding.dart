import 'package:get/get.dart';

import '../controllers/add_cashier_controller.dart';

class AddCashierBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCashierController>(
      () => AddCashierController(),
    );
  }
}
