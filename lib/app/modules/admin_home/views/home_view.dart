import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      backgroundColor: AppColor.appFive,
      appBar: AppBar(
        title: const Text('Hello, Admin'),
        backgroundColor: AppColor.appPrimary,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(
                    "Are you sure to log out?",
                    style: TextStyle(
                        color: AppColor.appPrimary, fontFamily: "Product Sans"),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "CANCEL",
                        style: TextStyle(
                            color: AppColor.appPrimary,
                            fontFamily: "Product Sans"),
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          Map<String, dynamic> hasil = await authC.logout();
                          if (hasil["error"] == false) {
                            Get.offAllNamed(Routes.login);
                          } else {
                            Get.snackbar("Error", hasil["error"]);
                          }
                        },
                        child: Text(
                          "CONFIRM",
                          style: TextStyle(
                              color: AppColor.appPrimary,
                              fontFamily: "Product Sans"),
                        ))
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: GridView.builder(
            itemCount: 3,
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
                  title = "Add Category";
                  icon = Icons.category_rounded;
                  onTap = () => Get.toNamed(Routes.add_product);
                  break;
                case 1:
                  title = "Manage Category";
                  icon = Icons.settings_rounded;
                  onTap = () => Get.toNamed(Routes.products);
                  break;
                case 2:
                  title = "Add Cashier";
                  icon = Icons.person_add_alt_1_rounded;
                  onTap = () => Get.toNamed(Routes.add_cashier);
                  break;

                default:
              }
              return Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(9),
                color: AppColor.appBase,
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
                            color: AppColor.appSecondary,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          title,
                          style: TextStyle(
                              fontFamily: 'Nexa',
                              fontWeight: FontWeight.bold,
                              color: AppColor.appPrimary),
                        )
                      ]),
                ),
              );
            }),
      ),
    );
  }
}
