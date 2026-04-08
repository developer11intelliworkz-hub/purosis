import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/feature/distributor/profile/controller/profile_controller.dart';
import 'package:purosis/utils/common_validation.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/app_image_view.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ProfileController profileController = Get.find();
  @override
  void initState() {
    profileController.getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "My Profile"),
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: controller.selectedFile != null
                              ? Image.file(controller.selectedFile!)
                              : controller.userData?.logo != null
                              ? AppImageView(
                                  imageUrl: controller.userData?.logo,
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: AppText(
                    text: "Basic Information",
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        AppTextField(
                          labelText: "Company Name",
                          controller: controller.companyNameTEC,
                          validator: CommonValidation.fieldValidation,
                        ),
                        SizedBox(height: 5),
                        AppTextField(
                          labelText: "Contact Person Name",
                          controller: controller.contactPersonNameTEC,
                          validator: CommonValidation.fieldValidation,
                        ),
                        SizedBox(height: 5),
                        AppTextField(
                          labelText: "GST Number",
                          controller: controller.gstNumberTEC,
                          validator: CommonValidation.fieldValidation,
                        ),
                        SizedBox(height: 5),
                        AppTextField(
                          labelText: "Area/Region",
                          controller: controller.areaTEC,
                          validator: CommonValidation.fieldValidation,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: AppText(
                    text: "Contact Information",
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        AppTextField(
                          labelText: "Mobile Number",
                          controller: controller.mobileNumberTEC,
                          validator: CommonValidation.fieldValidation,
                          inputFormatter:
                              CommonValidation.inputValidationOnlyNumber(
                                maxLength: 10,
                              ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 5),
                        AppTextField(
                          labelText: "Alternate Mobile Number",
                          controller: controller.alternateMobileNumberTEC,
                          validator: CommonValidation.fieldValidation,
                          inputFormatter:
                              CommonValidation.inputValidationOnlyNumber(
                                maxLength: 10,
                              ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 5),
                        AppTextField(
                          labelText: "Landline Number ",
                          controller: controller.landlineNumberTEC,
                          validator: CommonValidation.fieldValidation,
                          inputFormatter:
                              CommonValidation.inputValidationOnlyNumber(
                                maxLength: 10,
                              ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 5),
                        AppTextField(
                          labelText: "Email Address",
                          controller: controller.emailAddressTEC,
                          validator: CommonValidation.isValidEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 8.0),
                //   child: AppText(
                //     text: "Addresses",
                //     fontWeight: FontWeight.w600,
                //     color: Colors.blue,
                //   ),
                // ),
                // Card(
                //   margin: EdgeInsets.all(10),
                //   child: Padding(
                //     padding: const EdgeInsets.all(10),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         SizedBox(height: 10),
                //         AppTextField(labelText: "Billing Address"),
                //         SizedBox(height: 5),
                //         AppText(text: "Shipping Address"),
                //         SizedBox(height: 5),
                //         Row(
                //           children: [
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: typeList.map((type) {
                //                 return Row(
                //                   children: [
                //                     Radio<String>(
                //                       value: type,
                //                       groupValue: selectedType,
                //                       onChanged: (value) {},
                //                     ),
                //                     AppText(text: type),
                //                     const SizedBox(width: 10),
                //                   ],
                //                 );
                //               }).toList(),
                //             ),
                //           ],
                //         ),
                //         SizedBox(height: 5),
                //         AppTextField(labelText: "Complete Shipping Address"),
                //         SizedBox(height: 10),
                //       ],
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppButton(
                    text: "Save Profile",
                    color: Color(0xFF8EBF1F),
                    isLoading: controller.isSaveProfileLoading,
                    onPressed: () {
                      controller.updateProfileApi();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
