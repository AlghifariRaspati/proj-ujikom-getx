import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data) async {
    try {
      var hasil = await firestore.collection("products").add(data);
      await firestore
          .collection("products")
          .doc(hasil.id)
          .update({"prouct_Id": hasil.id});

      return {"error": false, "message": "Add product successful"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      debugPrint(e.toString());
      //error biasa
      return {"error": true, "message": "Failed to add product"};
    }
  }
}
