import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ActivityLogController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamLogs() async* {
    yield* firestore
        .collection("logs")
        .orderBy("created_at", descending: true)
        .snapshots();
  }
}
