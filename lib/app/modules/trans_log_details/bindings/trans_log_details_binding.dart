import 'package:get/get.dart';

import '../controllers/trans_log_details_controller.dart';

class TransLogDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransLogDetailsController>(
      () => TransLogDetailsController(),
    );
  }
}
