import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/utils/common_validation.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../controller/add_stock_controller.dart';

class StockInward extends StatelessWidget {
  const StockInward({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Stock Inward"),
      body: GetBuilder<AddStockController>(
        init: AddStockController(),
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
                        controller.inwardStockApi();
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
