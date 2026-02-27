class AppUrl {
  static const String _baseUrl = "http://192.168.0.103";
  static const String baseUrlApi = "$_baseUrl/purosis_laravel_app/public/api/";

  static const String sendOTPUrl = "/admin/send-otp";
  static const String verifyOTPUrl = "/admin/verify-otp";
  static const String productCategoriesUrl = "/admin/get-categories";
  static const String productSubCategoriesUrl = "/admin/get-sub-categories";
  static const String getProductsUrl = "/admin/get-products";
  static const String addUpdateProductUrl = "/admin/add-update-product";
  static const String getBrochuresUrl = "/admin/get-brochures";
  static const String addUpdateBrochureUrl = "/admin/add-update-brochure";
}
