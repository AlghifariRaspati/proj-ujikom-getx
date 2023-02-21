import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'app/controllers/auth_controller.dart';

import 'app/modules/loading/loading.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController(), permanent: true);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // mengambil role user dari firebase
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

  Future<String> getUserRole(User user) async {
    final userDoc = await usersRef.doc(user.uid).get();

    if (userDoc.exists) {
      final userData = userDoc.data() as Map<String, dynamic>;
      final userRole = userData['role'] as String;
      return userRole;
    }

    return 'unknown';
  }

  @override
  Widget build(BuildContext context) {
    // mengarahkan default screen user berdasarkan role
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => StreamBuilder<User?>(
          stream: auth.authStateChanges(),
          builder: (context, snapAuth) {
            if (snapAuth.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            }

            if (snapAuth.hasData) {
              final user = snapAuth.data!;
              return FutureBuilder<String>(
                future: getUserRole(user),
                builder: (context, snapRole) {
                  if (snapRole.connectionState == ConnectionState.waiting) {
                    return const LoadingScreen();
                  }

                  final userRole = snapRole.data ?? 'unknown';

                  switch (userRole) {
                    case 'admin':
                      return GetMaterialApp(
                        debugShowCheckedModeBanner: false,
                        initialRoute: Routes.home,
                        getPages: AppPages.routes,
                      );
                    case 'cashier':
                      return GetMaterialApp(
                        debugShowCheckedModeBanner: false,
                        initialRoute: Routes.cashier_home,
                        getPages: AppPages.routes,
                      );
                    case 'owner':
                      return GetMaterialApp(
                        debugShowCheckedModeBanner: false,
                        initialRoute: Routes.owner_home,
                        getPages: AppPages.routes,
                      );
                    default:
                      return GetMaterialApp(
                        debugShowCheckedModeBanner: false,
                        initialRoute: Routes.login,
                        getPages: AppPages.routes,
                      );
                  }
                },
              );
            }

            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.login,
              getPages: AppPages.routes,
            );
          }),
    );
  }
}
