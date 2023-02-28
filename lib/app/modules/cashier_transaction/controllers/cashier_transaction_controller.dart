import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

class CashierTransactionController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var selectedCategory = ''.obs;
  var selectedPrice = 0.obs;

  void createOrder(
      {required String name,
      required String telephone,
      required String paymentAmount}) async {
    try {
      isLoading.value = true;
      await firestore.collection('orders').add({
        'name': name,
        'telephone': telephone,
        'category': selectedCategory.value,
        'price': selectedPrice.value,
        'payment_amount': paymentAmount,
      });
      selectedCategory.value = '';
      selectedPrice.value = 0;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamLogs() async* {
    yield* firestore.collection("products").snapshots();
  }
}
