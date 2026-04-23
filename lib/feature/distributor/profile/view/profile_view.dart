import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/distributor/dashboard/controller/dashboard_controller.dart';
import 'package:purosis/feature/distributor/profile/controller/profile_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text.dart';

import '../../../../widget/app_dialog.dart';
import '../../../../widget/app_image_view_thumb.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileController profileController = ProfileController();

  @override
  void initState() {
    profileController.setUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: profileController,
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
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
                        child: controller.userData?.logo != null
                            ? ClipOval(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: AppImageViewThumb(
                                    imageUrl: controller.userData?.logo ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : controller.userData?.companyName != null
                            ? AppText(
                                text:
                                    controller.userData?.companyName?[0] ?? "",
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
                            text: controller.userData?.companyName ?? "",
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
                              text: "Ditributor",
                              color: Color(0xFF8EBF1F),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 3),
                          AppText(text: controller.userData?.phoneNo ?? ""),
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
                      SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.editProfileView)?.then((
                                value,
                              ) {
                                if (value == true) {
                                  controller.setUserProfile();
                                }
                              });
                            },
                            child: AppText(text: "My Profile"),
                          ),
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.orderHistory);
                            },
                            child: AppText(text: "My Orders"),
                          ),
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.addressView);
                            },
                            child: AppText(text: "Saved Address"),
                          ),
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              DashboardController dashboardController =
                                  Get.find();
                              dashboardController.selectedIndex = 2;
                              dashboardController.update();
                            },
                            child: AppText(text: "Marketing Assets"),
                          ),
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.notificationScreenDistributor,
                              );
                            },
                            child: AppText(text: "Notifications"),
                          ),
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.notificationScreenDistributor,
                              );
                            },
                            child: AppText(text: "Notifications"),
                          ),
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.wishlistView);
                            },
                            child: AppText(text: "Wishlist"),
                          ),
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.helpSupportScreen);
                            },
                            child: AppText(text: "Help & Support"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppButton(
                  text: "Logout",
                  color: Color(0xFF8EBF1F),
                  onPressed: () {
                    AppDialogs.showStatusDialog(
                      onConfirm: () async {
                        await controller.logout();
                      },
                      title: "Logout",
                      message: "Are you sure you want to log out?",
                      isLoading: false.obs,
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
