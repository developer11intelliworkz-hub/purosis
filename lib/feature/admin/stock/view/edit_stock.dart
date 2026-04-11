import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/stock/model/item_model.dart';
import 'package:purosis/utils/common_validation.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../controller/add_stock_controller.dart';

class EditStock extends StatefulWidget {
  const EditStock({super.key});

  @override
  State<EditStock> createState() => _EditStockState();
}

class _EditStockState extends State<EditStock> {
  final AddStockController addStockController = AddStockController();
  final ItemModel itemModel = Get.arguments;

  @override
  void initState() {
    addStockController.setEditStock(itemModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Stock Inward"),
      body: GetBuilder<AddStockController>(
        init: addStockController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.validationKey,
              child: Column(
                children: [
                  AppTextField(
                    labelText: "Item",
                    controller: controller.itemTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 10),
                  AppTextField(
                    labelText: "Quantity",
                    controller: controller.quantityTEC,
                    validator: CommonValidation.fieldValidation,
                    inputFormatter:
                        CommonValidation.inputValidationOnlyNumber(),
                  ),
                  SizedBox(height: 10),
                  AppTextField(
                    labelText: "Notes",
                    maxLines: 4,
                    controller: controller.notesTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 10),
                  AppButton(
                    text: "Submit",
                    color: Color(0xFF8EBF1F),
                    isLoading: controller.isDataLoading,
                    onPressed: () {
                      if (controller.validationKey.currentState?.validate() ??
                          false) {
                        controller.updateStockApi();
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
