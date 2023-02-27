import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ActivityLogController extends GetxController {
  var isLogsSelected = true.obs;
  var isTransactionsSelected = false.obs;
  var isActivitySelected = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamLogs() async* {
    yield* firestore.collection("logs").snapshots();
  }
}
