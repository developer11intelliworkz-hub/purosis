import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/dealer/dashboard/view/dealer_dashboard_view.dart';
import 'package:purosis/feature/dealer/marketing/view/posts_view_dealer.dart';
import 'package:purosis/feature/dealer/marketing/view/reels_view_dealer.dart';
import 'package:purosis/feature/dealer/marketing/view/video_view_dealer.dart';

import '../../marketing/view/branding_view_dealer.dart';

class DashboardController extends GetxController {
  List<Widget> screenList = [
    DealerDashboardView(),
    PostsViewDealer(isAppBarShow: false),
    ReelsViewDealer(isAppBarShow: false),
    VideoViewDealer(isAppBarShow: false),
    BrandingViewDealer(),
  ];

  List<String> titleList = ["Dashboard", "Post", "Reel", "Video", "Branding"];

  int selectedIndex = 0;
}
