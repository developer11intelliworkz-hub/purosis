import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/utils/common_validation.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_image_view.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/app_text_field.dart';

import '../controller/marketing_controller.dart';
import '../model/posts_model.dart';

class CustomizePost extends StatefulWidget {
  const CustomizePost({super.key});

  @override
  State<CustomizePost> createState() => _CustomizePostState();
}

class _CustomizePostState extends State<CustomizePost> {
  final PostsModel postsModel = Get.arguments;
  final MarketingController marketingController = Get.find();

  @override
  void initState() {
    marketingController.fetchProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<MarketingController>(
        init: marketingController,
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: Form(
              key: controller.validationKey,
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: 400,
                    child: AppImageView(imageUrl: postsModel.mediaFile),
                  ),
                  Row(
                    children: [
                      controller.userModel?.logo != null
                          ? SizedBox(
                              width: 100,
                              height: 100,
                              child: AppImageView(
                                imageUrl: controller.userModel?.logo,
                              ),
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xFF0067B1),
                                    child: Icon(
                                      Icons.image_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  AppText(text: "Logo"),
                                ],
                              ),
                            ),
                      SizedBox(width: 3),
                      Expanded(
                        child: Column(
                          children: [
                            AppTextField(
                              labelText: "Address",
                              controller: controller.addressTEC,
                              validator: CommonValidation.fieldValidation,
                            ),
                            SizedBox(height: 3),
                            AppTextField(
                              labelText: "Mail Id",
                              controller: controller.mailTEC,
                              validator: CommonValidation.isValidEmail,
                            ),
                            SizedBox(height: 3),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          labelText: "Call",
                          controller: controller.callTEC,
                          validator: CommonValidation.fieldValidation,
                          inputFormatter:
                              CommonValidation.inputValidationOnlyNumber(
                                maxLength: 10,
                              ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: AppTextField(
                          labelText: "Whats app",
                          controller: controller.whatsAppTEC,
                          validator: CommonValidation.fieldValidation,
                          inputFormatter:
                              CommonValidation.inputValidationOnlyNumber(
                                maxLength: 10,
                              ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: "Cancel",
                          isLoading: false,
                          onPressed: () {
                            Get.back();
                          },
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: AppButton(
                          text: "Preview",
                          isLoading: false,
                          onPressed: () => controller.submitToPreview(
                            postsModel.mediaFile ?? "",
                          ),
                          color: Color(0xFF8EBF1F),
                        ),
                      ),
                    ],
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
