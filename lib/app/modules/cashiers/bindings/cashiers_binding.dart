import 'package:get/get.dart';

import '../controllers/cashiers_controller.dart';

class CashiersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashiersController>(
      () => CashiersController(),
    );
  }
}
