import 'package:get/get.dart';

import '../controllers/trans_log_controller.dart';

class TransLogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransLogController>(
      () => TransLogController(),
    );
  }
}
