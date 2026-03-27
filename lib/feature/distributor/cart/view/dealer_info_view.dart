import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/distributor/cart/controller/cart_controller.dart';
import 'package:purosis/utils/app_toast.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../routes/app_routes.dart';

class DealerInfoView extends StatefulWidget {
  const DealerInfoView({super.key});

  @override
  State<DealerInfoView> createState() => _DealerInfoViewState();
}

class _DealerInfoViewState extends State<DealerInfoView> {
  CartController cartController = Get.find();

  @override
  void initState() {
    cartController.getAddressApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Dealer Information"),
      body: GetBuilder<CartController>(
        init: cartController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                EasyStepper(
                  activeStep: 1,
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
                    EasyStep(icon: Icon(Icons.circle), title: 'Dealer Info'),
                    EasyStep(
                      icon: Icon(Icons.circle_outlined),
                      title: 'Transport',
                    ),
                    EasyStep(
                      icon: Icon(Icons.circle_outlined),
                      title: 'Review',
                    ),
                  ],
                ),
                SizedBox(height: 10),
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
                                              controller.selectedDealerInfo,
                                          onChanged: (value) {
                                            // controller.addressModelList[index].isSelected=value;
                                            controller.selectedDealerInfo =
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
                    if (controller.selectedDealerInfo != null) {
                      Get.toNamed(AppRoutes.transportView);
                    } else {
                      AppToast.error(message: "Select Address");
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
