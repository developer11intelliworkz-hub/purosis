import 'package:get/get.dart';
import 'package:purosis/feature/admin/dashboard/view/dashboard_view.dart';
import 'package:purosis/feature/admin/marketing/view/marketing_content.dart';
import 'package:purosis/feature/admin/product/view/product_view.dart';
import 'package:purosis/feature/admin/profile/view/admin_profile_view.dart';

class DashboardControllerAdmin extends GetxController {
  List<String> screenNameList = [
    "Dashboard",
    "Products",
    "Marketing Assets",
    "Profile",
  ];
  List screenList = [
    DashboardView(),
    ProductView(),
    MarketingContent(),
    AdminProfileView(),
  ];
  int currentIndex = 0;
}
