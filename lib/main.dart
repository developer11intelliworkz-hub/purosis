import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/auth/view/login_screen.dart';
import 'package:purosis/routes/app_pages.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/utils/api_service.dart';
import 'package:purosis/utils/app_theme.dart';
import 'package:purosis/utils/storage_service.dart';
import 'package:purosis/widget/filter_widget.dart';

import 'feature/admin/dashboard/view/dashboard_view.dart';
import 'feature/admin/dashboard/view/main_screen_admin.dart';
import 'feature/admin/dashboard/view/order_history.dart';
import 'feature/admin/marketing/view/add_new_post.dart';
import 'feature/admin/marketing/view/brochure_view.dart';
import 'feature/admin/marketing/view/leaflet_view.dart';
import 'feature/admin/marketing/view/social_media_post.dart';
import 'feature/admin/product/view/add_product.dart';
import 'feature/admin/product/view/product_view.dart';
import 'feature/admin/profile/view/admin_profile_view.dart';
import 'feature/admin/profile/view/user_activity_location.dart';
import 'feature/admin/profile/view/user_detail_view.dart';
import 'feature/admin/profile/view/user_management.dart';
import 'feature/admin/stock/view/promotional_stock.dart';
import 'feature/admin/stock/view/stock_inward.dart';
import 'feature/admin/stock/view/stock_outward.dart';
import 'feature/dealer/branding/view/brochures_view.dart';
import 'feature/dealer/branding/view/leaflets_view.dart';
import 'feature/dealer/dashboard/view/dealer_dashboard_view.dart';
import 'feature/dealer/dashboard/view/dealer_main_screen.dart';
import 'feature/dealer/profile/view/dealer_profile_view.dart';
import 'feature/distributor/profile/view/help_support_screen.dart';

void main() {
  initDependencies();
  runApp(const MyApp());
}

void initDependencies() {
  Get.put(StorageService(), permanent: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Purosis',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
