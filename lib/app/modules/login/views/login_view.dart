import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ujikom_getx/utils/colors.dart';
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
    return Scaffold(
      backgroundColor: AppColor.appSecondary,
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 300.w,
            height: 400.h,
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TitleText(
                      text: "Laundry App",
                    ),
                    SizedBox(
                      height: 50.h,
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
                        backgroundColor: AppColor.appSecondary,
                        minimumSize: Size(260.w, 50.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: Obx(
                        () => controller.isLoading.isFalse
                            ? const Text(
                                "Log In",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : SizedBox(
                                width: 24.w,
                                height: 24.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
