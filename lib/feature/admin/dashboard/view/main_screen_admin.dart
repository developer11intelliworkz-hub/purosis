import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:purosis/feature/admin/dashboard/controller/dashboard_controller.dart';
import 'package:purosis/feature/admin/dashboard/view/dashboard_view.dart';
import 'package:purosis/feature/admin/product/view/product_view.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../marketing/view/marketing_content.dart';

class MainScreenAdmin extends StatelessWidget {
  const MainScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardControllerAdmin>(
      init: DashboardControllerAdmin(),
      builder: (controller) {
        return Scaffold(
          appBar: CommonWidget.appAppBar(
            title: controller.screenNameList[controller.currentIndex],
          ),
          body: controller.screenList[controller.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(color: Color(0xFF8EBf1F)),
            selectedItemColor: Color(0xFF8EBf1F),
            onTap: (value) {
              controller.currentIndex = value;
              controller.update();
            },
            currentIndex: controller.currentIndex,
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
