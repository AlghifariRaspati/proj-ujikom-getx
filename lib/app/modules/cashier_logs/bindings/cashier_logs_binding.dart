import 'package:get/get.dart';

import '../controllers/cashier_logs_controller.dart';

class CashierLogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashierLogsController>(
      () => CashierLogsController(),
    );
  }
}
