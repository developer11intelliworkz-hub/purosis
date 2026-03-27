import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/distributor/dashboard/view/dashboard_view.dart';

import '../../marketing/view/marketing_assets_view.dart';
import '../../product/view/product_view.dart';
import '../../profile/view/profile_view.dart';

class DashboardController extends GetxController {
  List<String> screenNameList = [
    "Dashboard",
    "Products",
    "Marketing Assets",
    "Profile",
  ];
  List<Widget> distributorList = [
    DashboardView(),
    ProductView(),
    MarketingAssetsView(),
    ProfileView(),
  ];
  int selectedIndex = 0;
}
