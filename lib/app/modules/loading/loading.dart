import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingView(),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appFive,
      body: Center(
        child: CircularProgressIndicator(
          color: AppColor.appPrimary,
        ),
      ),
    );
  }
}
