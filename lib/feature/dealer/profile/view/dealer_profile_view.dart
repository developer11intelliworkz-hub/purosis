import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:purosis/feature/dealer/profile/controller/profile_controller.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';

class DealerProfileView extends StatefulWidget {
  const DealerProfileView({super.key});

  @override
  State<DealerProfileView> createState() => _DealerProfileViewState();
}

class _DealerProfileViewState extends State<DealerProfileView> {
  final ProfileController profileController = ProfileController();

  @override
  void initState() {
    profileController.fetchProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Profile"),
      body: GetBuilder<ProfileController>(
        init: profileController,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                color: Color(0xFF0067B1),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: controller.userModel?.name != null
                          ? AppText(
                              text: controller.userModel?.name?[0] ?? "",
                              color: Color(0xFF0067B1),
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            )
                          : Icon(Icons.person, color: Color(0xFF0067B1)),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text:
                              controller.userModel?.name ??
                              controller.userModel?.phoneNo ??
                              "",
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        AppText(
                          text: "Guest",
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Dashboard",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      SizedBox(height: 15),
                      Divider(),
                      SizedBox(height: 15),
                      AppText(
                        text: "Brochure",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      SizedBox(height: 15),
                      Divider(),
                      SizedBox(height: 15),
                      AppText(
                        text: "Video",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      SizedBox(height: 15),
                      Divider(),
                      SizedBox(height: 15),
                      AppText(
                        text: "Reel",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      SizedBox(height: 15),
                      Divider(),
                      SizedBox(height: 15),
                      AppText(
                        text: "Leaflet",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      SizedBox(height: 15),
                      Divider(),
                      SizedBox(height: 15),
                      AppText(
                        text: "Profile",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      SizedBox(height: 15),
                      Divider(),
                      Spacer(),
                      AppButton(
                        text: "Logout",
                        color: Color(0xFF8EBF1F),
                        onPressed: () {
                          controller.logout();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
