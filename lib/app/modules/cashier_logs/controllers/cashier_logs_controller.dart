import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CashierLogsController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamLogs() async* {
    yield* firestore
        .collection("transactions")
        .orderBy("created_at", descending: true)
        .snapshots();
  }
}
