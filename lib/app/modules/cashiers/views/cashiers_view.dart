import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ujikom_getx/app/data/models/user_model.dart';

import '../../../routes/app_pages.dart';
import '../controllers/cashiers_controller.dart';

class CashiersView extends GetView<CashiersController> {
  const CashiersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Category'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.streamProducts(),
              builder: (context, snapUser) {
                //check if data is available
                if (snapUser.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapUser.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No Category"),
                  );
                }

                // looping data
                List<UserModel> allUsers = [];

                for (var element in snapUser.data!.docs) {
                  allUsers.add(UserModel.fromJson(element.data()));
                }
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
                                    // data content
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "Email: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                              const Text(
                                                "Password: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                              const Text("Created at: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Text("Updated at: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                data.formattedUpdatedAt,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "UID: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
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
