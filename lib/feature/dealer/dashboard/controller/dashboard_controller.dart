import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/dealer/dashboard/view/dealer_dashboard_view.dart';
import 'package:purosis/feature/dealer/marketing/view/posts_view_dealer.dart';
import 'package:purosis/feature/dealer/marketing/view/reels_view_dealer.dart';
import 'package:purosis/feature/dealer/marketing/view/video_view_dealer.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../../../../consts/storage_keys.dart';
import '../../../../utils/storage_service.dart';
import '../../../auth/model/user_model.dart';
import '../../marketing/view/branding_view_dealer.dart';
import '../model/dashboard_data_model.dart';

class DashboardController extends GetxController {
  final ApiService apiService = ApiService();
  final storage = Get.find<StorageService>();
  List<Widget> screenList = [
    DealerDashboardView(),
    PostsViewDealer(isAppBarShow: false),
    ReelsViewDealer(isAppBarShow: false),
    VideoViewDealer(isAppBarShow: false),
    BrandingViewDealer(),
  ];

  List<String> titleList = [
    "Dashboard",
    "Posts",
    "Reels",
    "Videos",
    "Branding",
  ];

  DashboardDataModel? dashboardDataModel;
  int bannerCurrentIndex = 0;
  bool isDashboardDataLoading = false;
  int selectedIndex = 0;

  setHeader() {
    final data = storage.read(StorageKeys.userData);
    UserModel userModel = UserModel.fromJson(data);
    titleList = [
      "Hi, ${userModel.companyName ?? "Guest"}",
      "Posts",
      "Reels",
      "Videos",
      "Branding",
    ];
  }

  Future<void> getDashboardDataApi() async {
    isDashboardDataLoading = true;
    // update();
    await apiService
        .get(AppUrl.getBannersUrl, queryParameters: {"type": "dealer"})
        .then((response) {
          if (response["success"] == true) {
            dashboardDataModel = DashboardDataModel.fromJson(response['data']);
          }
          isDashboardDataLoading = false;
          update();
        })
        .catchError((value) {
          isDashboardDataLoading = false;
          update();
        });
  }
}
