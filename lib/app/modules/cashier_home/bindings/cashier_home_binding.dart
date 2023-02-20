import 'package:get/get.dart';

import '../controllers/cashier_home_controller.dart';

class CashierHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashierHomeController>(
      () => CashierHomeController(),
    );
  }
}
