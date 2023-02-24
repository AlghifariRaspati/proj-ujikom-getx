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
      appBar: AppBar(
        title: const Text('Hello, Admin'),
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: const Text("Are you sure you want to log out?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("CANCEL",
                          style: TextStyle(color: AppColor.appPrimary)),
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
                      child: Text("CONFIRM",
                          style: TextStyle(color: AppColor.appPrimary)),
                    )
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
                  title = "View Transaction logs";
                  icon = Icons.note_add_rounded;
                  onTap = () {};
                  break;
                case 1:
                  title = "View user log activity";
                  icon = Icons.person;
                  onTap = () {};
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
                          height: 10.h,
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
    );
  }
}
