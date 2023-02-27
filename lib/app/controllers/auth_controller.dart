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
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());

      // tambah updated_at user
      Map<String, dynamic> userData = {
        "id": uid,
        "email": email,
        "password": pass,
        "updated_at": timestamp
      };

      // tambah data user ke firebase
      await usersRef.doc(uid).update(userData);
      DocumentSnapshot userDoc = await usersRef.doc(uid).get();
      String role = userDoc.get("role");

      Map<String, dynamic> logData = {
        "email": email,
        "role": role,
        "activity": "Logged in",
        "id": uid,
        "created_at": timestamp
      };

      // tambah log data ke bagian logs
      await FirebaseFirestore.instance
          .collection("logs")
          .doc(timestamp)
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
      String email =
          auth.currentUser?.email ?? ''; // get the current user's email address
      String timestamp =
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());

      DocumentSnapshot userDoc = await usersRef.doc(uid).get();
      String role = userDoc.get("role");
      Map<String, dynamic> logData = {
        "email": email,
        "role": role,
        "activity": "Logged Out",
        "id": uid,
        "created_at": timestamp
      };

      await FirebaseFirestore.instance
          .collection("logs")
          .doc(timestamp)
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
          DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());

      // tambah user created_at
      Map<String, dynamic> userData = {
        "id": uid,
        "email": email,
        "role": "cashier",
        "password": pass,
        "created_at": timestamp
      };

      // Tambah data user ke database users
      await usersRef.doc(uid).set(userData);

      // Dapatkan UID dari user yang sedang login
      String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;
      String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;

      DocumentSnapshot userDoc = await usersRef.doc(uid).get();
      String role = userDoc.get("role");

      Map<String, dynamic> logData = {
        "email": currentUserEmail,
        "role": role,
        "activity": "Registered a User",
        "id": currentUserUid,
        "created_at": timestamp
      };

      // Tambah data log ke collection logs di bawah user yang sedang login
      await FirebaseFirestore.instance
          .collection("logs")
          .doc(timestamp)
          .set(logData);

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
