import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/dashboard/controller/order_history_controller.dart';
import 'package:purosis/widget/app_image_view.dart';

import '../../../../widget/app_text.dart';
import '../../../../widget/common_widget.dart';

class OrderDetailView extends StatefulWidget {
  const OrderDetailView({super.key});

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  final OrderHistoryController orderHistoryController = Get.find();
  final orderId = Get.arguments;

  @override
  void initState() {
    orderHistoryController.getOrderDetailApi(orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Order Detail"),
      body: GetBuilder(
        init: orderHistoryController,
        builder: (controller) {
          return controller.isOrderDetailLoading
              ? CommonWidget.commonLoading()
              : controller.orderDetailModel == null
              ? CommonWidget.commonEmpty()
              : Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: AppImageView(
                                              imageUrl:
                                                  controller
                                                      .orderDetailModel
                                                      ?.orderProducts?[index]
                                                      .product
                                                      ?.productColorsImages
                                                      ?.firstOrNull
                                                      ?.images
                                                      ?.firstOrNull ??
                                                  "",
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
                                                          .orderDetailModel
                                                          ?.orderProducts?[index]
                                                          .product
                                                          ?.productName ??
                                                      '',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                AppText(
                                                  text:
                                                      "Color: ${controller.orderDetailModel?.orderProducts?[index].product?.productColorsImages?.firstOrNull?.colorName?.capitalizeFirst ?? ""}",
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                SizedBox(height: 5),
                                                AppText(
                                                  text:
                                                      "QTY: ${(controller.orderDetailModel?.orderProducts?[index].qty ?? 1).toString()}",
                                                  align: TextAlign.center,
                                                ),
                                                SizedBox(height: 3),
                                                AppText(
                                                  text:
                                                      "${controller.orderDetailModel?.orderProducts?[index].product?.unitsPerBox} units in 1 Box",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount:
                              controller
                                  .orderDetailModel
                                  ?.orderProducts
                                  ?.length ??
                              0,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(height: 5),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(color: Color(0xFF8EBF1F)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              AppText(
                                text:
                                    "Total Weight: ${controller.orderDetailModel?.orderProducts?.fold(0.0, (sum, item) => double.parse((sum + (double.tryParse(item.totalWeight ?? '') ?? 0)).toString()))}KG",
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              Spacer(),
                              AppText(
                                text:
                                    "Total CBM: ${controller.orderDetailModel?.orderProducts?.fold(0.0, (sum, item) => double.parse((sum + (double.tryParse(item.totalCbm ?? '') ?? 0)).toString()))} m3",
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
