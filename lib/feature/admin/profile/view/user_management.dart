import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/profile/controller/admin_profile_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_button_outline.dart';
import 'package:purosis/widget/app_search_field.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';

class UserManagement extends StatefulWidget {
  const UserManagement({super.key});

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  AdminProfileController adminProfileController = Get.find();

  @override
  void initState() {
    adminProfileController.getUserApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminProfileController>(
      init: adminProfileController,
      builder: (controller) {
        return Scaffold(
          appBar: CommonWidget.appAppBar(title: "User Management"),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AppSearchField(onChanged: controller.searchUser),
                Expanded(
                  child: controller.isUserLoading
                      ? CommonWidget.commonLoading()
                      : controller.addUserModelFilterList.isEmpty
                      ? CommonWidget.commonEmpty()
                      : RefreshIndicator(
                          onRefresh: () async => await controller.getUserApi(),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 0,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFDEF1FF),
                                            ),
                                            child: AppText(
                                              text:
                                                  controller
                                                      .addUserModelFilterList[index]
                                                      .name
                                                      ?.trim()[0] ??
                                                  "",
                                              color: Color(0xFF0067B1),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  text:
                                                      controller
                                                          .addUserModelFilterList[index]
                                                          .companyName ??
                                                      "",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                ),
                                                SizedBox(height: 5),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 3,
                                                    bottom: 3,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFEFF2D2),
                                                  ),
                                                  child: AppText(
                                                    text: "Distributor",
                                                    color: Color(0xFF8EBF1F),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Icon(Icons.call),
                                                    AppText(
                                                      text:
                                                          controller
                                                              .addUserModelFilterList[index]
                                                              .phoneNo ??
                                                          "",
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 3,
                                              horizontal: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: AppText(
                                              text: controller.getUserStatus(
                                                controller
                                                    .addUserModelFilterList[index]
                                                    .isActive,
                                              ),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: AppButton(
                                              height: 40,
                                              text: "View",
                                              color: Color(0xFF8EBF1F),
                                              onPressed: () {
                                                Get.toNamed(
                                                  AppRoutes.userDetail,
                                                  arguments: controller
                                                      .addUserModelFilterList[index],
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 3),
                                          Expanded(
                                            child: AppButtonOutline(
                                              height: 40,
                                              text: "Edit",
                                              color: Color(0xFF8EBF1F),
                                              onPressed: () {
                                                Get.toNamed(
                                                  AppRoutes.editDistributor,
                                                  arguments: controller
                                                      .addUserModelFilterList[index],
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 3),
                                          Expanded(
                                            child: AppButtonOutline(
                                              height: 40,
                                              text: controller.getUserStatus(
                                                controller
                                                            .addUserModelFilterList[index]
                                                            .isActive ==
                                                        1
                                                    ? 0
                                                    : 1,
                                              ),
                                              color: Color(0xFF888888),
                                              isLoading:
                                                  controller
                                                      .isUpdateUserStatusLoading &&
                                                  controller
                                                          .addUserModelFilterList[index]
                                                          .id ==
                                                      controller.selectedUserId,
                                              onPressed: () {
                                                controller.updateUserStatusApi(
                                                  controller
                                                      .addUserModelFilterList[index]
                                                      .id,
                                                  controller
                                                              .addUserModelFilterList[index]
                                                              .isActive ==
                                                          1
                                                      ? 0
                                                      : 1,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: controller.addUserModelFilterList.length,
                          ),
                        ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF0067B1),
            onPressed: () {
              Get.toNamed(AppRoutes.addUser)?.then((value) {
                if (value == true) {
                  controller.getUserApi();
                }
              });
            },
            child: Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }
}
