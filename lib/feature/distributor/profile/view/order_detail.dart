import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../consts/app_image.dart';
import '../../../../widget/app_text.dart';
import '../controller/profile_controller.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final ProfileController profileController = Get.find();
  final int? orderId = Get.arguments;

  @override
  void initState() {
    profileController.getOrderHistoryDetailApi(orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Order Detail"),
      body: GetBuilder<ProfileController>(
        init: profileController,
        builder: (controller) {
          return controller.isOrderHistoryDetailLoading
              ? CommonWidget.commonLoading()
              : controller.orderDetailModel == null
              ? CommonWidget.commonEmpty()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text:
                                    controller.orderDetailModel?.orderNumber ??
                                    "",
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Image.asset(AppImage.calenderIcon),
                                  SizedBox(width: 5),
                                  AppText(
                                    text: controller.formatDateTime(
                                      controller.orderDetailModel?.createdAt ??
                                          "",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: double.maxFinite,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE8F2D2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: AppText(
                                  text:
                                      controller
                                          .orderDetailModel
                                          ?.shippingStatus
                                          ?.capitalizeFirst ??
                                      "",
                                  color: Color(0xFF8EBF1F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      AppText(text: "Order Items", color: Color(0xFF0067B1)),
                      SizedBox(height: 10),
                      Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: AppText(
                                          text:
                                              controller
                                                  .orderDetailModel
                                                  ?.orderProducts?[index]
                                                  .product
                                                  ?.productName ??
                                              "",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Expanded(
                                        child: AppText(
                                          text:
                                              "${controller.orderDetailModel?.orderProducts?[index].totalWeight ?? ""} Kg",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: AppText(
                                          text:
                                              "Color: ${controller.orderDetailModel?.orderProducts?[index].product?.productColorsImages?.firstWhereOrNull((e) => e.colorCode == controller.orderDetailModel?.orderProducts?[index].colorCode)?.colorName ?? ""}",
                                          fontSize: 10,
                                        ),
                                      ),
                                      Expanded(
                                        child: AppText(
                                          text:
                                              controller
                                                  .orderDetailModel
                                                  ?.orderProducts?[index]
                                                  .totalCbm ??
                                              "",
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  AppText(
                                    text:
                                        "Qty. ${controller.orderDetailModel?.orderProducts?[index].product?.unitsPerBox} units | Boxes: ${controller.orderDetailModel?.orderProducts?[index].qty}",
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) => Divider(),
                            itemCount:
                                controller
                                    .orderDetailModel
                                    ?.orderProducts
                                    ?.length ??
                                0,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: AppText(
                                      text: "Total",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Expanded(
                                    child: AppText(
                                      text:
                                          "${(controller.orderDetailModel?.orderProducts?.fold(0.0, (sum, item) => sum + (double.tryParse(item.totalWeight ?? "") ?? 0.0)) ?? "0").toString()} Kg",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(flex: 4, child: SizedBox()),
                                  Expanded(
                                    child: AppText(
                                      text:
                                          "${(controller.orderDetailModel?.orderProducts?.fold(0.0, (sum, item) => sum + (double.tryParse(item.totalCbm ?? "") ?? 0.0)) ?? "0").toString()} m",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
