import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../routes/app_pages.dart';

class AuthController extends GetxController {
  String? uid; // cek kondisi ada auth atau tidak -> uid
  // Null -> tidak ada user yang sedang login
  // uid -> ada user yang sedang login

  late FirebaseAuth auth;
  late CollectionReference usersRef;

  // login user dan data masuk kedalam logs
  Future<Map<String, dynamic>> login(String email, String pass) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      String? uid = auth.currentUser?.uid;

      String timestamp =
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now().toLocal());

      // add user updated at
      Map<String, dynamic> userData = {
        "id": uid,
        "email": email,
        "password": pass,
        "updated_at": timestamp
      };

      // Add the user data to the "users" collection
      await usersRef.doc(uid).update(userData);

      Map<String, dynamic> logData = {
        "activity": "logged in",
        "id": uid,
        "updated_at":
            DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now().toLocal()),
      };

      // Add the log data to the "log" collection
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("logs")
          .doc(uid)
          .set(logData);

      return {"error": false, "message": "Login Success"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      //error biasa
      return {"error": true, "message": "Failed to Login"};
    }
  }

  // logout user dan data masuk ke dalam logs
  Future<Map<String, dynamic>> logout() async {
    try {
      String? uid = auth.currentUser?.uid;
      Map<String, dynamic> logData = {
        "activity": "logged out",
        "id": uid,
        "updated_at":
            DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now().toLocal()),
      };

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("logs")
          .doc(uid)
          .set(logData);
      await auth.signOut();

      return {"error": false, "message": "Log Out Success"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      //error biasa
      return {"error": true, "message": "Failed to Log Out"};
    }
  }

  Future<Map<String, dynamic>> register(String email, String pass) async {
    try {
      FirebaseApp app = await Firebase.initializeApp(
          name: 'Secondary', options: Firebase.app().options);
      UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email, password: pass);
      String? uid = userCredential.user?.uid;
      await app.delete();

      String timestamp =
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now().toLocal());

      // add user created at
      Map<String, dynamic> userData = {
        "id": uid,
        "email": email,
        "role": "cashier",
        "password": pass,
        "created_at": timestamp
      };

      // Add the user data to the "users" collection
      await usersRef.doc(uid).set(userData);

      return {"error": false, "message": "Registration Success"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      //error biasa
      return {"error": true, "message": "Failed to register"};
    }
  }

  // mengecek role user dan mengarahkan ke halaman yang menyangkut role nya
  Future<void> checkUserRoleAndNavigate() async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return;
      }

      final userDataSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final userRole = userDataSnapshot.get('role');

      if (userRole == 'owner') {
        Get.offAllNamed(Routes.owner_home);
      } else if (userRole == 'admin') {
        Get.offAllNamed(Routes.home);
      } else if (userRole == 'cashier') {
        Get.offAllNamed(Routes.cashier_home);
      } else {
        Get.offAllNamed(Routes.login);
      }
    } catch (e) {
      debugPrint('Error checking user role: $e');
    }
  }

  @override
  void onInit() {
    auth = FirebaseAuth.instance;
    usersRef = FirebaseFirestore.instance.collection('users');

    auth.authStateChanges().listen((event) {
      uid = event?.uid;
    });
    super.onInit();
  }
}
