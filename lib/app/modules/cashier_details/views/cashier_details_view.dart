import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../components/textfield_clear.dart';
import '../../../../utils/colors.dart';
import '../../../data/models/user_model.dart';
import '../controllers/cashier_details_controller.dart';

class CashierDetailsView extends GetView<CashierDetailsController> {
  CashierDetailsView({Key? key}) : super(key: key);
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  final UserModel user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    emailC.text = user.email;
    passC.text = user.pass;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Cashier Detail'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: AppColor.appGrey,
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            MyClearTextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailC,
              hintText: "Cashier Email",
              onPressed: emailC.clear,
            ),
            SizedBox(
              height: 10.h,
            ),
            MyClearTextField(
              keyboardType: TextInputType.name,
              controller: passC,
              hintText: "Cashier Password",
              onPressed: passC.clear,
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 50.h,
              child: ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoadingUpdate.isFalse) {
                      if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
                        controller.isLoadingUpdate(true);
                        Map<String, dynamic> hasil = await controller.editUser({
                          "id": user.id,
                          "email": emailC.text,
                          "password": passC.text
                        });
                        controller.isLoadingUpdate(false);
                        Get.snackbar(
                            hasil["error"] == true ? "Error" : "Success",
                            hasil["message"],
                            duration: const Duration(seconds: 2));
                      }
                    } else {
                      Get.snackbar("Error", "All fields must be filled",
                          duration: const Duration(seconds: 2));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9)),
                  ),
                  child: Obx(() => Text(controller.isLoadingUpdate.isFalse
                      ? "Save"
                      : "Loading..."))),
            ),
            TextButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content:
                                const Text("are you sure to delete this user?"),
                            actions: [
                              TextButton(
                                  onPressed: () => Get.back(),
                                  child: Text("CANCEL",
                                      style: TextStyle(
                                          color: AppColor.appPrimary))),
                              TextButton(
                                  onPressed: () async {
                                    controller.isLoadingDelete(true);
                                    Map<String, dynamic> hasil =
                                        await controller.deleteUser(user.id);
                                    controller.isLoadingDelete(false);

                                    Get.back(); // close dialog
                                    Get.back(); //return to previous page

                                    Get.snackbar(
                                        hasil["error"] == true
                                            ? "Error"
                                            : "Success",
                                        hasil["message"],
                                        duration: const Duration(seconds: 2));
                                  },
                                  child: Obx(() =>
                                      controller.isLoadingDelete.isFalse
                                          ? Text("DELETE",
                                              style: TextStyle(
                                                  color: AppColor.appPrimary))
                                          : Container(
                                              padding: const EdgeInsets.all(2),
                                              height: 15.h,
                                              width: 15.w,
                                              child: CircularProgressIndicator(
                                                color: Colors.lightBlue,
                                                strokeWidth: 1.w,
                                              ),
                                            ))),
                            ],
                          ));
                },
                child: Text(
                  "Delete User",
                  style: TextStyle(color: Colors.red[900]),
                ))
          ],
        ));
  }
}
