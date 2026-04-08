import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/distributor/cart/controller/cart_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_image_view.dart';
import 'package:purosis/widget/app_text.dart';

import '../../../../widget/common_widget.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartController cartController = Get.put(CartController());

  @override
  void initState() {
    cartController.getCartApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Shopping Cart"),
      body: GetBuilder<CartController>(
        init: cartController,
        builder: (controller) {
          return controller.isCartLoading
              ? CommonWidget.commonLoading()
              : controller.cartModelList.isEmpty
              ? CommonWidget.commonEmpty()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      EasyStepper(
                        activeStep: 0,
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
                          EasyStep(icon: Icon(Icons.circle), title: 'Products'),
                          EasyStep(
                            icon: Icon(Icons.circle_outlined),
                            title: 'Dealer Info',
                          ),
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
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final addedProduct = controller
                                .cartModelList[index]
                                .product
                                ?.productColorsImages
                                ?.firstWhereOrNull(
                                  (e) =>
                                      e.colorCode ==
                                      controller.cartModelList[index].colorCode,
                                );
                            return Card(
                              color: Colors.white,
                              child: SizedBox(
                                height: 150,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                width: 100,
                                                height: 100,
                                                child: AppImageView(
                                                  imageUrl:
                                                      addedProduct
                                                          ?.images
                                                          ?.firstOrNull ??
                                                      "",
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AppText(
                                                    text:
                                                        controller
                                                            .cartModelList[index]
                                                            .product
                                                            ?.productName ??
                                                        "",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  AppText(
                                                    text:
                                                        "Color: ${addedProduct?.colorName ?? ""}",
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Container(
                                                    height: 50,
                                                    width: 170,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap:
                                                              controller
                                                                  .isUpdateCartLoading
                                                              ? null
                                                              : () {
                                                                  final data =
                                                                      cartController
                                                                          .cartModelList[index];
                                                                  data.qty =
                                                                      (data.qty ??
                                                                          0) -
                                                                      1;
                                                                  controller
                                                                      .updateCartApi(
                                                                        data,
                                                                        index,
                                                                      );
                                                                },
                                                          child: Container(
                                                            height: 50,
                                                            width: 50,
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                          8,
                                                                        ),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                          8,
                                                                        ),
                                                                  ),
                                                              color: Color(
                                                                0xFFCAE6FB,
                                                              ),
                                                            ),
                                                            child: Icon(
                                                              Icons.remove,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child:
                                                              controller
                                                                      .isUpdateCartLoading &&
                                                                  controller
                                                                          .updateCartIndex ==
                                                                      index
                                                              ? Wrap(
                                                                  alignment:
                                                                      WrapAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                      width: 20,
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                                  ],
                                                                )
                                                              : AppText(
                                                                  text:
                                                                      (controller.cartModelList[index].qty ??
                                                                              1)
                                                                          .toString(),
                                                                  align: TextAlign
                                                                      .center,
                                                                ),
                                                        ),
                                                        GestureDetector(
                                                          onTap:
                                                              controller
                                                                  .isUpdateCartLoading
                                                              ? null
                                                              : () {
                                                                  final data =
                                                                      cartController
                                                                          .cartModelList[index];
                                                                  data.qty =
                                                                      (data.qty ??
                                                                          0) +
                                                                      1;
                                                                  controller.updateCartApi(
                                                                    cartController
                                                                        .cartModelList[index],
                                                                    index,
                                                                  );
                                                                },
                                                          child: Container(
                                                            height: 50,
                                                            width: 50,
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.only(
                                                                    topRight:
                                                                        Radius.circular(
                                                                          8,
                                                                        ),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                          8,
                                                                        ),
                                                                  ),
                                                              color: Color(
                                                                0xFFCAE6FB,
                                                              ),
                                                            ),
                                                            child: Icon(
                                                              Icons.add,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 3),
                                                  AppText(
                                                    text:
                                                        "${controller.cartModelList[index].unitsPerBox} units in 1 Box",
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: controller.isDeleteCartLoading
                                          ? null
                                          : () {
                                              controller.deleteCartApi(
                                                controller
                                                    .cartModelList[index]
                                                    .id,
                                                index,
                                              );
                                            },
                                      icon:
                                          controller.isDeleteCartLoading &&
                                              controller.deleteCartIndex ==
                                                  index
                                          ? SizedBox(
                                              height: 20,
                                              width: 20,
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : Icon(Icons.close),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: controller.cartModelList.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(height: 5),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              AppText(
                                text:
                                    "Total Weight: ${controller.cartModelList.fold(0.0, (sum, item) => double.parse((sum + (double.tryParse(item.totalWeight ?? '') ?? 0)).toString()))}KG",
                              ),
                              Spacer(),
                              AppText(
                                text:
                                    "Total CBM: ${controller.cartModelList.fold(0.0, (sum, item) => double.parse((sum + (double.tryParse(item.totalCbm ?? '') ?? 0)).toString()))} m3",
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          AppButton(
                            text: "Next",
                            isLoading: false,
                            onPressed: () {
                              Get.toNamed(AppRoutes.dealerInfoView);
                            },
                            color: Color(0xFF8EBF1F),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
