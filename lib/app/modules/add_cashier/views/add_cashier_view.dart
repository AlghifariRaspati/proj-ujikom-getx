import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ujikom_getx/utils/colors.dart';

import '../../../../components/email_create_textfield.dart';
import '../../../../components/pass_create_textfield.dart';

import '../../../controllers/auth_controller.dart';
import '../controllers/add_cashier_controller.dart';

class AddCashierView extends GetView<AddCashierController> {
  AddCashierView({Key? key}) : super(key: key);
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  void regCashier() async {
    if (controller.isLoading.isFalse) {
      if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
        controller.isLoading(true);
        Map<String, dynamic> hasil =
            await authC.register(emailC.text, passC.text);
        controller.isLoading(false);

        if (hasil["error"] == true) {
          Get.snackbar("Error", hasil["message"]);
        } else {
          Get.back();
          Get.snackbar(
              hasil["error"] == true ? "Error" : "Success", hasil["message"]);
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
      backgroundColor: AppColor.appFive,
      appBar: AppBar(
        leading: IconButton(
          iconSize: 24,
          color: AppColor.appBase,
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Add Cashier',
          style: TextStyle(
              fontFamily: "Product Sans", fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        backgroundColor: AppColor.appPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            EmailCreateTextfield(
              keyboardType: TextInputType.emailAddress,
              controller: emailC,
              labelText: "Email",
              onPressed: emailC.clear,
            ),
            SizedBox(
              height: 10.h,
            ),
            PassCreateTextfield(
              keyboardType: TextInputType.name,
              controller: passC,
              labelText: "Password",
              onPressed: passC.clear,
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        child: ElevatedButton(
            onPressed: regCashier,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(280.w, 40.h),
              backgroundColor: AppColor.appSecondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)),
            ),
            child: Obx(() => controller.isLoading.isFalse
                ? const Text(
                    "Add Cashier",
                    style: TextStyle(fontFamily: "Product Sans"),
                  )
                : const SizedBox(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ))),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
