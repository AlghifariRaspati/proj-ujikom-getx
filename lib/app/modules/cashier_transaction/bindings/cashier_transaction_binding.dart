import 'package:get/get.dart';

import '../controllers/cashier_transaction_controller.dart';

class CashierTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashierTransactionController>(
      () => CashierTransactionController(),
    );
  }
}
