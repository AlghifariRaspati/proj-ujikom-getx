import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';

import '../../../../components/my_email_textfield.dart';
import '../../../../components/my_pass_textfield.dart';
import '../../../../utils/colors.dart';

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
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: AppColor.appGrey,
                ),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: MyEmailTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailC,
                  hintText: "Email"),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Obx(() => MyPassTextField(
                  controller: passC,
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.isHidden.toggle();
                    },
                    icon: Icon(controller.isHidden.isFalse
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined),
                  ),
                  obscureText: controller.isHidden.value)),
            ),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ElevatedButton(
                  onPressed: signUserIn,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9)),
                  ),
                  child: Obx(() => controller.isLoading.isFalse
                      ? const Text("Log In")
                      : Container(
                          padding: const EdgeInsets.all(2),
                          height: 15.h,
                          width: 15.w,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.w,
                          ),
                        ))),
            )
          ],
        ),
      ),
    ));
  }
}
