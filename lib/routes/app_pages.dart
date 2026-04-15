import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:purosis/feature/admin/dashboard/view/main_screen_admin.dart';
import 'package:purosis/feature/admin/dashboard/view/order_detail_view.dart';
import 'package:purosis/feature/admin/dashboard/view/order_history_admin.dart';
import 'package:purosis/feature/admin/marketing/view/add_new_brochure.dart';
import 'package:purosis/feature/admin/marketing/view/edit_brochure.dart';
import 'package:purosis/feature/admin/marketing/view/edit_leaflet.dart';
import 'package:purosis/feature/admin/marketing/view/edit_video.dart';
import 'package:purosis/feature/admin/marketing/view/reels_view.dart';
import 'package:purosis/feature/admin/marketing/view/social_media_post.dart';
import 'package:purosis/feature/admin/product/view/add_image_view.dart';
import 'package:purosis/feature/admin/product/view/product_detail_view.dart';
import 'package:purosis/feature/admin/profile/view/add_banner_view.dart';
import 'package:purosis/feature/admin/profile/view/admin_profile_edit.dart';
import 'package:purosis/feature/admin/profile/view/user_detail_view.dart';
import 'package:purosis/feature/admin/stock/view/edit_stock.dart';
import 'package:purosis/feature/admin/stock/view/promotional_stock.dart';
import 'package:purosis/feature/admin/stock/view/stock_outward.dart';
import 'package:purosis/feature/auth/view/otp_screen.dart';
import 'package:purosis/feature/auth/view/splash_screen.dart';
import 'package:purosis/feature/dealer/marketing/view/brochures_view_dealer.dart';
import 'package:purosis/feature/dealer/marketing/view/posts_view_dealer.dart';
import 'package:purosis/feature/dealer/marketing/view/reels_view_dealer.dart';
import 'package:purosis/feature/dealer/marketing/view/video_view_dealer.dart';
import 'package:purosis/feature/dealer/profile/view/edit_profile_view.dart';
import 'package:purosis/feature/distributor/cart/view/cart_view.dart';
import 'package:purosis/feature/distributor/cart/view/dealer_info_view.dart';
import 'package:purosis/feature/distributor/marketing/view/customize_post_distributor.dart';
import 'package:purosis/feature/distributor/marketing/view/customize_post_preview_distributor.dart';
import 'package:purosis/feature/distributor/marketing/view/posts_view_distributor.dart';
import 'package:purosis/feature/distributor/marketing/view/reels_view_distributor.dart';
import 'package:purosis/feature/distributor/product/view/product_detail.dart';
import 'package:purosis/feature/distributor/profile/view/add_new_address.dart';
import 'package:purosis/feature/distributor/profile/view/edit_address.dart';
import 'package:purosis/feature/distributor/profile/view/order_history.dart';
import 'package:purosis/widget/filter_marketing_widget.dart';
import 'package:purosis/widget/filter_widget.dart';

import '../feature/admin/marketing/view/add_new_leaflet.dart';
import '../feature/admin/marketing/view/add_new_post.dart';
import '../feature/admin/marketing/view/add_new_reels.dart';
import '../feature/admin/marketing/view/add_new_video.dart';
import '../feature/admin/marketing/view/brochure_view.dart';
import '../feature/admin/marketing/view/edit_post.dart';
import '../feature/admin/marketing/view/edit_reel.dart';
import '../feature/admin/marketing/view/leaflet_view.dart';
import '../feature/admin/marketing/view/video_view.dart';
import '../feature/admin/product/view/add_product.dart';
import '../feature/admin/product/view/edit_product.dart';
import '../feature/admin/product/view/image_edit_view.dart';
import '../feature/admin/profile/view/add_user.dart';
import '../feature/admin/profile/view/banner_view.dart';
import '../feature/admin/profile/view/edit_banner_view.dart';
import '../feature/admin/profile/view/edit_user.dart';
import '../feature/admin/profile/view/help_support_view.dart';
import '../feature/admin/profile/view/notification_screen.dart';
import '../feature/admin/profile/view/support_message_view.dart';
import '../feature/admin/profile/view/user_activity_location.dart';
import '../feature/admin/profile/view/user_management.dart';
import '../feature/admin/stock/view/stock_inward.dart';
import '../feature/auth/view/login_screen.dart';
import '../feature/dealer/dashboard/view/dealer_main_screen.dart';
import '../feature/dealer/marketing/view/customize_post.dart';
import '../feature/dealer/marketing/view/customize_post_preview.dart';
import '../feature/dealer/marketing/view/leafleats_view_dealer.dart';
import '../feature/dealer/profile/view/dealer_profile_view.dart';
import '../feature/distributor/cart/view/review_view.dart';
import '../feature/distributor/cart/view/transport_view.dart';
import '../feature/distributor/dashboard/view/distributor_main_screen.dart';
import '../feature/distributor/marketing/view/brochures_view_distributor.dart';
import '../feature/distributor/marketing/view/leafleats_view_distributor.dart';
import '../feature/distributor/marketing/view/video_view.dart';
import '../feature/distributor/profile/view/address_view.dart';
import '../feature/distributor/profile/view/edit_profile.dart';
import '../feature/distributor/profile/view/help_support_screen.dart';
import '../feature/distributor/dashboard/view/notification_screen_distributor.dart';
import '../feature/distributor/profile/view/order_detail.dart';
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
    // GetPage(name: AppRoutes.userManagement, page: () => const UserManagement()),
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
    GetPage(
      name: AppRoutes.promotionalStock,
      page: () => const PromotionalStock(),
    ),
    GetPage(
      name: AppRoutes.inwardPromotionalStock,
      page: () => const StockInward(),
    ),
    GetPage(
      name: AppRoutes.outwardPromotionalStock,
      page: () => const StockOutward(),
    ),
    GetPage(name: AppRoutes.addUser, page: () => const AddUser()),
    GetPage(name: AppRoutes.editPost, page: () => const EditPost()),
    GetPage(name: AppRoutes.editReel, page: () => const EditReel()),
    GetPage(name: AppRoutes.editVideo, page: () => const EditVideo()),
    GetPage(
      name: AppRoutes.productDetailView,
      page: () => const ProductDetailView(),
    ),
    GetPage(
      name: AppRoutes.orderHistoryAdmin,
      page: () => const OrderHistoryAdmin(),
    ),
    GetPage(
      name: AppRoutes.orderDetailView,
      page: () => const OrderDetailView(),
    ),
    GetPage(name: AppRoutes.editLeaflet, page: () => const EditLeaflet()),
    GetPage(
      name: AppRoutes.helpSupportView,
      page: () => const HelpSupportView(),
    ),
    GetPage(name: AppRoutes.addBannerView, page: () => const AddBannerView()),
    GetPage(name: AppRoutes.bannerView, page: () => const BannerView()),
    GetPage(name: AppRoutes.editBannerView, page: () => const EditBannerView()),
    GetPage(
      name: AppRoutes.supportMessageView,
      page: () => const SupportMessageView(),
    ),
    GetPage(name: AppRoutes.editDistributor, page: () => const EditUser()),
    GetPage(
      name: AppRoutes.notificationScreen,
      page: () => const NotificationScreen(),
    ),
    GetPage(name: AppRoutes.editStock, page: () => const EditStock()),
    GetPage(name: AppRoutes.editProduct, page: () => const EditProduct()),
    GetPage(name: AppRoutes.imageEditView, page: () => const ImageEditView()),
    GetPage(name: AppRoutes.addImageView, page: () => const AddImageView()),

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
      page: () => const BrochuresViewDistributorDashboard(),
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
    GetPage(name: AppRoutes.productDetail, page: () => const ProductDetail()),
    GetPage(name: AppRoutes.addressView, page: () => const AddressView()),
    GetPage(name: AppRoutes.addAddressView, page: () => AddNewAddress()),
    GetPage(name: AppRoutes.editAddressView, page: () => EditAddress()),
    GetPage(name: AppRoutes.editProfileView, page: () => EditProfile()),
    GetPage(name: AppRoutes.cartView, page: () => CartView()),
    GetPage(name: AppRoutes.dealerInfoView, page: () => DealerInfoView()),
    GetPage(name: AppRoutes.transportView, page: () => TransportView()),
    GetPage(name: AppRoutes.reviewView, page: () => ReviewView()),
    GetPage(name: AppRoutes.orderHistory, page: () => OrderHistory()),
    GetPage(name: AppRoutes.helpSupportScreen, page: () => HelpSupportScreen()),
    GetPage(
      name: AppRoutes.customizePostDistributor,
      page: () => CustomizePostDistributor(),
    ),
    GetPage(
      name: AppRoutes.customizePostPreviewDistributor,
      page: () => CustomizePostPreviewDistributor(),
    ),
    GetPage(name: AppRoutes.orderDetail, page: () => OrderDetail()),
    GetPage(
      name: AppRoutes.notificationScreenDistributor,
      page: () => NotificationScreenDistributor(),
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
    GetPage(
      name: AppRoutes.profileDealer,
      page: () => const DealerProfileView(),
    ),
    GetPage(
      name: AppRoutes.filterMarketingPost,
      page: () => const FilterMarketingWidget(typeOfCategories: 'post'),
    ),
    GetPage(
      name: AppRoutes.filterMarketingReel,
      page: () => const FilterMarketingWidget(typeOfCategories: 'reel'),
    ),
    GetPage(
      name: AppRoutes.filterMarketingVideo,
      page: () => const FilterMarketingWidget(typeOfCategories: 'video'),
    ),
    GetPage(
      name: AppRoutes.filterMarketingBrochures,
      page: () => const FilterMarketingWidget(typeOfCategories: 'brochures'),
    ),
    GetPage(
      name: AppRoutes.filterMarketingLeaflets,
      page: () => const FilterMarketingWidget(typeOfCategories: 'leaflets'),
    ),
    GetPage(
      name: AppRoutes.editProfileDealer,
      page: () => const EditProfileView(),
    ),
    GetPage(name: AppRoutes.customizePost, page: () => const CustomizePost()),
    GetPage(
      name: AppRoutes.customizePostPreview,
      page: () => const CustomizePostPreview(),
    ),
  ];
}
