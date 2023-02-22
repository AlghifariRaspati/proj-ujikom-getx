import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CashiersController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProducts() async* {
    // mengambil data user yang ada
    yield* firestore
        .collection("users")
        .where("role", isEqualTo: "cashier")
        .snapshots();
  }
}
