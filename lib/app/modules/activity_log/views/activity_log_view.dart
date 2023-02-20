import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/activity_log_controller.dart';

class ActivityLogView extends GetView<ActivityLogController> {
  const ActivityLogView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ActivityLogView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ActivityLogView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
