import 'package:get/get.dart';

import '../controllers/cashier_details_controller.dart';

class CashierDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashierDetailsController>(
      () => CashierDetailsController(),
    );
  }
}
