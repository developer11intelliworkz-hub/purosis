import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:purosis/feature/admin/dashboard/view/main_screen_admin.dart';
import 'package:purosis/feature/admin/marketing/view/add_new_brochure.dart';
import 'package:purosis/feature/admin/marketing/view/edit_brochure.dart';
import 'package:purosis/feature/admin/marketing/view/social_media_post.dart';
import 'package:purosis/feature/admin/profile/view/admin_profile_edit.dart';
import 'package:purosis/feature/admin/profile/view/user_detail_view.dart';
import 'package:purosis/feature/auth/view/otp_screen.dart';
import 'package:purosis/feature/auth/view/splash_screen.dart';
import 'package:purosis/feature/distributor/dashboard/view/main_screen.dart';
import 'package:purosis/widget/filter_widget.dart';

import '../feature/admin/marketing/view/add_new_post.dart';
import '../feature/admin/marketing/view/brochure_view.dart';
import '../feature/admin/product/view/add_product.dart';
import '../feature/admin/profile/view/user_activity_location.dart';
import '../feature/admin/profile/view/user_management.dart';
import '../feature/auth/view/login_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.otpScreen, page: () => const OtpScreen()),
    GetPage(
      name: AppRoutes.adminDashboard,
      page: () => const MainScreenAdmin(),
    ),
    GetPage(name: AppRoutes.addProduct, page: () => const AddProduct()),
    GetPage(name: AppRoutes.filter, page: () => const FilterWidget()),
    GetPage(name: AppRoutes.brochures, page: () => const BrochureView()),
    GetPage(name: AppRoutes.addBrochures, page: () => const AddNewBrochure()),
    GetPage(name: AppRoutes.editBrochures, page: () => const EditBrochure()),
    GetPage(name: AppRoutes.posts, page: () => const SocialMediaPost()),
    GetPage(name: AppRoutes.addPosts, page: () => const AddNewPost()),
    GetPage(
      name: AppRoutes.adminProfileEdit,
      page: () => const AdminProfileEdit(),
    ),
    GetPage(name: AppRoutes.userManagement, page: () => const UserManagement()),
    GetPage(name: AppRoutes.userManagement, page: () => const UserManagement()),
    GetPage(name: AppRoutes.userDetail, page: () => const UserDetailView()),
    GetPage(
      name: AppRoutes.activityLocation,
      page: () => const UserActivityLocation(),
    ),
  ];
}
