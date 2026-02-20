
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:purosis/feature/auth/view/otp_screen.dart';

import '../feature/auth/view/login_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.otpScreen,
      page: () => const OtpScreen(),
    ),
  ];
}
