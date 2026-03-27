import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:purosis/feature/admin/product/controller/add_product_controller.dart';
import 'package:purosis/utils/common_validation.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_drop_down.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Add New Product"),
      body: GetBuilder<AddProductController>(
        init: AddProductController(),
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.allFieldValidationKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    labelText: "Product Name",
                    controller: controller.productNameTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 10),
                  AppDropDown(
                    label: 'Category',
                    items: (data, value) => controller.productCategoriesApi(),
                    compareFn: (p0, p1) => p0.categoryName == p1.categoryName,
                    itemAsString: (p0) => p0.categoryName ?? "",
                    onChanged: (value) {
                      controller.selectedProductCategories = value;
                    },
                    validator: CommonValidation.dropdownValidation,
                  ),
                  SizedBox(height: 10),
                  AppDropDown(
                    label: 'Sub Category',
                    items: (data, value) =>
                        controller.productSubCategoriesApi(),
                    compareFn: (p0, p1) =>
                        p0.subCategoryName == p1.subCategoryName,
                    itemAsString: (p0) => p0.subCategoryName ?? "",
                    onChanged: (value) {
                      controller.selectedSubCategoryModel = value;
                    },
                    validator: CommonValidation.dropdownValidation,
                  ),
                  SizedBox(height: 10),
                  AppText(text: "Specification"),
                  if (controller.listOfSpecification.isNotEmpty)
                    SizedBox(height: 10),
                  Column(
                    children: controller.listOfSpecification
                        .map(
                          (e) => Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Expanded(child: AppText(text: e)),
                                IconButton(
                                  onPressed: () {
                                    controller.listOfSpecification.remove(e);
                                    controller.update();
                                  },
                                  icon: Icon(Icons.close),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 10),
                  specificationField(
                    controller: TextEditingController(),
                    onPressed: (String value) {
                      if (value.isNotEmpty) {
                        controller.listOfSpecification.add(value);
                        controller.update();
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  AppTextField(
                    labelText: "Description",
                    controller: controller.descriptionTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 10),
                  AppText(
                    text: "Product Image",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 5),
                  Column(
                    children: controller.imageModelList
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  AppText(text: e.colorName ?? ""),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      controller.imageModelList.remove(e);
                                      controller.update();
                                    },
                                    icon: Icon(Icons.close),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 5),
                  ImagePicker(
                    images: controller.selectedImages,
                    onAdd: controller.addImages,
                    onRemove: controller.removeImage,
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text("Pick a color"),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: controller.selectedColor,
                                  onColorChanged: (color) {
                                    controller.selectedColor = color;
                                    controller.update();
                                  },
                                  showLabel: true,
                                  pickerAreaHeightPercent: 0.8,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Done"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: controller.selectedColor),
                          ),
                          padding: EdgeInsets.all(3),
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.selectedColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        flex: 4,
                        child: Form(
                          key: controller.imageValidationKey,
                          child: AppTextField(
                            labelText: "Color Name",
                            controller: controller.colorNameTEC,
                            validator: CommonValidation.fieldValidation,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: AppButton(
                          text: "Add",
                          color: Color(0xFF8EBF1F),
                          onPressed: () {
                            if ((controller.imageValidationKey.currentState
                                        ?.validate() ??
                                    false) &&
                                controller.selectedImages.isNotEmpty) {
                              controller.addImageToList();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          labelText: "Unit per Box",
                          controller: controller.unitPerBoxTEC,
                          validator: CommonValidation.fieldValidation,
                          keyboardType: TextInputType.number,
                          inputFormatter:
                              CommonValidation.inputValidationOnlyNumber(
                                maxLength: 4,
                              ),
                        ),
                      ),
                      SizedBox(width: 3),
                      Expanded(
                        child: AppTextField(
                          labelText: "Weight per Box (kg)",
                          controller: controller.weightPerBoxTEC,
                          validator: CommonValidation.fieldValidation,
                          keyboardType: TextInputType.number,
                          inputFormatter:
                              CommonValidation.inputValidationOnlyNumber(
                                maxLength: 6,
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  AppText(
                    text: "Dimensions (cm) - for CBM calculation",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          labelText: "Length",
                          controller: controller.lengthTEC,
                          validator: CommonValidation.fieldValidation,
                          keyboardType: TextInputType.number,
                          inputFormatter:
                              CommonValidation.inputValidationOnlyNumber(
                                maxLength: 4,
                              ),
                        ),
                      ),
                      SizedBox(width: 3),
                      Expanded(
                        child: AppTextField(
                          labelText: "Width",
                          controller: controller.widthTEC,
                          validator: CommonValidation.fieldValidation,
                          keyboardType: TextInputType.number,
                          inputFormatter:
                              CommonValidation.inputValidationOnlyNumber(
                                maxLength: 4,
                              ),
                        ),
                      ),
                      SizedBox(width: 3),
                      Expanded(
                        child: AppTextField(
                          labelText: "Height",
                          controller: controller.heightTEC,
                          validator: CommonValidation.fieldValidation,
                          keyboardType: TextInputType.number,
                          inputFormatter:
                              CommonValidation.inputValidationOnlyNumber(
                                maxLength: 4,
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  AppTextField(
                    labelText: "Technical Video URL",
                    controller: controller.technicalVideoUrlTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 10),
                  AppButton(
                    text: "Add Product",
                    color: Color(0xFF8EBF1F),
                    onPressed: () {
                      if (controller.imageModelList.isEmpty) {
                        if ((controller.imageValidationKey.currentState
                                    ?.validate() ??
                                false) &&
                            controller.selectedImages.isNotEmpty) {
                          controller.addImageToList();
                          if ((controller.allFieldValidationKey.currentState
                                  ?.validate() ??
                              false)) {
                            controller.addProductApi();
                          }
                        }
                      }
                    },
                    isLoading: controller.isAddProductLoading,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget specificationField({
    required TextEditingController controller,
    required Function(String value) onPressed,
  }) {
    GlobalKey<FormState> validationKey = GlobalKey();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Form(
            key: validationKey,
            child: AppTextField(
              controller: controller,
              validator: CommonValidation.fieldValidation,
            ),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: AppButton(
            text: "Add",
            color: Color(0xFF8EBF1F),
            onPressed: () {
              if (validationKey.currentState?.validate() ?? false) {
                onPressed(controller.text);
                controller.clear();
              }
            },
          ),
        ),
      ],
    );
  }
}
