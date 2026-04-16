import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:purosis/feature/admin/dashboard/controller/dashboard_controller.dart';
import 'package:purosis/widget/common_widget.dart';
import 'package:sizer/sizer.dart';

class MainScreenAdmin extends StatelessWidget {
  const MainScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardControllerAdmin>(
      init: DashboardControllerAdmin(),
      builder: (controller) {
        return Scaffold(
          appBar: CommonWidget.appAppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: Image(image: AssetImage("assets/icon/notification.png")),
              ),
            ],
            title: controller.screenNameList[controller.currentIndex],
          ),
          body: controller.screenList[controller.currentIndex],
          bottomNavigationBar: SizedBox(
            height: 8.h,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF000000).withOpacity(0.1),
                    offset: Offset(0, -4),
                    blurRadius: 15,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                selectedFontSize: 10,
                unselectedFontSize: 10,
                unselectedLabelStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF333333),
                ),
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
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
            ),
          ),
        );
      },
    );
  }
}
