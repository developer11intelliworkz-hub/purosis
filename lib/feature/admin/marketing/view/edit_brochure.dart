import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_toast.dart';
import '../../../../utils/common_validation.dart';
import '../../../../widget/app_button.dart';
import '../../../../widget/app_drop_down.dart';
import '../../../../widget/app_image_upload.dart';
import '../../../../widget/app_text_field.dart';
import '../../../../widget/common_widget.dart';
import '../controller/add_content_controller.dart';
import '../model/brochures_model.dart';

class EditBrochure extends StatefulWidget {
  const EditBrochure({super.key});

  @override
  State<EditBrochure> createState() => _EditBrochureState();
}

class _EditBrochureState extends State<EditBrochure> {
  BrochuresModel brochuresModel = Get.arguments;
  AddContentController addContentController = AddContentController();

  @override
  void initState() {
    addContentController.setEditBrochureValue(brochuresModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Edit Brochure"),
      body: GetBuilder<AddContentController>(
        init: addContentController,
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
                          selectedItem: controller.selectedMonth,
                          items: (p0, p1) => controller.monthList,
                          onChanged: (value) {
                            controller.selectedMonth = value;
                          },
                          compareFn: (p0, p1) => p0 == p1,
                          validator: CommonValidation.dropdownValidation,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: AppDropDown(
                          label: "Year",
                          items: (p0, p1) => controller.yearList,
                          selectedItem: controller.selectedYear,
                          showSearchBox: false,
                          onChanged: (value) {
                            controller.selectedYear = value;
                          },
                          compareFn: (p0, p1) => p0 == p1,
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
                        controller.addBrochureApi();
                      }
                    },
                    isLoading: controller.isAddBrochuresLoading,
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
