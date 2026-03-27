import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/dealer/profile/controller/profile_controller.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../consts/app_image.dart';
import '../../../../utils/common_validation.dart';
import '../../../../widget/app_button.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/app_text_field.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final ProfileController profileController = Get.find();

  @override
  void initState() {
    profileController.setEditProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Edit Profile"),
      body: GetBuilder<ProfileController>(
        init: profileController,
        builder: (controller) {
          return Padding(
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
                              SizedBox(height: 3),
                              AppText(
                                text:
                                    "Your logo will appear on marketing\nmaterials you customize",
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  AppTextField(
                    labelText: "Name",
                    controller: controller.nameTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 10),
                  AppTextField(
                    labelText: "GST Number",
                    controller: controller.gstNumberTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 10),
                  AppTextField(
                    labelText: "Phone Number",
                    controller: controller.phoneNumberTEC,
                    validator: CommonValidation.fieldValidation,
                    inputFormatter: CommonValidation.inputValidationOnlyNumber(
                      maxLength: 10,
                    ),
                    keyboardType: TextInputType.number,
                    readOnly: true,
                  ),
                  SizedBox(height: 10),
                  AppTextField(
                    labelText: "Email",
                    controller: controller.emailTEC,
                    validator: CommonValidation.isValidEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  AppButton(
                    text: "Update",
                    color: Color(0xFF8EBF1F),
                    isLoading: controller.isProfileLoading,
                    onPressed: () {
                      if (controller.validationKey.currentState?.validate() ??
                          false) {
                        controller.editProfileApi();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
