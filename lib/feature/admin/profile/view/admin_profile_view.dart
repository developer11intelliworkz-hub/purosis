import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/profile/controller/admin_profile_controller.dart';
import 'package:purosis/routes/app_routes.dart';

import '../../../../widget/app_button.dart';
import '../../../../widget/app_image_view_thumb.dart';
import '../../../../widget/app_text.dart';

class AdminProfileView extends StatefulWidget {
  const AdminProfileView({super.key});

  @override
  State<AdminProfileView> createState() => _AdminProfileViewState();
}

class _AdminProfileViewState extends State<AdminProfileView> {
  AdminProfileController adminProfileController = Get.put(
    AdminProfileController(),
  );

  @override
  void initState() {
    adminProfileController.fetchProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        child: controller.userModel?.profilePhoto != null
                            ? ClipOval(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: AppImageViewThumb(
                                    imageUrl:
                                        controller.userModel?.profilePhoto ??
                                        "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : controller.userModel?.companyName != null
                            ? AppText(
                                text:
                                    controller.userModel?.companyName?[0] ?? "",
                                color: const Color(0xFF0067B1),
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                              )
                            : const Icon(
                                Icons.person,
                                color: Color(0xFF0067B1),
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
                          Get.toNamed(AppRoutes.adminProfileEdit)?.then((
                            value,
                          ) {
                            if (value == true) {
                              controller.fetchProfileData();
                            }
                          });
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
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.notificationScreen);
                        },
                        child: AppText(text: "Notifications"),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.bannerView);
                        },
                        child: AppText(text: "Offer Banners"),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.helpSupportView);
                        },
                        child: AppText(text: "Help & Support"),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.supportMessageView);
                        },
                        child: AppText(text: "Support Message"),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppButton(
                  text: "Logout",
                  color: Color(0xFF8EBF1F),
                  onPressed: () async {
                    await controller.logout();
                  },
                ),
              ),
              SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
