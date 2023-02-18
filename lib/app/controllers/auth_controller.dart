import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  String? uid; // cek kondisi ada auth atau tidak -> uid
  // Null -> tidak ada user yang sedang login
  // uid -> ada user yang sedang login

  late FirebaseAuth auth;

  Future<Map<String, dynamic>> login(String email, String pass) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);

      return {"error": false, "message": "Berhasil login"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      //error biasa
      return {"error": true, "message": "tidak dapat login"};
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      await auth.signOut();

      return {"error": false, "message": "Login Success"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      //error biasa
      return {"error": true, "message": "Failed to Login"};
    }
  }

  @override
  void onInit() {
    auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((event) {
      uid = event?.uid;
    });
    super.onInit();
  }
}
