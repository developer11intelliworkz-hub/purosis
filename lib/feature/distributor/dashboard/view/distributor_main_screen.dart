import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:purosis/feature/distributor/dashboard/controller/dashboard_controller.dart';

class DistributorMainScreen extends StatelessWidget {
  const DistributorMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(),
          body: controller.distributorList[controller.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
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
