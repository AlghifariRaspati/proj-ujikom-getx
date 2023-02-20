import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../components/my_email_textfield.dart';

import '../../../controllers/auth_controller.dart';
import '../controllers/add_cashier_controller.dart';

class AddCashierView extends GetView<AddCashierController> {
  AddCashierView({Key? key}) : super(key: key);
  final TextEditingController emailC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  final AuthController authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Cashier'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              MyEmailTextField(
                  keyboardType: TextInputType.name,
                  controller: nameC,
                  hintText: "Username"),
              const SizedBox(
                height: 10,
              ),
              MyEmailTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailC,
                  hintText: "Email"),
              const SizedBox(
                height: 10,
              ),
              MyEmailTextField(
                  keyboardType: TextInputType.name,
                  controller: passC,
                  hintText: "Password"),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9)),
                    ),
                    child: Obx(() => Text(controller.isLoading.isFalse
                        ? "Save"
                        : "Loading...."))),
              )
            ],
          ),
        ));
  }
}
