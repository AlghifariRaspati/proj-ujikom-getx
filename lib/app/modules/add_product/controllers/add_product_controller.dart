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
      Timestamp timestamp = Timestamp.now();
      String? uid = auth.currentUser?.uid;
      String role = "admin";
      String email =
          auth.currentUser?.email ?? ''; // ambil email user yang sedang log in
      String dateTimeStr =
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());

      var hasil = await firestore.collection("products").add(data);
      await firestore.collection("products").doc(hasil.id).update({
        "id": hasil.id,
        "created_at": timestamp,
      });

      Map<String, dynamic> logData = {
        "email": email,
        "role": role,
        "activity": "Added a Product",
        "id": uid,
        "created_at": timestamp
      };

      await FirebaseFirestore.instance
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
