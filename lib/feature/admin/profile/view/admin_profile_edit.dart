import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:purosis/feature/admin/profile/controller/admin_profile_controller.dart';
import 'package:purosis/utils/common_validation.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../consts/app_image.dart';
import '../../../../widget/app_image_view.dart';
import '../../../../widget/app_text.dart';

class AdminProfileEdit extends StatefulWidget {
  const AdminProfileEdit({super.key});

  @override
  State<AdminProfileEdit> createState() => _AdminProfileEditState();
}

class _AdminProfileEditState extends State<AdminProfileEdit> {
  AdminProfileController adminProfileController = AdminProfileController();
  @override
  void initState() {
    adminProfileController.fetchProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: 'My Profile'),
      body: GetBuilder<AdminProfileController>(
        init: adminProfileController,
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: controller.validationKey,
                child: Column(
                  children: [
                    Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: controller.selectedFile != null
                                  ? Image.file(controller.selectedFile!)
                                  : controller.userModel?.profilePhoto != null
                                  ? AppImageView(
                                      imageUrl:
                                          controller.userModel?.profilePhoto,
                                    )
                                  : Image.asset(
                                      AppImage.imageIcon,
                                      color: Colors.grey,
                                    ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.pickFile();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.upload, color: Colors.grey),
                                        AppText(
                                          text: "Upload Logo",
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    AppTextField(
                      labelText: "Admin Name",
                      controller: controller.adminNameTEC,
                      validator: CommonValidation.fieldValidation,
                    ),
                    SizedBox(height: 20),
                    AppTextField(
                      labelText: "Mobile Number",
                      controller: controller.mobileNumberTEC,
                      validator: CommonValidation.fieldValidation,
                      readOnly: true,
                    ),
                    SizedBox(height: 20),
                    AppTextField(
                      labelText: "Email Address",
                      controller: controller.emailAddressTEC,
                      validator: CommonValidation.fieldValidation,
                    ),
                    SizedBox(height: 20),
                    AppButton(
                      text: "Save Profile",
                      color: Color(0xFF8EBF1F),
                      isLoading: controller.isUpdateProfileLoading,
                      onPressed: () {
                        if (controller.validationKey.currentState?.validate() ??
                            false) {
                          controller.updateProfileApi();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
