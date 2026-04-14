import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/dealer/dashboard/view/dealer_dashboard_view.dart';
import 'package:purosis/feature/dealer/marketing/view/posts_view_dealer.dart';
import 'package:purosis/feature/dealer/marketing/view/reels_view_dealer.dart';
import 'package:purosis/feature/dealer/marketing/view/video_view_dealer.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../../marketing/view/branding_view_dealer.dart';
import '../model/dashboard_data_model.dart';

class DashboardController extends GetxController {
  final ApiService apiService = ApiService();
  List<Widget> screenList = [
    DealerDashboardView(),
    PostsViewDealer(isAppBarShow: false),
    ReelsViewDealer(isAppBarShow: false),
    VideoViewDealer(isAppBarShow: false),
    BrandingViewDealer(),
  ];

  List<String> titleList = ["Dashboard", "Post", "Reel", "Video", "Branding"];

  DashboardDataModel? dashboardDataModel;
  int bannerCurrentIndex = 0;
  bool isDashboardDataLoading = false;
  int selectedIndex = 0;

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
