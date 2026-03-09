import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:purosis/feature/admin/dashboard/view/main_screen_admin.dart';
import 'package:purosis/feature/admin/marketing/view/add_new_brochure.dart';
import 'package:purosis/feature/admin/marketing/view/edit_brochure.dart';
import 'package:purosis/feature/admin/marketing/view/reels_view.dart';
import 'package:purosis/feature/admin/marketing/view/social_media_post.dart';
import 'package:purosis/feature/admin/profile/view/admin_profile_edit.dart';
import 'package:purosis/feature/admin/profile/view/user_detail_view.dart';
import 'package:purosis/feature/auth/view/otp_screen.dart';
import 'package:purosis/feature/auth/view/splash_screen.dart';
import 'package:purosis/feature/dealer/marketing/view/brochures_view_dealer.dart';
import 'package:purosis/feature/dealer/marketing/view/posts_view_dealer.dart';
import 'package:purosis/feature/dealer/marketing/view/reels_view_dealer.dart';
import 'package:purosis/feature/dealer/marketing/view/video_view_dealer.dart';
import 'package:purosis/feature/distributor/marketing/view/posts_view_distributor.dart';
import 'package:purosis/feature/distributor/marketing/view/reels_view_distributor.dart';
import 'package:purosis/widget/filter_widget.dart';

import '../feature/admin/marketing/view/add_new_leaflet.dart';
import '../feature/admin/marketing/view/add_new_post.dart';
import '../feature/admin/marketing/view/add_new_reels.dart';
import '../feature/admin/marketing/view/add_new_video.dart';
import '../feature/admin/marketing/view/brochure_view.dart';
import '../feature/admin/marketing/view/leaflet_view.dart';
import '../feature/admin/marketing/view/video_view.dart';
import '../feature/admin/product/view/add_product.dart';
import '../feature/admin/profile/view/user_activity_location.dart';
import '../feature/admin/profile/view/user_management.dart';
import '../feature/auth/view/login_screen.dart';
import '../feature/dealer/dashboard/view/dealer_main_screen.dart';
import '../feature/dealer/marketing/view/leafleats_view_dealer.dart';
import '../feature/distributor/dashboard/view/distributor_main_screen.dart';
import '../feature/distributor/marketing/view/brochures_view_distributor.dart';
import '../feature/distributor/marketing/view/leafleats_view_distributor.dart';
import '../feature/distributor/marketing/view/video_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.dealerDashboard;

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
    GetPage(name: AppRoutes.reels, page: () => const ReelsView()),
    GetPage(name: AppRoutes.addReels, page: () => const AddNewReels()),
    GetPage(name: AppRoutes.video, page: () => const VideoView()),
    GetPage(name: AppRoutes.addVideo, page: () => const AddNewVideo()),
    GetPage(name: AppRoutes.leaflet, page: () => const LeafletView()),
    GetPage(name: AppRoutes.addLeaflet, page: () => const AddNewLeaflet()),

    //Distributor
    GetPage(
      name: AppRoutes.distributorDashboard,
      page: () => const DistributorMainScreen(),
    ),
    GetPage(
      name: AppRoutes.postViewDistributor,
      page: () => const PostsViewDistributor(),
    ),
    GetPage(
      name: AppRoutes.brochuresViewDistributor,
      page: () => const BrochuresViewDistributor(),
    ),
    GetPage(
      name: AppRoutes.videoViewDistributor,
      page: () => const VideoViewDistributor(),
    ),
    GetPage(
      name: AppRoutes.reelViewDistributor,
      page: () => const ReelsViewDistributor(),
    ),
    GetPage(
      name: AppRoutes.leafletViewDistributor,
      page: () => const LeafleatsViewDistributor(),
    ),

    //Dealer
    GetPage(
      name: AppRoutes.dealerDashboard,
      page: () => const DealerMainScreen(),
    ),
    GetPage(
      name: AppRoutes.brochuresDealer,
      page: () => const BrochuresViewDealer(),
    ),
    GetPage(
      name: AppRoutes.leafletDealer,
      page: () => const LeafleatsViewDealer(),
    ),
    GetPage(name: AppRoutes.postDealer, page: () => const PostsViewDealer()),
    GetPage(name: AppRoutes.reelDealer, page: () => const ReelsViewDealer()),
    GetPage(name: AppRoutes.videoDealer, page: () => const VideoViewDealer()),
  ];
}
