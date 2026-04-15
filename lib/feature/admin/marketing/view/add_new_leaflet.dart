import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../utils/app_toast.dart';
import '../../../../utils/common_api.dart';
import '../../../../utils/common_validation.dart';
import '../../../../widget/app_button.dart';
import '../../../../widget/app_drop_down.dart';
import '../../../../widget/image_picker.dart';
import '../controller/add_content_controller.dart';

class AddNewLeaflet extends StatelessWidget {
  const AddNewLeaflet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Add New Leaflet"),
      body: GetBuilder<AddContentController>(
        init: AddContentController(),
        builder: (controller) {
          return SingleChildScrollView(
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
                  AppDropDown(
                    label: "Category",
                    items: (p0, p1) async =>
                        (await CommonApi().getDetailApi()).products ?? [],
                    compareFn: (p0, p1) => p0.productName == p1.productName,
                    itemAsString: (p0) => p0.productName,
                    onChanged: (value) {
                      controller.selectedCategory = value;
                    },
                  ),
                  SizedBox(height: 10),

                  // AppImageUpload(
                  //   allowedExtensions: ["jpg", "jpeg", "png"],
                  //   onFileSelected: (value) {
                  //     controller.selectedFile = value;
                  //   },
                  // ),
                  ImagePicker(
                    images: controller.selectedImages,
                    onAdd: controller.addImages,
                    onRemove: controller.removeImage,
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
                    text: "Upload Content",
                    color: Color(0xFF8EBF1F),
                    isLoading: controller.isDataLoading,

                    onPressed: () {
                      if ((controller.validationKey.currentState?.validate() ??
                          false)) {
                        if (controller.selectedImages.isEmpty) {
                          controller.addLeafletApi();
                        } else {
                          AppToast.error(message: "Please upload the file");
                        }
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
