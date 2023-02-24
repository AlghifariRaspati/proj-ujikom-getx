import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductsDetailController extends GetxController {
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingDelete = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> editProduct(Map<String, dynamic> data) async {
    try {
      data['updated_at'] = FieldValue.serverTimestamp();

      await firestore.collection("products").doc(data["id"]).update({
        "nama_produk": data["nama_produk"],
        "harga": data["harga"],
        "updated_at": DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
      });

      String? uid = auth.currentUser?.uid;
      String email =
          auth.currentUser?.email ?? ''; // ambil email user yang sedang log in
      String dateTimeStr =
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
      Map<String, dynamic> logData = {
        "email": email,
        "activity": "Edited a Product",
        "id": uid,
      };

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("logs")
          .doc(dateTimeStr)
          .set(logData);

      return {"error": false, "message": "Update Product successful"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      return {"error": true, "message": "Failed to Update Product"};
    }
  }

  Future<Map<String, dynamic>> deleteProduct(String id) async {
    try {
      String? uid = auth.currentUser?.uid;
      String email =
          auth.currentUser?.email ?? ''; // ambil email user yang sedang log in
      String dateTimeStr =
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
      Map<String, dynamic> logData = {
        "email": email,
        "activity": "Deleted a Product",
        "id": uid,
      };
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("logs")
          .doc(dateTimeStr)
          .set(logData);
      await firestore.collection("products").doc(id).delete();

      return {"error": false, "message": "Delete Product successful"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      return {"error": true, "message": "Failed to Delete Product"};
    }
  }
}
