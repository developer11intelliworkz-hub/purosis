import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/dealer/dashboard/controller/dashboard_controller.dart';
import 'package:purosis/feature/dealer/marketing/controller/marketing_controller.dart';
import 'package:purosis/feature/dealer/marketing/view/widget/view_all_widget.dart';

import '../../../../widget/app_image_view.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/common_widget.dart';

class DealerDashboardView extends StatefulWidget {
  const DealerDashboardView({super.key});

  @override
  State<DealerDashboardView> createState() => _DealerDashboardViewState();
}

class _DealerDashboardViewState extends State<DealerDashboardView> {
  final MarketingController marketingController = Get.find();
  final DashboardController dashboardController = Get.find();

  @override
  void initState() {
    dashboardController.getDashboardDataApi();
    marketingController.getPostsApi();
    marketingController.getReelApi();
    marketingController.getVideoApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarketingController>(
      init: marketingController,
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              // Stack(
              //   alignment: Alignment.bottomCenter,
              //   children: [
              //     SizedBox(
              //       width: double.maxFinite,
              //       height: 250,
              //       child: CarouselSlider(
              //         options: CarouselOptions(
              //           height: double.maxFinite,
              //           autoPlay: true,
              //           autoPlayInterval: const Duration(seconds: 3),
              //           autoPlayAnimationDuration: const Duration(
              //             milliseconds: 800,
              //           ),
              //           viewportFraction: 1,
              //         ),
              //         items: [
              //           Container(color: Colors.red),
              //           Container(color: Colors.green),
              //         ],
              //       ),
              //     ),
              //     Positioned(
              //       bottom: 5,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: List.generate(
              //           2,
              //           (index) => Container(
              //             margin: const EdgeInsets.symmetric(horizontal: 4),
              //             width: //_currentIndex == index
              //             true
              //                 ? 10
              //                 : 8,
              //             height: // _currentIndex == index
              //             true
              //                 ? 10
              //                 : 8,
              //             decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               color:
              //                   true //_currentIndex == index
              //                   ? Colors.grey
              //                   : Colors.grey,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
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
                            (dashboardController
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
                        onPageChanged: (index, reason) {
                          dashboardController.bannerCurrentIndex = index;
                          marketingController.update();
                        },
                      ),
                      items:
                          dashboardController.dashboardDataModel?.banners
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
                        dashboardController
                                .dashboardDataModel
                                ?.banners
                                ?.length ??
                            0,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: dashboardController.bannerCurrentIndex == index
                              ? 10
                              : 8,
                          height:
                              dashboardController.bannerCurrentIndex == index
                              ? 10
                              : 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                dashboardController.bannerCurrentIndex == index
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    AppText(text: "Posts", fontWeight: FontWeight.w600),
                    Spacer(),
                    ViewAllWidget(
                      onTap: () {
                        dashboardController.selectedIndex = 1;
                        dashboardController.update();
                      },
                    ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                    AppText(text: "Reels", fontWeight: FontWeight.w600),
                    Spacer(),
                    ViewAllWidget(
                      onTap: () {
                        dashboardController.selectedIndex = 2;
                        dashboardController.update();
                      },
                    ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    AppText(text: "Videos", fontWeight: FontWeight.w600),
                    Spacer(),
                    ViewAllWidget(
                      onTap: () {
                        dashboardController.selectedIndex = 3;
                        dashboardController.update();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 320,
                child: controller.isVideoLoading
                    ? CommonWidget.commonLoading()
                    : controller.videoModelList.isEmpty
                    ? CommonWidget.commonEmpty()
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.videoModelList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            child: SizedBox(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AppImageView(
                                      width: double.maxFinite,
                                      imageUrl: controller
                                          .videoModelList[index]
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
                                                  .videoModelList[index]
                                                  .title ??
                                              "",
                                          fontWeight: FontWeight.w700,
                                        ),
                                        AppText(
                                          text:
                                              "${controller.videoModelList[index].month ?? ""} ${controller.videoModelList[index].year ?? ""}",
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
