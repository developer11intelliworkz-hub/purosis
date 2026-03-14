import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/feature/dealer/dashboard/controller/dashboard_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../marketing/controller/marketing_controller.dart';

class DealerMainScreen extends StatefulWidget {
  const DealerMainScreen({super.key});

  @override
  State<DealerMainScreen> createState() => _DealerMainScreenState();
}

class _DealerMainScreenState extends State<DealerMainScreen> {
  final MarketingController marketingController = Get.put(
    MarketingController(),
  );
  final DashboardController dashboardController = Get.put(
    DashboardController(),
  );
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: dashboardController,
      builder: (controller) {
        return Scaffold(
          appBar: CommonWidget.appAppBar(
            title: controller.titleList[controller.selectedIndex],
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.profileDealer);
                },
                icon: Image.asset(AppImage.profileIcon),
              ),
            ],
          ),
          body: controller.screenList[controller.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(color: Color(0xFF8EBf1F)),
            selectedItemColor: Color(0xFF8EBf1F),
            currentIndex: controller.selectedIndex,
            onTap: (value) {
              controller.selectedIndex = value;
              controller.update();
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppImage.postIcon,
                  color: controller.selectedIndex == 1
                      ? Color(0xFF8EBf1F)
                      : Colors.black,
                ),
                label: "Post",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppImage.reelIcon,
                  color: controller.selectedIndex == 2
                      ? Color(0xFF8EBf1F)
                      : Colors.black,
                ),
                label: "Reel",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppImage.videoIcon,
                  color: controller.selectedIndex == 3
                      ? Color(0xFF8EBf1F)
                      : Colors.black,
                ),
                label: "Video",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppImage.brandingIcon,
                  color: controller.selectedIndex == 4
                      ? Color(0xFF8EBf1F)
                      : Colors.black,
                ),
                label: "Branding",
              ),
            ],
          ),
        );
      },
    );
  }
}
