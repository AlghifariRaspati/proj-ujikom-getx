import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../utils/colors.dart';
import '../../../data/models/user_model.dart';

import '../../../routes/app_pages.dart';
import '../controllers/cashiers_controller.dart';

class CashiersView extends GetView<CashiersController> {
  CashiersView({Key? key}) : super(key: key);
  final dateFormat = DateFormat("yyyy-MM-dd, HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.appFive,
        appBar: AppBar(
          title: const Text('Cashiers'),
          centerTitle: true,
          backgroundColor: AppColor.appPrimary,
          elevation: 0,
        ),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.streamProducts(),
              builder: (context, snapUser) {
                //mengecek data
                if (snapUser.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapUser.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No Cashiers"),
                  );
                }

                // looping data
                final allUsers = List<UserModel>.from(
                  snapUser.data!.docs.map(
                    (doc) => UserModel.fromJson(doc.data()),
                  ),
                );
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Scrollbar(
                    interactive: true,
                    child: ListView.builder(
                        shrinkWrap:
                            true, // untuk mengecilkan konten dari listview
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: allUsers.length,
                        padding: const EdgeInsets.all(20),
                        itemBuilder: (context, index) {
                          UserModel data = allUsers[index];
                          return Card(
                            elevation: 5,
                            margin: EdgeInsets.only(bottom: 20.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9)),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.cashier_details,
                                    arguments:
                                        data //lempar data dari data users
                                    );
                              },
                              borderRadius: BorderRadius.circular(9),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: IntrinsicHeight(
                                  child: Row(children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Email: ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.appPrimary),
                                              ),
                                              Text(
                                                data.email,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Password: ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.appPrimary),
                                              ),
                                              Text(data.pass),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text("Created at: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColor.appPrimary)),
                                              Text(
                                                DateFormat(
                                                        "yyyy-MM-dd, HH:mm:ss")
                                                    .format(data.createdAt),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "UID: ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.appPrimary),
                                              ),
                                              Text(
                                                data.id,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                );
              }),
        ));
  }
}
