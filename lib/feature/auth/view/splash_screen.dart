import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/routes/app_routes.dart';

import '../../../consts/app_image.dart';
import '../../../utils/storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () async {
      final storage = Get.find<StorageService>();
      String? token = storage.token;
      if (token != null) {
        Get.offAllNamed(AppRoutes.adminDashboard);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Image.asset(AppImage.splash, fit: BoxFit.cover)),
    );
  }
}
