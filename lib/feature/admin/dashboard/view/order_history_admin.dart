import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/dashboard/controller/order_history_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_search_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../consts/app_image.dart';
import '../../../../widget/app_text.dart';

class OrderHistoryAdmin extends StatefulWidget {
  const OrderHistoryAdmin({super.key});

  @override
  State<OrderHistoryAdmin> createState() => _OrderHistoryAdminState();
}

class _OrderHistoryAdminState extends State<OrderHistoryAdmin> {
  OrderHistoryController orderHistoryController = OrderHistoryController();

  @override
  void initState() {
    orderHistoryController.getHistoryApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Order History"),
      body: GetBuilder<OrderHistoryController>(
        init: orderHistoryController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppSearchField(onChanged: controller.search),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: controller.sortOrder,
                      child: Image.asset(
                        controller.isLatest
                            ? AppImage.shortArrowIcon
                            : AppImage.imageIcon,
                      ),
                    ),
                    SizedBox(width: 5),
                  ],
                ),
                SizedBox(height: 5),
                Expanded(
                  child: controller.isOrderHistoryLoading
                      ? CommonWidget.commonLoading()
                      : controller.orderHistoryModelFilterList.isEmpty
                      ? CommonWidget.commonEmpty()
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        AppText(
                                          text:
                                              "#${controller.orderHistoryModelFilterList[index].orderNumber}",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 2,
                                            horizontal: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF2EBD2),
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          child: AppText(
                                            text:
                                                controller
                                                    .orderHistoryModelFilterList[index]
                                                    .shippingStatus ??
                                                "",
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(AppImage.manIcon),
                                        SizedBox(width: 5),
                                        AppText(
                                          text:
                                              "Distributor : Mumbai Water Solutions",
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 3),
                                    Row(
                                      children: [
                                        Image.asset(AppImage.calenderIcon),
                                        SizedBox(width: 5),
                                        AppText(
                                          text:
                                              controller
                                                  .orderHistoryModelFilterList[index]
                                                  .orderDate ??
                                              "",
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 3),
                                    Row(
                                      children: [
                                        Image.asset(AppImage.shippingBoxIcon),
                                        SizedBox(width: 5),
                                        AppText(
                                          text:
                                              "${controller.orderHistoryModelFilterList[index].orderProductsCount} Products",
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 3),
                                    Row(
                                      children: [
                                        Image.asset(AppImage.truckIcon),
                                        SizedBox(width: 5),
                                        AppText(text: "Blue Dart Express"),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        AppText(text: "Total Weight: "),
                                        AppText(
                                          text:
                                              "${controller.orderHistoryModelFilterList[index].totalWeight} kg",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                AppRoutes.orderDetailView,
                                                arguments: controller
                                                    .orderHistoryModelFilterList[index]
                                                    .id,
                                              );
                                            },
                                            child: Container(
                                              height: 40,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: Color(0xFF8EBF1F),
                                                ),
                                              ),
                                              child: AppText(
                                                text: "View Details",
                                                color: Color(0xFF8EBF1F),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 3),
                                        Expanded(
                                          child: Container(
                                            height: 40,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Color(0xFF8EBF1F),
                                            ),
                                            child: AppText(
                                              text: "Approve",
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 3),
                                        Expanded(
                                          child: Container(
                                            height: 40,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: Color(0xFFBF1F1F),
                                              ),
                                            ),
                                            child: AppText(
                                              text: "Decline",
                                              color: Color(0xFFBF1F1F),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount:
                              controller.orderHistoryModelFilterList.length,
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
