import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/feature/distributor/profile/controller/profile_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_search_field.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/card_widget.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final ProfileController profileController = Get.find();

  @override
  void initState() {
    profileController.getOrderHistoryApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Order History"),
      body: GetBuilder<ProfileController>(
        init: profileController,
        builder: (controller) {
          return controller.isOrderHistoryLoading
              ? CommonWidget.commonLoading()
              : controller.orderHistoryModelFilter == null
              ? CommonWidget.commonEmpty()
              : NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CardWidget(
                                      icon: AppImage.cartIcon,
                                      count:
                                          (controller
                                                      .orderHistoryModelFilter
                                                      ?.summary
                                                      ?.totalOrders ??
                                                  0)
                                              .toString(),
                                      bottomText: 'Total Order',
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: CardWidget(
                                      icon: AppImage.cartIcon,
                                      count:
                                          (controller
                                                      .orderHistoryModelFilter
                                                      ?.summary
                                                      ?.pending ??
                                                  0)
                                              .toString(),
                                      bottomText: 'Pending',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CardWidget(
                                      icon: AppImage.cartIcon,
                                      count:
                                          (controller
                                                      .orderHistoryModelFilter
                                                      ?.summary
                                                      ?.confirm ??
                                                  0)
                                              .toString(),
                                      bottomText: 'In Progress',
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: CardWidget(
                                      icon: AppImage.cartIcon,
                                      count:
                                          (controller
                                                      .orderHistoryModelFilter
                                                      ?.summary
                                                      ?.failed ??
                                                  0)
                                              .toString(),
                                      bottomText: 'Completed',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _SearchBarDelegate(
                          isAscending: controller.isLatest,
                          onSortTap: controller.sortOrder,
                          onChanged: controller.search,
                        ),
                      ),
                    ];
                  },
                  body:
                      (controller.orderHistoryModelFilter?.orders?.isEmpty ??
                          true)
                      ? CommonWidget.commonEmpty()
                      : ListView.builder(
                          padding: EdgeInsets.all(8),
                          itemCount:
                              controller
                                  .orderHistoryModelFilter
                                  ?.orders
                                  ?.length ??
                              0,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: AppText(
                                            text:
                                                "#${controller.orderHistoryModelFilter?.orders?[index].orderNumber ?? ""}",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            color: Color(0xFFE8F2D2),
                                          ),
                                          child: AppText(
                                            text:
                                                controller
                                                    .orderHistoryModelFilter
                                                    ?.orders?[index]
                                                    .shippingStatus ??
                                                "",
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),

                                    Row(
                                      children: [
                                        Image.asset(AppImage.calenderIcon),
                                        SizedBox(width: 5),
                                        AppText(
                                          text:
                                              controller
                                                  .orderHistoryModelFilter
                                                  ?.orders?[index]
                                                  .orderDate ??
                                              "",
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 5),

                                    Row(
                                      children: [
                                        Image.asset(AppImage.shippingBoxIcon),
                                        SizedBox(width: 5),
                                        AppText(
                                          text:
                                              "${controller.orderHistoryModelFilter?.orders?[index].orderProductsCount ?? ""} Products",
                                        ),
                                      ],
                                    ),

                                    // SizedBox(height: 5),

                                    // Row(
                                    //   children: [
                                    //     Image.asset(AppImage.truckIcon),
                                    //     SizedBox(width: 5),
                                    //     AppText(text: "Blue Dart Express"),
                                    //   ],
                                    // ),
                                    SizedBox(height: 10),

                                    Row(
                                      children: [
                                        AppText(text: "Total Weight: "),
                                        AppText(
                                          text:
                                              "${controller.orderHistoryModelFilter?.orders?[index].totalWeight ?? ""} Kg ",
                                          fontWeight: FontWeight.w700,
                                        ),
                                        // AppText(text: "0.800 m", fontWeight: FontWeight.w400),
                                      ],
                                    ),

                                    SizedBox(height: 10),

                                    AppButton(
                                      text: "View Details",
                                      color: Color(0xFF8EBF1F),
                                      onPressed: () {
                                        Get.toNamed(
                                          AppRoutes.orderDetail,
                                          arguments: controller
                                              .orderHistoryModelFilter
                                              ?.orders?[index]
                                              .id,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                );
        },
      ),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final bool isAscending;
  final VoidCallback onSortTap;
  final ValueChanged<String>? onChanged;

  _SearchBarDelegate({
    required this.isAscending,
    required this.onSortTap,
    this.onChanged,
  });

  @override
  double get minExtent => 70;

  @override
  double get maxExtent => 70;

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: AppSearchField(onChanged: onChanged)),
          const SizedBox(width: 5),

          GestureDetector(
            onTap: onSortTap,
            child: Image.asset(
              isAscending ? AppImage.shortArrowIcon : AppImage.shortArrow2Icon,
            ),
          ),

          const SizedBox(width: 5),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SearchBarDelegate oldDelegate) {
    return oldDelegate.isAscending != isAscending;
  }
}
