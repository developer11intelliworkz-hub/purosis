import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/product/controller/add_product_controller.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../utils/common_validation.dart';
import '../../../../widget/app_button.dart';
import '../../../../widget/app_text_field.dart';
import '../../../../widget/image_picker.dart';

class AddImageView extends StatefulWidget {
  const AddImageView({super.key});

  @override
  State<AddImageView> createState() => _AddImageViewState();
}

class _AddImageViewState extends State<AddImageView> {
  AddProductController addProductController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Product Image"),
      body: GetBuilder<AddProductController>(
        init: addProductController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                ImagePicker(
                  images: controller.selectedImages,
                  onAdd: controller.addImages,
                  onRemove: controller.removeImage,
                ),
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
                  ],
                ),
                SizedBox(height: 10),
                AppButton(
                  text: "Add",
                  color: Color(0xFF8EBF1F),
                  isLoading: controller.isAddImageLoading,
                  onPressed: () {
                    if ((controller.imageValidationKey.currentState
                                ?.validate() ??
                            false) &&
                        controller.selectedImages.isNotEmpty) {
                      controller.addImageApi();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
