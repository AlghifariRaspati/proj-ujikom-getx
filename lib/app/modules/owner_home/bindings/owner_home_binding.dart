import 'package:get/get.dart';

import '../controllers/owner_home_controller.dart';

class OwnerHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerHomeController>(
      () => OwnerHomeController(),
    );
  }
}
