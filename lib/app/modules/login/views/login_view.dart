import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../../../../components/title_text.dart';

import '../../../controllers/auth_controller.dart';

import '../../../../components/my_email_textfield.dart';
import '../../../../components/my_pass_textfield.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  void signUserIn() async {
    if (controller.isLoading.isFalse) {
      if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
        controller.isLoading(true);
        Map<String, dynamic> hasil = await authC.login(emailC.text, passC.text);
        controller.isLoading(false);

        if (hasil["error"] == true) {
          Get.snackbar("Error", hasil["message"]);
        } else {
          await authC.checkUserRoleAndNavigate();
        }
      } else {
        Get.snackbar("Error", "Email and Password needs to be filled.");
      }
    }
  }

  final AuthController authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.appFour, AppColor.appSecondary],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 300.w,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                color: AppColor.appBase,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/laundry_detergent.png',
                          width: 128.w,
                          height: 128.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TitleText(
                            text: "Laundry",
                          ),
                          Text(
                            "Buddy",
                            style: TextStyle(
                                color: AppColor.appSecondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.sp,
                                fontFamily: "Product Sans"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      MyEmailTextField(
                        controller: emailC,
                        hintText: "Email",
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Obx(
                        () => MyPassTextField(
                          controller: passC,
                          hintText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.isHidden.toggle();
                            },
                            icon: Icon(controller.isHidden.isFalse
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined),
                            color: AppColor.appSecondary,
                          ),
                          obscureText: controller.isHidden.value,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      ElevatedButton(
                        onPressed: signUserIn,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(260.w, 40.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          padding: EdgeInsets.zero,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [AppColor.appPrimary, AppColor.appFour],
                            ),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: 90.w,
                              minHeight: 40.h,
                            ),
                            alignment: Alignment.center,
                            child: Obx(() => controller.isLoading.isFalse
                                ? Text(
                                    "log in",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Product Sans"),
                                  )
                                : SizedBox(
                                    width: 12.w,
                                    height: 12.h,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
