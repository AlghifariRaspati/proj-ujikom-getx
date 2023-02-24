import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddProductController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data) async {
    try {
      data['created_at'] = FieldValue.serverTimestamp();

      var hasil = await firestore.collection("products").add(data);
      await firestore.collection("products").doc(hasil.id).update({
        "id": hasil.id,
        "created_at": DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
      });
      String? uid = auth.currentUser?.uid;
      String email =
          auth.currentUser?.email ?? ''; // ambil email user yang sedang log in
      String dateTimeStr =
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
      Map<String, dynamic> logData = {
        "email": email,
        "activity": "Added a Product",
        "id": uid,
      };

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("logs")
          .doc(dateTimeStr)
          .set(logData);

      return {"error": false, "message": "Add Product successful"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      return {"error": true, "message": "Failed to add Product"};
    }
  }
}
