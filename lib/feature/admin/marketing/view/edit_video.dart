import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/marketing/model/video_model.dart';

import '../../../../utils/common_api.dart';
import '../../../../utils/common_validation.dart';
import '../../../../widget/app_button.dart';
import '../../../../widget/app_drop_down.dart';
import '../../../../widget/app_image_upload.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/app_text_field.dart';
import '../../../../widget/common_widget.dart';
import '../controller/add_content_controller.dart';

class EditVideo extends StatefulWidget {
  const EditVideo({super.key});

  @override
  State<EditVideo> createState() => _EditVideoState();
}

class _EditVideoState extends State<EditVideo> {
  VideoModel videoModel = Get.arguments;
  AddContentController addContentController = AddContentController();
  @override
  void initState() {
    addContentController.setEditVideoValue(videoModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Edit Video"),
      body: GetBuilder<AddContentController>(
        init: addContentController,
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
                    selectedItem: controller.selectedCategory,
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
                    selectedItem: controller.selectedType,
                    onChanged: (value) {
                      controller.selectedType = value;
                    },
                  ),
                  SizedBox(height: 10),
                  AppText(text: "Media File"),
                  SizedBox(height: 5),
                  AppImageUpload(
                    title: controller.selectedMediaFileName ?? "",
                    allowedExtensions: ["mp4", "mov", "avi"],
                    onFileSelected: (value) {
                      controller.selectedMediaFile = value;
                    },
                  ),
                  SizedBox(height: 10),
                  AppText(text: "Thumbnail Image"),
                  SizedBox(height: 5),
                  AppImageUpload(
                    title: controller.selectedFileName ?? "",
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
                          selectedItem: controller.selectedMonth,
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
                          selectedItem: controller.selectedYear,
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
                      if (controller.validationKey.currentState?.validate() ??
                          false) {
                        controller.editVideoApi();
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
