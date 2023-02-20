import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/users_controller.dart';

class UsersView extends GetView<UsersController> {
  const UsersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Cashiers'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GridView.builder(
            itemCount: 2,
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
            itemBuilder: (context, index) {
              late String title;
              late IconData icon;
              late VoidCallback onTap;

              switch (index) {
                case 0:
                  title = "Add Cashier";
                  icon = Icons.note_add_rounded;
                  onTap = () => Get.toNamed(Routes.add_cashier);
                  break;
                case 1:
                  title = "Edit Cashier";
                  icon = Icons.edit;
                  onTap = () => Get.toNamed(Routes.products);
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
    );
  }
}
