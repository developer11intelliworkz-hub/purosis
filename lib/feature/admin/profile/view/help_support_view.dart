import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/profile/controller/admin_profile_controller.dart';
import 'package:purosis/utils/common_validation.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

class HelpSupportView extends StatefulWidget {
  const HelpSupportView({super.key});

  @override
  State<HelpSupportView> createState() => _HelpSupportViewState();
}

class _HelpSupportViewState extends State<HelpSupportView> {
  final AdminProfileController adminProfileController = Get.find();

  @override
  void initState() {
    adminProfileController.getSupportDetailApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Help & Support"),
      body: GetBuilder<AdminProfileController>(
        init: adminProfileController,
        builder: (controller) {
          return controller.isSupportLoading
              ? CommonWidget.commonLoading()
              : controller.supportModel == null
              ? CommonWidget.commonEmpty()
              : SingleChildScrollView(
                  padding: EdgeInsets.all(8),
                  child: Form(
                    key: controller.validationKeySupport,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: "Call Details",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0067B1),
                        ),
                        SizedBox(height: 10),
                        AppTextField(
                          labelText: "MobileNumber",
                          controller: controller.mobileNumberSupportTEC,
                          validator: CommonValidation.fieldValidation,
                          inputFormatter:
                              CommonValidation.inputValidationOnlyNumber(
                                maxLength: 10,
                              ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 10),
                        AppTextField(
                          labelText: "Office Timings",
                          controller: controller.officeTimeSupportTEC,
                          validator: CommonValidation.fieldValidation,
                        ),
                        SizedBox(height: 10),
                        AppText(
                          text: "Email Details",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0067B1),
                        ),
                        SizedBox(height: 10),
                        AppTextField(
                          labelText: "Email Address",
                          controller: controller.emailAddressSupportTEC,
                          validator: CommonValidation.fieldValidation,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 10),
                        AppTextField(
                          labelText: "Notes",
                          controller: controller.notesSupportTEC,
                          validator: CommonValidation.fieldValidation,
                        ),
                        SizedBox(height: 20),
                        AppButton(
                          text: "Submit",
                          color: Color(0xFF8EBF1F),
                          isLoading: controller.isUpdateSupportLoading,
                          onPressed: () {
                            if (controller.validationKeySupport.currentState
                                    ?.validate() ??
                                false) {
                              controller.updateSupportDetailApi();
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
