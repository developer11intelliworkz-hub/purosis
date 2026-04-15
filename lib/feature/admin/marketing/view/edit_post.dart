import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/marketing/controller/add_content_controller.dart';
import 'package:purosis/feature/admin/marketing/model/posts_model.dart';
import 'package:purosis/utils/common_validation.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_drop_down.dart';
import 'package:purosis/widget/app_image_upload.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../utils/common_api.dart';

class EditPost extends StatefulWidget {
  const EditPost({super.key});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  PostsModel postsModel = Get.arguments;
  AddContentController addContentController = AddContentController();

  @override
  void initState() {
    addContentController.setEditPostValue(postsModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Edit Post"),
      body: GetBuilder<AddContentController>(
        init: addContentController,
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
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
                      selectedItem: controller.selectedCategory,
                      onChanged: (value) {
                        controller.selectedCategory = value;
                      },
                    ),
                    SizedBox(height: 10),
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
                      text: "Upload Content",
                      color: Color(0xFF8EBF1F),
                      isLoading: controller.isDataLoading,
                      onPressed: () {
                        if (controller.validationKey.currentState?.validate() ??
                            false) {
                          controller.editPostApi();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
