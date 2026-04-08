class AppUrl {
  static const String _baseUrl = "http://192.168.0.57";
  static const String baseUrlApi = "$_baseUrl/purosis_laravel_app/public/api/";

  static const String sendOTPUrl = "/admin/send-otp";
  static const String verifyOTPUrl = "/admin/verify-otp";
  static const String sendUserOTPUrl = "/user/send-otp";
  static const String verifyUserOTPUrl = "/user/verify-otp";

  static const String productCategoriesUrl = "/admin/get-categories";
  static const String productSubCategoriesUrl = "/admin/get-sub-categories";
  static const String getProductsUrl = "/admin/get-products";
  static const String addUpdateProductUrl = "/admin/add-update-product";
  static const String getBrochuresUrl = "/admin/get-brochures";
  static const String addUpdateBrochureUrl = "/admin/add-update-brochure";
  static const String addUpdatePostUrl = "/admin/add-update-post";
  static const String getPostUrl = "/admin/get-posts";
  static const String addUpdateReelUrl = "/admin/add-update-reel";
  static const String getReelsUrl = "/admin/get-reels";
  static const String addUpdateVideoUrl = "/admin/add-update-video";
  static const String getVideoUrl = "/admin/get-videos";
  static const String getLeafletsUrl = "/admin/get-leaflets";
  static const String inwardStockUrl = "/admin/stock-inward";
  static const String outwardStockUrl = "/admin/stock-outward";
  static const String addUpdateUserUrl = "/admin/add-update-distributor";
  static const String getUserUrl = "/admin/get-distributor";
  static const String getDashboardData = "/admin/get-dashboard-data";
  static const String getOrderHistory = "/admin/order-history";
  static const String getOrderDetail = "/admin/order-details";
  static const String approveDeclineOrderUrl = "/admin/approve-decline-order";
  static const String updateShippingStatusUrl = "/admin/update-shipping-status";
  static const String updateSupportDetailUrl = "/admin/update-support-details";
  static const String updateUserStatusUrl = "/admin/update-distributor-status";
  static const String getSupportDetailsUrl = "/get-support-details";
  static const String getSupportMessageUrl =
      "/admin/get-support-message-inquiries";
  static const String updateAdminProfileUrl = "/admin/update-profile";
  static const String addUpdateBannerUrl = "/admin/add-update-banner";
  static const String getBannerUrl = "/admin/get-banners";
  static const String deleteBannerUrl = "/admin/delete-banner";
  static const String activityLogsUrl = "/admin/user-activity-logs";

  // static const String getPostDistributorUrl = "/distributor/get-posts";
  // static const String getBrochureDistributorUrl = "/distributor/get-brochures";
  // static const String getLeafletDistributorUrl = "/distributor/get-leaflets";
  // static const String getReelDistributorUrl = "/distributor/get-reels";
  static const String addUpdateAddressUrl = "/distributor/add-update-address";
  static const String getAddressUrl = "/distributor/get-addresses";
  static const String deleteAddressUrl = "/distributor/delete-address";
  static const String updateProfileDistributorUrl =
      "/distributor/update-profile";
  static const String addToCartUrl = "/distributor/add-to-cart";
  static const String getCartUrl = "/distributor/view-cart";
  static const String placeOrderUrl = "/distributor/place-order";
  static const String getOrderHistoryUrl = "/distributor/order-history";
  static const String deleteCartUrl = "/distributor/delete-cart";
  static const String sendSupportMessageUrl =
      "/distributor/support-message-inquiry";

  static const String productsSubCategoriesUrl = "/user/get-subcategories";
  static const String getProductsUserUrl = "/user/get-products";
  static const String getDetailsUrl = "/user/get-details";
  static const String getPostUserUrl = "/user/get-posts";
  static const String getBrochureUserUrl = "/user/get-brochures";
  static const String getLeafletUserUrl = "/user/get-leaflets";
  static const String getReelUserUrl = "/user/get-reels";
  static const String getVideosUserUrl = "/user/get-videos";
  static const String updateProfileUrl = "/dealer/update-profile";
  static const String getBannersUrl = "/user/get-banners";
  static const String getCategoriesUserUrl = "/user/get-categories";

  static const String getPinCodeDetail =
      "https://api.postalpincode.in/pincode/";
}
