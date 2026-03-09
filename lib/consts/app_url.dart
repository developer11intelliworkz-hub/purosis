class AppUrl {
  static const String _baseUrl = "http://192.168.0.116";
  static const String baseUrlApi = "$_baseUrl/purosis_laravel_app/public/api/";

  static const String sendOTPUrl = "/admin/send-otp";
  static const String verifyOTPUrl = "/admin/verify-otp";
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

  static const String getPostDistributorUrl = "distributor/get-post";
  static const String getBrochureDistributorUrl = "distributor/get-brochure";
  static const String getLeafletDistributorUrl = "distributor/get-leaflet";
  static const String getReelDistributorUrl = "distributor/get-reel";
}
