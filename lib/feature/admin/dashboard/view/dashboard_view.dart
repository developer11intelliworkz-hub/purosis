import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/dashboard/controller/dashboard_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:sizer/sizer.dart';

import '../../../../consts/app_image.dart';
import '../../../../widget/card_widget.dart';
import '../../../../widget/common_widget.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DashboardControllerAdmin dashboardControllerAdmin = Get.find();

  @override
  void initState() {
    dashboardControllerAdmin.getDashboardApi();
    dashboardControllerAdmin.getHistoryApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardControllerAdmin>(
      init: dashboardControllerAdmin,
      builder: (controller) {
        return controller.isDashboardLoading
            ? CommonWidget.commonLoading()
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "Manage orders, products, and content",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF888888),
                    ),
                    SizedBox(height: 1.h),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CardWidget(
                                icon: AppImage.cartIcon,
                                count:
                                    (controller
                                                .dashboardDataModel
                                                ?.pendingOrders ??
                                            0)
                                        .toString(),
                                bottomText: "Pending Orders",
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CardWidget(
                                icon: AppImage.announcementIcon,
                                count:
                                    (controller
                                                .dashboardDataModel
                                                ?.totalOrders ??
                                            0)
                                        .toString(),
                                bottomText: "Total Orders",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: CardWidget(
                                icon: AppImage.checkIcon,
                                count:
                                    (controller
                                                .dashboardDataModel
                                                ?.confirmedOrders ??
                                            0)
                                        .toString(),
                                bottomText: "Approved",
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CardWidget(
                                icon: AppImage.manIcon,
                                count:
                                    (controller
                                                .dashboardDataModel
                                                ?.totalDistributors ??
                                            0)
                                        .toString(),
                                bottomText: "Distributors",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: CardWidget(
                                icon: AppImage.productIcon,
                                count:
                                    (controller
                                                .dashboardDataModel
                                                ?.totalProducts ??
                                            0)
                                        .toString(),
                                bottomText: "Products",
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CardWidget(
                                icon: AppImage.imageIcon,
                                count:
                                    (controller
                                                .dashboardDataModel
                                                ?.marketingAssets ??
                                            0)
                                        .toString(),
                                bottomText: "Marketing",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.orderHistoryAdmin);
                          },
                          child: _menuCard(
                            AppImage.cartIcon,
                            "Manage Orders",
                            "View & approve orders",
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            controller.currentIndex = 1;
                            controller.update();
                          },
                          child: _menuCard(
                            AppImage.productIcon,
                            "Products",
                            "Add & edit products",
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            controller.currentIndex = 2;
                            controller.update();
                          },
                          child: _menuCard(
                            AppImage.imageIcon,
                            "Marketing Material",
                            "Upload Content",
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.promotionalStock);
                          },
                          child: _menuCard(
                            AppImage.giftIcon,
                            "Promotional Item",
                            "Stock Management",
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    if (controller.orderHistoryModelList.isNotEmpty)
                      Column(
                        children: [
                          Row(
                            children: [
                              AppText(
                                text: "Pending Approval",
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.orderHistoryAdmin);
                                },
                                child: Row(
                                  children: [
                                    AppText(
                                      text: "View All",
                                      color: Color(0xFF8EBF1F),
                                    ),
                                    SizedBox(width: 3),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Color(0xFF8EBF1F),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            child: controller.orderHistoryModelList.isNotEmpty
                                ? Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              AppText(
                                                text:
                                                    "#${controller.orderHistoryModelList.first.orderNumber}",
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
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: AppText(
                                                  text:
                                                      controller
                                                          .orderHistoryModelList
                                                          .first
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

                                          SizedBox(height: 5),

                                          Row(
                                            children: [
                                              Image.asset(
                                                AppImage.calenderIcon,
                                              ),
                                              SizedBox(width: 5),
                                              AppText(
                                                text:
                                                    controller
                                                        .orderHistoryModelList
                                                        .first
                                                        .orderDate ??
                                                    "",
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 5),

                                          Row(
                                            children: [
                                              Image.asset(
                                                AppImage.shippingBoxIcon,
                                              ),
                                              SizedBox(width: 5),
                                              AppText(
                                                text:
                                                    "${controller.orderHistoryModelList.first.orderProductsCount} Products",
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 5),

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
                                                    "${controller.orderHistoryModelList.first.totalWeight} kg",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        ],
                      ),
                  ],
                ),
              );
      },
    );
  }

  Widget _menuCard(String icon, String title, String subtitle) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          color: Color(0xFFDEF1FF),
          child: Image.asset(icon),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_right_alt, color: Color(0xFF8EBF1F)),
      ),
    );
  }
}
