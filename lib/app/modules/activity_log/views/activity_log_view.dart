import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ujikom_getx/app/data/models/logs_model.dart';
import 'package:ujikom_getx/utils/colors.dart';

import '../../../routes/app_pages.dart';
import '../controllers/activity_log_controller.dart';

class ActivityLogView extends GetView<ActivityLogController> {
  const ActivityLogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appFive,
      appBar: AppBar(
        backgroundColor: AppColor.appPrimary,
        elevation: 0,
        title: const Text('Activity Logs'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          children: [
            Obx(() => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChoiceChip(
                        label: const Text('Logs'),
                        labelStyle: TextStyle(
                          color: controller.isLogsSelected.value
                              ? AppColor.appBase
                              : AppColor.appPrimary,
                        ),
                        selectedColor: AppColor.appSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        visualDensity: VisualDensity.comfortable,
                        onSelected: (isSelected) {
                          if (isSelected) {
                            controller.isLogsSelected.value = true;
                            controller.isTransactionsSelected.value = false;
                            controller.isActivitySelected.value = false;
                          }
                        },
                        selected: controller.isLogsSelected.value,
                      ),
                      ChoiceChip(
                        label: const Text('Transactions'),
                        labelStyle: TextStyle(
                          color: controller.isTransactionsSelected.value
                              ? AppColor.appBase
                              : AppColor.appPrimary,
                        ),
                        selectedColor: AppColor.appSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        visualDensity: VisualDensity.comfortable,
                        onSelected: (isSelected) {
                          if (isSelected) {
                            controller.isLogsSelected.value = false;
                            controller.isTransactionsSelected.value = true;
                            controller.isActivitySelected.value = false;
                          }
                        },
                        selected: controller.isTransactionsSelected.value,
                      ),
                      ChoiceChip(
                        label: const Text('Activity'),
                        labelStyle: TextStyle(
                          color: controller.isActivitySelected.value
                              ? AppColor.appBase
                              : AppColor.appPrimary,
                        ),
                        selectedColor: AppColor.appSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        visualDensity: VisualDensity.comfortable,
                        onSelected: (isSelected) {
                          if (isSelected) {
                            controller.isLogsSelected.value = false;
                            controller.isTransactionsSelected.value = false;
                            controller.isActivitySelected.value = true;
                          }
                        },
                        selected: controller.isActivitySelected.value,
                      ),
                    ],
                  ),
                )),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.streamLogs(),
                builder: (context, snapLogs) {
                  // cek jika ada data
                  if (snapLogs.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapLogs.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("No Product"),
                    );
                  }

                  // Create a list of products from the stream data
                  final allLogs = List<LogsModel>.from(
                    snapLogs.data!.docs.map(
                      (doc) => LogsModel.fromJson(doc.data()),
                    ),
                  );

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: allLogs.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      final logs = allLogs[index];
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.only(bottom: 20.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: IntrinsicHeight(
                            child: Row(children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Time: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.appPrimary)),
                                        Text(
                                          DateFormat("yyyy-MM-dd, HH:mm:ss")
                                              .format(logs.createdAt),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "User: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.appPrimary),
                                        ),
                                        Text(logs.email),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Role: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.appPrimary),
                                        ),
                                        Text(logs.role),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Activity: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.appPrimary),
                                        ),
                                        Text(logs.activity),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
