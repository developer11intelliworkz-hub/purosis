import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/distributor/cart/controller/cart_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/utils/common_validation.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../utils/app_toast.dart';
import '../../../../widget/app_button.dart';

class TransportView extends StatefulWidget {
  const TransportView({super.key});

  @override
  State<TransportView> createState() => _TransportViewState();
}

class _TransportViewState extends State<TransportView> {
  final CartController cartController = Get.find();

  @override
  void initState() {
    cartController.getAddressApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Transportation Information"),
      body: GetBuilder<CartController>(
        init: cartController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EasyStepper(
                  activeStep: 2,
                  lineStyle: LineStyle(
                    lineType: LineType.normal,
                    lineThickness: 2,
                    defaultLineColor: Colors.grey.shade300,
                    finishedLineColor: Colors.green,
                  ),
                  stepRadius: 14,
                  activeStepBorderColor: Color(0xFF8EBF1F),
                  activeStepIconColor: Colors.white,
                  activeStepBackgroundColor: Color(0xFF8EBF1F),
                  activeStepTextColor: Color(0xFF8EBF1F),
                  finishedStepBackgroundColor: Color(0xFF8EBF1F),
                  finishedStepIconColor: Colors.white,
                  finishedStepTextColor: Color(0xFF8EBF1F),
                  unreachedStepBorderColor: Colors.grey,
                  unreachedStepIconColor: Colors.grey,
                  unreachedStepBackgroundColor: Colors.white,
                  showLoadingAnimation: false,
                  steps: const [
                    EasyStep(icon: Icon(Icons.check), title: 'Products'),
                    EasyStep(icon: Icon(Icons.check), title: 'Dealer Info'),
                    EasyStep(icon: Icon(Icons.circle), title: 'Transport'),
                    EasyStep(
                      icon: Icon(Icons.circle_outlined),
                      title: 'Review',
                    ),
                  ],
                ),
                AppText(text: "Type", fontWeight: FontWeight.w700),
                Row(
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
                        Text(type),
                        const SizedBox(width: 12),
                      ],
                    );
                  }).toList(),
                ),
                Form(
                  key: controller.validationKey,
                  child: AppTextField(
                    labelText: "Remarks",
                    controller: controller.remarksTEC,
                    validator: CommonValidation.fieldValidation,
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: controller.isAddressLoading
                      ? CommonWidget.commonLoading()
                      : controller.addressModelList.isEmpty
                      ? CommonWidget.commonEmpty()
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          activeColor: Color(0xFF8EBF1F),
                                          value:
                                              controller
                                                  .addressModelList[index]
                                                  .id ==
                                              controller.selectedTransport,
                                          onChanged: (value) {
                                            controller.selectedTransport =
                                                controller
                                                    .addressModelList[index]
                                                    .id;
                                            controller.update();
                                          },
                                        ),
                                        AppText(
                                          text:
                                              controller
                                                      .addressModelList[index]
                                                      .isShipping ==
                                                  0
                                              ? "Billing Address"
                                              : "Shipping Address",
                                          color: Color(0xFF0067B1),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    SizedBox(height: 10),
                                    AppText(
                                      text:
                                          controller
                                              .addressModelList[index]
                                              .dealerName ??
                                          "",
                                      fontWeight: FontWeight.w700,
                                    ),
                                    AppText(
                                      text:
                                          controller
                                              .addressModelList[index]
                                              .dealerName ??
                                          "",
                                    ),
                                    AppText(
                                      text:
                                          "GST: ${controller.addressModelList[index].gstNumber ?? ""}",
                                    ),
                                    AppText(
                                      text:
                                          controller
                                              .addressModelList[index]
                                              .city ??
                                          "",
                                    ),
                                    AppText(
                                      text:
                                          controller
                                              .addressModelList[index]
                                              .state ??
                                          "",
                                    ),
                                    AppText(
                                      text:
                                          controller
                                              .addressModelList[index]
                                              .mobileNo ??
                                          "",
                                    ),
                                    AppText(
                                      text:
                                          controller
                                              .addressModelList[index]
                                              .emailAddress ??
                                          "",
                                    ),
                                    AppText(
                                      text:
                                          controller
                                              .addressModelList[index]
                                              .address ??
                                          "",
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: controller.addressModelList.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(height: 10),
                        ),
                ),
                SizedBox(height: 8),
                AppButton(
                  text: "Next",
                  isLoading: false,
                  onPressed: () {
                    if (controller.validationKey.currentState?.validate() ??
                        false) {
                      if (controller.selectedTransport != null) {
                        Get.toNamed(AppRoutes.reviewView);
                      } else {
                        AppToast.error(message: "Select Address");
                      }
                    }
                  },
                  color: Color(0xFF8EBF1F),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
