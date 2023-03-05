import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

class CashierTransactionController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingDelete = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamLogs() async* {
    yield* firestore.collection("products").snapshots();
  }

  Future<Map<String, dynamic>> addTransaction(Map<String, dynamic> data) async {
    try {
      data['created_at'] = FieldValue.serverTimestamp();
      Timestamp timestamp = Timestamp.now();

      String email =
          auth.currentUser?.email ?? ''; // ambil email user yang sedang log in
      String uid =
          auth.currentUser?.uid ?? ''; // ambil uid user yang sedang log in

      var hasil = await firestore.collection("transactions").add(data);
      //item id
      int id = Random().nextInt(1000000);

      await firestore.collection("transactions").doc(hasil.id).update({
        "email_kasir": email,
        "nomor_unik": id,
        "id": hasil.id,
        "id_kasir": uid,
        "created_at": timestamp,
      });

      return {"error": false, "message": "Create Order successful"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      return {"error": true, "message": "Failed to add Order"};
    }
  }
}
