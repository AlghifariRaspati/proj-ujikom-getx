import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20.w,
                crossAxisSpacing: 20.h),
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
                  onTap = () => Get.toNamed(Routes.cashiers);
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
                          width: 50.w,
                          height: 50.h,
                          child: Icon(
                            icon,
                            size: 50,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
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
