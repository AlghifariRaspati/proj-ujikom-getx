import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ujikom_getx/components/locked_textfield.dart';

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
            'Cashier Detail',
            style: TextStyle(
                fontFamily: "Product Sans", fontWeight: FontWeight.w500),
          ),
          backgroundColor: AppColor.appPrimary,
          centerTitle: false,
          elevation: 0,
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    'Delete User',
                    style: TextStyle(
                        color: Colors.red[900], fontFamily: "Product Sans"),
                  ),
                ),
              ],
              onSelected: (value) async {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: const Text(
                            "are you sure to delete this user?",
                          ),
                          actions: [
                            TextButton(
                                onPressed: () => Get.back(),
                                child: Text("CANCEL",
                                    style: TextStyle(
                                        color: AppColor.appPrimary,
                                        fontFamily: "Product Sans"))),
                            TextButton(
                                onPressed: () async {
                                  controller.isLoadingDelete(true);
                                  Map<String, dynamic> hasil =
                                      await controller.deleteUser(user.id);
                                  controller.isLoadingDelete(false);

                                  Get.back();
                                  Get.back();

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
                                                color: Colors.red[900],
                                                fontFamily: "Product Sans"))
                                        : Container(
                                            padding: const EdgeInsets.all(2),
                                            child: CircularProgressIndicator(
                                              color: AppColor.appPrimary,
                                              strokeWidth: 2,
                                            ),
                                          ))),
                          ],
                        ));
              },
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            LockedTextfield(
              controller: emailC,
              labelText: "Cashier Email",
            ),
            SizedBox(
              height: 10.h,
            ),
            MyClearTextField(
              keyboardType: TextInputType.name,
              controller: passC,
              labelText: "Cashier Password",
              onPressed: passC.clear,
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 40.h,
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
                    backgroundColor: AppColor.appSecondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9)),
                  ),
                  child: Obx(() => Text(controller.isLoadingUpdate.isFalse
                      ? "Save"
                      : "Loading..."))),
            ),
          ],
        ));
  }
}
