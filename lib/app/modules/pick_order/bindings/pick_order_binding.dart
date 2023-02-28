import 'package:get/get.dart';

import '../controllers/pick_order_controller.dart';

class PickOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickOrderController>(
      () => PickOrderController(),
    );
  }
}
