import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/colors.dart';
import '../../../data/models/transactions_model.dart';

import '../../../routes/app_pages.dart';
import '../controllers/cashier_logs_controller.dart';

class CashierLogsView extends GetView<CashierLogsController> {
  CashierLogsView({Key? key}) : super(key: key);
  final dateFormat = DateFormat("yyyy-MM-dd, HH:mm:ss");

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
        backgroundColor: AppColor.appPrimary,
        elevation: 0,
        title: const Text(
          'Transaction Logs',
          style: TextStyle(
              fontFamily: "Product Sans", fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.streamLogs(),
              builder: (context, snapLogs) {
                // cek jika ada data
                if (snapLogs.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColor.appPrimary,
                    ),
                  );
                }

                if (snapLogs.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Data",
                    ),
                  );
                }

                // buat list product dari stream data
                final allLogs = List<TransLogsModel>.from(
                  snapLogs.data!.docs.map(
                    (doc) => TransLogsModel.fromJson(doc.data()),
                  ),
                );

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: allLogs.length,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final logs = allLogs[index];
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.only(bottom: 20.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () async {
                          Get.toNamed(
                            Routes.trans_log_details,
                            arguments: logs,
                          );
                        },
                        borderRadius: BorderRadius.circular(8),
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
                                        Text("Created At: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.appSecondary,
                                                fontSize: 14.sp,
                                                fontFamily: "Product Sans")),
                                        Expanded(
                                          child: Text(
                                            DateFormat("yyyy-MM-dd, HH:mm:ss")
                                                .format(
                                              logs.createdAt,
                                            ),
                                            style: TextStyle(
                                                fontFamily: "Product Sans",
                                                color: Colors.black
                                                    .withOpacity(0.7)),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      children: [
                                        Text("Cashier: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.appSecondary,
                                                fontSize: 14.sp,
                                                fontFamily: "Product Sans")),
                                        Expanded(
                                          child: Text(
                                            logs.email,
                                            style: TextStyle(
                                                fontFamily: "Product Sans",
                                                color: Colors.black
                                                    .withOpacity(0.7)),
                                            overflow: TextOverflow.ellipsis,
                                          ),
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
                                        Text("Transaction ID: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.appSecondary,
                                                fontSize: 14.sp,
                                                fontFamily: "Product Sans")),
                                        Expanded(
                                          child: Text(
                                            logs.id,
                                            style: TextStyle(
                                                fontFamily: "Product Sans",
                                                color: Colors.black
                                                    .withOpacity(0.7)),
                                            overflow: TextOverflow.ellipsis,
                                          ),
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
                                        Text("Unique Number: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.appSecondary,
                                                fontFamily: "Product Sans")),
                                        Expanded(
                                            child: Text(
                                          logs.nomorUnik.toString(),
                                          style: TextStyle(
                                              fontFamily: "Product Sans",
                                              color: Colors.black
                                                  .withOpacity(0.7)),
                                          overflow: TextOverflow.ellipsis,
                                        ))
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
                      ),
                    );
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
