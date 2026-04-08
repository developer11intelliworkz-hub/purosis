import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/feature/distributor/dashboard/controller/dashboard_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/common_widget.dart';

class DistributorMainScreen extends StatefulWidget {
  const DistributorMainScreen({super.key});

  @override
  State<DistributorMainScreen> createState() => _DistributorMainScreenState();
}

class _DistributorMainScreenState extends State<DistributorMainScreen> {
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
            title: controller.screenNameList[controller.selectedIndex],
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.cartView);
                },
                icon: Image.asset(AppImage.cart3Icon, color: Colors.grey),
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  AppImage.notificationIcon,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          body: controller.distributorList[controller.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              controller.selectedIndex = value;
              controller.update();
            },
            currentIndex: controller.selectedIndex,
            selectedIconTheme: IconThemeData(color: Color(0xFF8EBf1F)),
            selectedItemColor: Color(0xFF8EBf1F),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory_2_outlined),
                label: "Products",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.spoke_outlined),
                label: "Marketing Assets",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
