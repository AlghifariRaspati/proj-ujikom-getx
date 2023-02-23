import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ujikom_getx/utils/colors.dart';
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

// Fungsi dibawah ini untuk mengambil role user yang ada di database dan mengarahkan mereka ke halamannya
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // mengambil role user dari firebase
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    // menunggu data dari firebase
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
            return FutureBuilder<DocumentSnapshot>(
              future: usersRef.doc(user.uid).get(),
              builder: (context, snapUser) {
                if (snapUser.connectionState == ConnectionState.waiting) {
                  return const LoadingScreen();
                }
                // mengarahkan default screen user berdasarkan role

                final userData = snapUser.data?.data() as Map<String, dynamic>?;

                final userRole = userData?['role'] as String? ?? 'unknown';

                switch (userRole) {
                  case 'admin':
                    return buildApp(Routes.home);
                  case 'cashier':
                    return buildApp(Routes.cashier_home);
                  case 'owner':
                    return buildApp(Routes.owner_home);
                  default:
                    return buildApp(Routes.login);
                }
              },
            );
          }

          return buildApp(Routes.login);
        },
      ),
    );
  }

  GetMaterialApp buildApp(String initialRoute) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: AppColor.appPrimary,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: AppPages.routes,
    );
  }
}
