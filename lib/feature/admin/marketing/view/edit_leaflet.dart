import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/marketing/model/leaflet_model.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../utils/app_toast.dart';
import '../../../../utils/common_api.dart';
import '../../../../utils/common_validation.dart';
import '../../../../widget/app_button.dart';
import '../../../../widget/app_drop_down.dart';
import '../../../../widget/image_picker.dart';
import '../controller/add_content_controller.dart';

class EditLeaflet extends StatefulWidget {
  const EditLeaflet({super.key});

  @override
  State<EditLeaflet> createState() => _EditLeafletState();
}

class _EditLeafletState extends State<EditLeaflet> {
  final AddContentController addContentController = AddContentController();
  LeafletModel leafletModel = Get.arguments;

  @override
  void initState() {
    addContentController.setEditLeafletValue(leafletModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Edit Leaflet"),
      body: GetBuilder<AddContentController>(
        init: addContentController,
        builder: (controller) {
          return controller.isEditLeafletLoading
              ? CommonWidget.commonLoading()
              : SingleChildScrollView(
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
                          compareFn: (p0, p1) =>
                              p0.productName == p1.productName,
                          itemAsString: (p0) => p0.productName,
                          selectedItem: controller.selectedCategory,
                          onChanged: (value) {
                            controller.selectedCategory = value;
                          },
                        ),
                        SizedBox(height: 10),
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
                                selectedItem: controller.selectedMonth,
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
                                selectedItem: controller.selectedYear,
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
                            if (controller.selectedImages.isEmpty) {
                              AppToast.error(message: "Please upload the file");
                            }
                            if ((controller.validationKey.currentState
                                        ?.validate() ??
                                    false) &&
                                controller.selectedImages.isNotEmpty) {
                              controller.addLeafletApi();
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
