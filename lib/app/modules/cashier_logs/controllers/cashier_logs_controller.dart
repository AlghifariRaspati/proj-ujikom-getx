import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

class CashierLogsController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamLogs() async* {
    final auth = FirebaseAuth.instance;
    final currentUser = auth.currentUser;

    final userUid = currentUser?.uid;

    yield* firestore
        .collection("transactions")
        .where("id_kasir", isEqualTo: userUid)
        .snapshots();
  }
}
