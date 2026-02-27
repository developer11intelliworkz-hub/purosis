import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:purosis/feature/admin/marketing/controller/add_content_controller.dart';
import 'package:purosis/utils/common_validation.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_drop_down.dart';
import 'package:purosis/widget/app_image_upload.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../utils/app_toast.dart';

class AddNewPost extends StatelessWidget {
  const AddNewPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Add New Post"),
      body: GetBuilder<AddContentController>(
        init: AddContentController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.validationKey,
              child: Column(
                children: [
                  AppTextField(
                    labelText: "Title",
                    controller: controller.titleTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 10),
                  AppTextField(labelText: "Category"),
                  SizedBox(height: 10),
                  AppImageUpload(
                    allowedExtensions: ["jpg", "jpeg", "png"],
                    onFileSelected: (value) {
                      controller.selectedFile = value;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: AppDropDown(
                          label: "Month",
                          showSearchBox: false,
                          items: (p0, p1) => controller.monthList,
                          compareFn: (p0, p1) => p0 == p1,
                          onChanged: (value) {
                            controller.selectedMonth = value;
                          },
                          validator: CommonValidation.dropdownValidation,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: AppDropDown(
                          label: "Year",
                          showSearchBox: false,
                          items: (p0, p1) => controller.yearList,
                          compareFn: (p0, p1) => p0 == p1,
                          onChanged: (value) {
                            controller.selectedYear = value;
                          },
                          validator: CommonValidation.dropdownValidation,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  AppTextField(
                    labelText: "Description",
                    maxLines: 3,
                    controller: controller.descriptionTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 10),
                  AppButton(
                    text: "Upload",
                    color: Color(0xFF8EBF1F),
                    onPressed: () {
                      if (controller.selectedFile == null) {
                        AppToast.error(message: "Please upload the file");
                      }
                      if ((controller.validationKey.currentState?.validate() ??
                              false) &&
                          controller.selectedFile != null) {
                        controller.addPostApi();
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
