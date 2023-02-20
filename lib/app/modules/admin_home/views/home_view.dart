import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../../../controllers/auth_controller.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final AuthController authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GridView.builder(
            itemCount: 4,
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
            itemBuilder: (context, index) {
              late String title;
              late IconData icon;
              late VoidCallback onTap;

              switch (index) {
                case 0:
                  title = "Add Category";
                  icon = Icons.note_add_rounded;
                  onTap = () => Get.toNamed(Routes.add_product);
                  break;
                case 1:
                  title = "Manage Category";
                  icon = Icons.edit;
                  onTap = () => Get.toNamed(Routes.products);
                  break;
                case 2:
                  title = "Manage Cashier";
                  icon = Icons.person;
                  onTap = () => Get.toNamed(Routes.users);
                  break;
                case 3:
                  title = "Activity Log";
                  icon = Icons.library_books;
                  onTap = () => Get.toNamed(Routes.activity_log);
                  break;
                default:
              }
              return Material(
                borderRadius: BorderRadius.circular(9),
                color: AppColor.appGrey,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(9),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            icon,
                            size: 50,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
              );
            }),
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
