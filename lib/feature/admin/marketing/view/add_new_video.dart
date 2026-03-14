import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../utils/app_toast.dart';
import '../../../../utils/common_api.dart';
import '../../../../utils/common_validation.dart';
import '../../../../widget/app_button.dart';
import '../../../../widget/app_drop_down.dart';
import '../../../../widget/app_image_upload.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/app_text_field.dart';
import '../../../../widget/common_widget.dart';
import '../controller/add_content_controller.dart';

class AddNewVideo extends StatelessWidget {
  const AddNewVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Add Video"),
      body: GetBuilder<AddContentController>(
        init: AddContentController(),
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.validationKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    labelText: "Title",
                    controller: controller.titleTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 10),
                  AppDropDown(
                    label: "Category",
                    items: (p0, p1) async =>
                        (await CommonApi().getDetailApi()).videoCategory ?? [],
                    compareFn: (p0, p1) => p0.value == p1.value,
                    itemAsString: (p0) => p0.value,
                    onChanged: (value) {
                      controller.selectedCategory = value;
                    },
                  ),
                  SizedBox(height: 10),
                  AppDropDown(
                    label: "Type",
                    items: (p0, p1) async =>
                        (await CommonApi().getDetailApi()).videoType ?? [],
                    compareFn: (p0, p1) => p0.value == p1.value,
                    itemAsString: (p0) => p0.value,
                    onChanged: (value) {
                      controller.selectedType = value;
                    },
                  ),
                  SizedBox(height: 10),
                  AppText(text: "Media File"),
                  SizedBox(height: 5),
                  AppImageUpload(
                    allowedExtensions: ["mp4", "mov", "avi"],
                    onFileSelected: (value) {
                      controller.selectedMediaFile = value;
                    },
                  ),
                  SizedBox(height: 10),
                  AppText(text: "Thumbnail Image"),
                  SizedBox(height: 5),
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
                    isLoading: controller.isDataLoading,
                    onPressed: () {
                      if (controller.selectedFile == null) {
                        AppToast.error(message: "Please upload the file");
                      }
                      if ((controller.validationKey.currentState?.validate() ??
                              false) &&
                          controller.selectedFile != null) {
                        controller.addVideoApi();
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
