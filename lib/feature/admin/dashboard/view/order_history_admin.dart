import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/dashboard/controller/order_history_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_button_outline.dart';
import 'package:purosis/widget/app_dialog.dart';
import 'package:purosis/widget/app_drop_down.dart';
import 'package:purosis/widget/app_search_field.dart';
import 'package:purosis/widget/common_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../consts/app_image.dart';
import '../../../../model/detail_model.dart';
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
                    InkWell(
                      onTap: controller.sortOrder,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 2.h,
                            width: 2.h,
                            child: Image.asset("assets/icon/filter.png"),
                          ),
                          SizedBox(width: 2.w),
                          AppText(
                            text: "Filters",
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF666666),
                          ),
                        ],
                      ),
                    ),
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
                                            color: controller.getStatusColor(
                                              controller
                                                      .orderHistoryModelFilterList[index]
                                                      .shippingStatus ??
                                                  "",
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          child: AppText(
                                            text: controller.getStatusLabel(
                                              controller
                                                      .orderHistoryModelFilterList[index]
                                                      .shippingStatus ??
                                                  "",
                                            ),
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
                                              "Distributor : ${controller.orderHistoryModelFilterList[index].distributor?.companyName ?? ""}",
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
                                    // Row(
                                    //   children: [
                                    //     Image.asset(AppImage.truckIcon),
                                    //     SizedBox(width: 5),
                                    //     AppText(text: "Blue Dart Express"),
                                    //   ],
                                    // ),
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
                                    if (controller
                                            .orderHistoryModelFilterList[index]
                                            .shippingStatus
                                            ?.toLowerCase() ==
                                        "pending")
                                      Row(
                                        children: [
                                          Expanded(
                                            child: AppButtonOutline(
                                              height: 40,
                                              text: "View Details",
                                              color: Color(0xFF8EBF1F),
                                              onPressed: () {
                                                Get.toNamed(
                                                  AppRoutes.orderDetailView,
                                                  arguments: controller
                                                      .orderHistoryModelFilterList[index]
                                                      .id,
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 3),
                                          Expanded(
                                            child: AppButton(
                                              height: 40,
                                              text: "Approve",
                                              color: Color(0xFF8EBF1F),
                                              isLoading:
                                                  controller
                                                      .isApproveDeclineLoading &&
                                                  controller
                                                          .orderHistoryModelFilterList[index]
                                                          .id ==
                                                      controller
                                                          .selectedApproveDeclineIndex &&
                                                  controller.selectedType ==
                                                      "approved",
                                              onPressed:
                                                  controller
                                                      .isApproveDeclineLoading
                                                  ? null
                                                  : () {
                                                      controller
                                                          .approveDeclineOrderApi(
                                                            "approved",
                                                            controller
                                                                    .orderHistoryModelFilterList[index]
                                                                    .id ??
                                                                -1,
                                                          );
                                                    },
                                            ),
                                          ),
                                          SizedBox(width: 3),
                                          Expanded(
                                            child: AppButtonOutline(
                                              height: 40,
                                              text: "Decline",
                                              color: Color(0xFF8EBF1F),
                                              isLoading:
                                                  controller
                                                      .isApproveDeclineLoading &&
                                                  controller
                                                          .orderHistoryModelFilterList[index]
                                                          .id ==
                                                      controller
                                                          .selectedApproveDeclineIndex &&
                                                  controller.selectedType ==
                                                      "declined",
                                              onPressed:
                                                  controller
                                                      .isApproveDeclineLoading
                                                  ? null
                                                  : () {
                                                      controller
                                                          .approveDeclineOrderApi(
                                                            "declined",
                                                            controller
                                                                    .orderHistoryModelFilterList[index]
                                                                    .id ??
                                                                -1,
                                                          );
                                                    },
                                            ),
                                          ),
                                        ],
                                      ),
                                    SizedBox(height: 1.h),
                                    if (controller
                                            .orderHistoryModelFilterList[index]
                                            .shippingStatus
                                            ?.toLowerCase() !=
                                        "pending")
                                      SizedBox(
                                        height: 50,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: AppText(
                                                text: "Shipping Status ",
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child:
                                                  controller
                                                          .isUpdateShippingStatusLoading &&
                                                      controller
                                                              .orderHistoryModelFilterList[index]
                                                              .id ==
                                                          controller
                                                              .changeStatusIndex
                                                  ? Wrap(
                                                      alignment:
                                                          WrapAlignment.center,
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                      ],
                                                    )
                                                  : AppDropDown<CategoryItem>(
                                                      label: "Status",
                                                      showSearchBox: false,
                                                      selectedItem: controller
                                                          .filteredShippingStatusList
                                                          .firstWhereOrNull(
                                                            (e) =>
                                                                e.key ==
                                                                (controller
                                                                        .tempSelectedStatus[controller
                                                                        .orderHistoryModelFilterList[index]
                                                                        .id] ??
                                                                    controller
                                                                        .orderHistoryModelFilterList[index]
                                                                        .shippingStatus),
                                                          ),
                                                      items: (p0, p1) => controller
                                                          .filteredShippingStatusList,
                                                      compareFn: (p0, p1) =>
                                                          p0 == p1,
                                                      itemAsString: (p0) =>
                                                          p0.value ?? '',
                                                      onChanged: (value) {
                                                        if (value == null) {
                                                          return;
                                                        }

                                                        final orderId =
                                                            controller
                                                                .orderHistoryModelFilterList[index]
                                                                .id ??
                                                            -1;

                                                        final currentStatus =
                                                            controller
                                                                .orderHistoryModelFilterList[index]
                                                                .shippingStatus;

                                                        if (value.key ==
                                                            currentStatus) {
                                                          return;
                                                        }

                                                        AppDialogs.showStatusDialog(
                                                          message:
                                                              "Change status to ${value.value}?",
                                                          isLoading: controller
                                                              .isUpdateShippingStatusLoading
                                                              .obs,

                                                          onConfirm: () {
                                                            Get.back();
                                                            controller
                                                                .updateShippingStatusApi(
                                                                  value.key!,
                                                                  orderId,
                                                                );
                                                          },
                                                        );
                                                      },
                                                    ),
                                            ),
                                          ],
                                        ),
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
