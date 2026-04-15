import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/routes/app_pages.dart';
import 'package:purosis/utils/app_theme.dart';
import 'package:purosis/utils/notification_handler.dart';
import 'package:purosis/utils/storage_service.dart';
import 'package:sizer/sizer.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await NotificationHandler.init();
  await initDependencies();
  runApp(const MyApp());
}

Future<void> initDependencies() async {
  // WidgetsFlutterBinding.ensureInitialized();
  Get.put(StorageService(), permanent: true);
  // await FlutterDownloader.initialize(
  //   debug: true,
  //   ignoreSsl: true,
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return SafeArea(
          top: false,
          child: GetMaterialApp(
            title: 'Purosis',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.themeData(),
            initialRoute: AppPages.initial,
            getPages: AppPages.routes,
          ),
        );
      },
    );
  }
}

//hello
