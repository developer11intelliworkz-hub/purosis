import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:purosis/feature/distributor/profile/controller/address_controller.dart';
import 'package:purosis/utils/common_validation.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/app_text.dart';

class AddNewAddress extends StatelessWidget {
  const AddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Add Address"),
      body: GetBuilder<AddressController>(
        init: AddressController(),
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.validationKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    labelText: "Dealer Name",
                    controller: controller.dealerNameTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 5),
                  AppTextField(
                    labelText: "Contact Person Name",
                    controller: controller.contactPersonNameTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 5),
                  AppTextField(
                    labelText: "GST Number",
                    controller: controller.gstNumberTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 5),
                  AppTextField(
                    labelText: "PinCode",
                    controller: controller.pinCodeTEC,
                    validator: CommonValidation.fieldValidation,
                    suffixIcon: controller.isPinCodeLoading
                        ? Padding(
                            padding: const EdgeInsets.all(12),
                            child: SizedBox(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : null,
                    inputFormatter: CommonValidation.inputValidationOnlyNumber(
                      maxLength: 6,
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && value.length == 6) {
                        controller.validatePinCodeApi(value);
                      }
                    },
                  ),
                  SizedBox(height: 5),
                  AppTextField(
                    labelText: "State",
                    readOnly: true,
                    controller: controller.stateTEC,
                  ),
                  SizedBox(height: 5),
                  AppTextField(
                    labelText: "City",
                    readOnly: true,
                    controller: controller.cityTEC,
                  ),
                  SizedBox(height: 5),
                  AppTextField(
                    labelText: "Billing Address",
                    controller: controller.billingAddressTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                  SizedBox(height: 5),
                  AppTextField(
                    labelText: "Enter Mobile Number",
                    controller: controller.mobileNumberTEC,
                    validator: CommonValidation.fieldValidation,
                    keyboardType: TextInputType.number,
                    inputFormatter: CommonValidation.inputValidationOnlyNumber(
                      maxLength: 10,
                    ),
                  ),
                  SizedBox(height: 5),
                  AppTextField(
                    labelText: "Enter Email Address",
                    controller: controller.emailAddressTEC,
                    validator: CommonValidation.isValidEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 5),
                  AppText(text: "Shipping Address"),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: controller.typeList.map((type) {
                          return Row(
                            children: [
                              Radio<String>(
                                value: type,
                                groupValue: controller.selectedType,
                                onChanged: (value) {
                                  controller.selectedType = value ?? "";
                                  controller.update();
                                },
                              ),
                              AppText(text: type),
                              const SizedBox(width: 10),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Visibility(
                    visible:
                        controller.selectedType != "Same as Billing Address",
                    child: AppTextField(
                      labelText: "Complete shipping address",
                      controller: controller.shippingAddressTEC,
                      validator: CommonValidation.fieldValidation,
                    ),
                  ),
                  SizedBox(height: 10),
                  AppButton(
                    text: "Add Address",
                    color: Color(0xFF8EBF1F),
                    isLoading: controller.isAddressAddLoading,
                    onPressed: () {
                      if (controller.validationKey.currentState?.validate() ??
                          false) {
                        controller.addAddressApi();
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
