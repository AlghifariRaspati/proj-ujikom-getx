import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/owner_home_controller.dart';

class OwnerHomeView extends GetView<OwnerHomeController> {
  OwnerHomeView({Key? key}) : super(key: key);
  final AuthController authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('You are logged in as an Owner'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OwnerHomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: const Text("are you sure to log out?"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("CANCEL")),
                      TextButton(
                          onPressed: () async {
                            Map<String, dynamic> hasil = await authC.logout();
                            if (hasil["error"] == false) {
                              Get.offAllNamed(Routes.login);
                            } else {
                              Get.snackbar("Error", hasil["error"]);
                            }
                          },
                          child: const Text("CONFIRM"))
                    ],
                  ));
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
