import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// MASIH BUTUH ADMIN SDK UNTUK MENGUBAH DAN MENDELETE USER

class CashierDetailsController extends GetxController {
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingDelete = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> editUser(Map<String, dynamic> data) async {
    try {
      data['updated_at'] = FieldValue.serverTimestamp();

      await firestore.collection("users").doc(data["id"]).update({
        "email": data["email"],
        "password": data["password"],
        "updated_at": DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
      });

      return {"error": false, "message": "Update User successful"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      return {"error": true, "message": "Failed to Update User"};
    }
  }

  Future<Map<String, dynamic>> deleteUser(String id) async {
    try {
      await firestore.collection("users").doc(id).delete();

      return {"error": false, "message": "Delete User successful"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      return {"error": true, "message": "Failed to Delete User"};
    }
  }
}
