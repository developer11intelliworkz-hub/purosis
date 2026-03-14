import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/stock/controller/add_stock_controller.dart';
import 'package:purosis/widget/app_drop_down.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../utils/common_validation.dart';
import '../../../../widget/app_button.dart';

class StockOutward extends StatelessWidget {
  const StockOutward({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Stock Outward"),
      body: GetBuilder<AddStockController>(
        init: AddStockController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.validationKey,
              child: Column(
                children: [
                  AppDropDown(
                    label: "Item",
                    items: (p0, p1) => [],
                    compareFn: (p0, p1) => p0 == p1,
                    // validator: CommonValidation.dropdownValidation,
                    onChanged: (value) {
                      controller.selectedItem = value;
                    },
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
                  AppDropDown(
                    label: "Recipient Type",
                    items: (p0, p1) => [],
                    compareFn: (p0, p1) => p0 == p1,
                    onChanged: (value) {
                      controller.selectedRecipient = value;
                    },
                    // validator: CommonValidation.dropdownValidation,
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
                    onPressed: () {
                      if (controller.validationKey.currentState?.validate() ??
                          false) {
                        controller.outwardStockApi();
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
