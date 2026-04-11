import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/utils/common_validation.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_drop_down.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/common_api.dart';
import '../controller/profile_controller.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final ProfileController profileController = Get.find();

  @override
  void initState() {
    profileController.getSupportDetailApi();
    super.initState();
  }

  @override
  void dispose() {
    profileController.resetData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Help & Support"),
      body: GetBuilder<ProfileController>(
        init: profileController,
        builder: (controller) {
          return controller.isSupportLoading
              ? CommonWidget.commonLoading()
              : controller.supportModel == null
              ? CommonWidget.commonEmpty()
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          final Uri url = Uri(
                            scheme: 'tel',
                            path: controller.supportModel?.phoneNo ?? "",
                          );

                          launchUrl(url);
                        },
                        child: Card(
                          color: Colors.white,
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 10,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFDEF1FF),
                                    ),
                                    child: Image.asset(AppImage.callIcon),
                                  ),
                                  AppText(
                                    text: "Call Us",
                                    fontWeight: FontWeight.w700,
                                  ),
                                  AppText(
                                    text:
                                        controller.supportModel?.phoneNo ?? "",
                                  ),
                                  AppText(
                                    text:
                                        controller
                                            .supportModel
                                            ?.officeTimings ??
                                        "",
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: 'smith@example.com',
                          );

                          launchUrl(emailLaunchUri);
                        },
                        child: Card(
                          color: Colors.white,
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 10,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFDEF1FF),
                                    ),
                                    child: Image.asset(AppImage.mailIcon),
                                  ),
                                  AppText(
                                    text: "Email",
                                    fontWeight: FontWeight.w700,
                                  ),
                                  AppText(
                                    text: controller.supportModel?.email ?? "",
                                  ),
                                  AppText(
                                    text: controller.supportModel?.note ?? "",
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      AppText(
                        text: "Send us a Message",
                        color: Color(0xFF0067B1),
                      ),
                      SizedBox(height: 5),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 10,
                          ),
                          child: Form(
                            key: controller.supportValidationKey,
                            child: Column(
                              children: [
                                AppTextField(
                                  labelText: "Subject",
                                  controller: controller.subjectTEC,
                                  validator: CommonValidation.fieldValidation,
                                ),
                                SizedBox(height: 10),
                                AppDropDown(
                                  label: "Category",
                                  items: (p0, p1) async =>
                                      (await CommonApi().getDetailApi())
                                          .products ??
                                      [],
                                  compareFn: (p0, p1) =>
                                      p0.productName == p1.productName,
                                  itemAsString: (p0) => p0.productName,
                                  onChanged: (value) {
                                    controller.selectedCategory = value;
                                  },
                                ),
                                SizedBox(height: 10),
                                AppTextField(
                                  labelText: "Message",
                                  hintText:
                                      "Please describe your question or issue",
                                  controller: controller.messageTEC,
                                  maxLines: 3,
                                  validator:
                                      CommonValidation.dropdownValidation,
                                ),
                                SizedBox(height: 10),
                                AppButton(
                                  text: "Send",
                                  isLoading:
                                      controller.isSendSupportMessageLoading,
                                  color: Color(0xFF8eBF1F),
                                  onPressed: () {
                                    if (controller
                                            .supportValidationKey
                                            .currentState
                                            ?.validate() ??
                                        false) {
                                      controller.sendSupportMessageApi();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
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
