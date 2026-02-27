import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:purosis/feature/admin/profile/controller/admin_profile_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/app_button.dart';
import '../../../../widget/app_text.dart';

class AdminProfileView extends StatefulWidget {
  const AdminProfileView({super.key});

  @override
  State<AdminProfileView> createState() => _AdminProfileViewState();
}

class _AdminProfileViewState extends State<AdminProfileView> {
  AdminProfileController adminProfileController = AdminProfileController();

  @override
  void initState() {
    adminProfileController.fetchProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Profile"),
      body: GetBuilder<AdminProfileController>(
        init: adminProfileController,
        builder: (controller) {
          return Column(
            children: [
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFDEF1FF),
                        ),
                        child: AppText(
                          text: controller.userModel?.name?.trim()[0] ?? "",
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: controller.userModel?.name ?? "",
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          SizedBox(height: 3),
                          Container(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 3,
                              bottom: 3,
                            ),
                            decoration: BoxDecoration(color: Color(0xFFEFF2D2)),
                            child: AppText(
                              text: "Admin",
                              color: Color(0xFF8EBF1F),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 3),
                          AppText(text: controller.userModel?.phoneNo ?? ""),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.adminProfileEdit);
                        },
                        child: AppText(text: "My Profile"),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.userManagement);
                        },
                        child: AppText(text: "User Management"),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      AppText(text: "Notifications"),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      AppText(text: "Help & Support"),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppButton(text: "Logout", color: Color(0xFF8EBF1F)),
              ),
              SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
