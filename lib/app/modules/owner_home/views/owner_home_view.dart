import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/owner_home_controller.dart';

class OwnerHomeView extends GetView<OwnerHomeController> {
  OwnerHomeView({Key? key}) : super(key: key);
  final AuthController authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBase,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 0.2.sh + 50.h,
            decoration: BoxDecoration(
              color: AppColor.appPrimary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.appPrimary,
                  AppColor.appSecondary,
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Hello, Owner',
                  style: TextStyle(
                      fontSize: 24.sp,
                      color: AppColor.appFive,
                      fontFamily: "Product Sans",
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor.appFive,
                      fontFamily: "Product Sans",
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.15.sh + 10.h,
            bottom: 0,
            left: 0,
            right: 0,
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
                      title = "Activity Logs";
                      icon = Icons.history_rounded;
                      onTap = () => Get.toNamed(Routes.activity_log);
                      break;
                    case 1:
                      title = "Transaction Logs";
                      icon = Icons.analytics_rounded;
                      onTap = () => Get.toNamed(Routes.trans_log);
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
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.appPrimary),
                            )
                          ]),
                    ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
                        color: AppColor.appPrimary, fontFamily: "Product Sans"),
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
        backgroundColor: AppColor.appPrimary,
        child: const Icon(Icons.exit_to_app_rounded),
      ),
    );
  }
}
