import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/widget/app_text.dart';

import '../../../../routes/app_routes.dart';
import '../../../../widget/app_image_view.dart';
import '../../../../widget/card_widget.dart';
import '../../../../widget/common_widget.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DashboardController dashboardController = Get.find();

  @override
  void initState() {
    dashboardController.getDashboardDataApi();
    dashboardController.getPostsApi();
    dashboardController.getProductApi();
    dashboardController.getReelApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: dashboardController,
      builder: (controller) {
        return controller.isDashboardDataLoading
            ? CommonWidget.commonLoading()
            : controller.dashboardDataModel == null
            ? CommonWidget.commonEmpty()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    if (controller.dashboardDataModel?.banners?.isNotEmpty ??
                        false)
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            height: 250,
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: double.maxFinite,
                                autoPlay:
                                    (controller
                                            .dashboardDataModel
                                            ?.banners
                                            ?.length ??
                                        0) >
                                    1,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration: const Duration(
                                  milliseconds: 800,
                                ),
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {},
                              ),
                              items:
                                  controller.dashboardDataModel?.banners
                                      ?.map(
                                        (e) => AppImageView(
                                          imageUrl: e.image,
                                          fit: BoxFit.fill,
                                          width: double.maxFinite,
                                        ),
                                      )
                                      .toList() ??
                                  [],
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                controller
                                        .dashboardDataModel
                                        ?.banners
                                        ?.length ??
                                    0,
                                (index) => Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  width: controller.bannerCurrentIndex == index
                                      ? 10
                                      : 8,
                                  height: controller.bannerCurrentIndex == index
                                      ? 10
                                      : 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        controller.bannerCurrentIndex == index
                                        ? Color(0xFF8EBF1F)
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Expanded(
                          child: CardWidget(
                            icon: AppImage.cartIcon,
                            count:
                                (controller
                                            .dashboardDataModel
                                            ?.totalPurchasedOrderCount ??
                                        0)
                                    .toString(),
                            bottomText: "Purchased Orders",
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: CardWidget(
                            icon: AppImage.giftIcon,
                            count:
                                (controller
                                            .dashboardDataModel
                                            ?.promoItemOrderCount ??
                                        0)
                                    .toString(),
                            bottomText: "Promo Items Orders",
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          AppText(
                            text: "Latest Marketing Content",
                            fontWeight: FontWeight.w600,
                          ),
                          Spacer(),
                          AppText(text: "View All"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 320,
                      child: controller.isPostsLoading
                          ? CommonWidget.commonLoading()
                          : controller.postsModelList.isEmpty
                          ? CommonWidget.commonEmpty()
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.postsModelList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Colors.white,
                                  child: SizedBox(
                                    width: 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: AppImageView(
                                            width: double.maxFinite,
                                            imageUrl: controller
                                                .postsModelList[index]
                                                .mediaFile,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppText(
                                                text:
                                                    controller
                                                        .postsModelList[index]
                                                        .title ??
                                                    "",
                                                fontWeight: FontWeight.w700,
                                              ),
                                              AppText(
                                                text:
                                                    "${controller.postsModelList[index].month ?? ""} ${controller.postsModelList[index].year ?? ""}",
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          AppText(
                            text: "Products",
                            fontWeight: FontWeight.w600,
                          ),
                          Spacer(),
                          AppText(text: "View All"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 320,
                      child: controller.isProductLoading
                          ? CommonWidget.commonLoading()
                          : controller.productModelList.isEmpty
                          ? CommonWidget.commonEmpty()
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.productModelList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Colors.white,
                                  child: SizedBox(
                                    width: 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: AppImageView(
                                              imageUrl:
                                                  (controller
                                                          .productModelList[index]
                                                          .productColorsImages
                                                          ?.firstOrNull
                                                          ?.images
                                                          ?.isNotEmpty ??
                                                      false)
                                                  ? controller
                                                        .productModelList[index]
                                                        .productColorsImages
                                                        ?.first
                                                        .images
                                                        ?.first
                                                  : null,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppText(
                                                text:
                                                    controller
                                                        .productModelList[index]
                                                        .productName ??
                                                    "",
                                                maxLines: 1,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              AppText(
                                                text:
                                                    controller
                                                        .productModelList[index]
                                                        .productDescription ??
                                                    "",
                                                fontWeight: FontWeight.w700,
                                                maxLines: 2,
                                                color: Colors.grey,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.toNamed(
                                                          AppRoutes
                                                              .productDetail,
                                                          arguments: controller
                                                              .productModelList[index]
                                                              .id
                                                              .toString(),
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                            0xFF8EBF1F,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                5,
                                                              ),
                                                        ),
                                                        child: AppText(
                                                          text: "View Details",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  // Container(
                                                  //   height: 40,
                                                  //   width: 40,
                                                  //   decoration: BoxDecoration(
                                                  //     borderRadius:
                                                  //         BorderRadius.circular(
                                                  //           5,
                                                  //         ),
                                                  //     color: Color(0xFF0067B1),
                                                  //   ),
                                                  //   child: Image.asset(
                                                  //     AppImage.cartIcon,
                                                  //     color: Colors.white,
                                                  //     scale: 1.5,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          AppText(text: "Reels", fontWeight: FontWeight.w600),
                          Spacer(),
                          AppText(text: "View All"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 320,
                      child: controller.isReelsLoading
                          ? CommonWidget.commonLoading()
                          : controller.reelsModelList.isEmpty
                          ? CommonWidget.commonEmpty()
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.reelsModelList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Colors.white,
                                  child: SizedBox(
                                    width: 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: AppImageView(
                                            width: double.maxFinite,
                                            imageUrl: controller
                                                .reelsModelList[index]
                                                .thumbnailImage,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppText(
                                                text:
                                                    controller
                                                        .reelsModelList[index]
                                                        .title ??
                                                    "",
                                                fontWeight: FontWeight.w700,
                                              ),
                                              AppText(
                                                text:
                                                    "${controller.reelsModelList[index].month ?? ""} ${controller.reelsModelList[index].year ?? ""}",
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
