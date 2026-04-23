import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/marketing/controller/marketing_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_image_view_thumb.dart';
import 'package:purosis/widget/app_search_field.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../consts/app_image.dart';
import '../../../../widget/app_image_viewer.dart';
import '../../../../widget/app_pdf_viewer.dart';
import '../../../../widget/app_video_player.dart';

class MarketingContent extends StatefulWidget {
  const MarketingContent({super.key});

  @override
  State<MarketingContent> createState() => _MarketingContentState();
}

class _MarketingContentState extends State<MarketingContent> {
  MarketingController marketingController = Get.put(MarketingController());

  @override
  void initState() {
    marketingController.getBrochuresApi();
    marketingController.getPostsApi();
    marketingController.getReelApi();
    marketingController.getLeafletApi();
    marketingController.getVideoApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MarketingController>(
        init: marketingController,
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Upload and manage social media posts",
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF888888),
                ),
                SizedBox(height: 1.h),

                AppSearchField(
                  controller: controller.reelSearchTEC,
                  onChanged: controller.filterReel,
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    AppText(
                      text: "Brochures",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.brochures);
                      },
                      child: AppText(
                        text: "View All",
                        color: Color(0xFF8EBF1F),
                      ),
                    ),
                    Icon(Icons.arrow_forward_rounded, color: Color(0xFF8EBF1F)),
                  ],
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 320,
                  child: controller.isBrochuresLoading
                      ? CommonWidget.commonLoading()
                      : controller.brochuresModelList.isEmpty
                      ? CommonWidget.commonEmpty()
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => AppPdfViewer(
                                    url:
                                        controller
                                            .brochuresModelList[index]
                                            .mediaFile ??
                                        "",
                                    header: controller
                                        .brochuresModelList[index]
                                        .title,
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                child: SizedBox(
                                  width: 180,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          width: double.maxFinite,
                                          AppImage.pdfThumbImage,
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
                                                      .brochuresModelList[index]
                                                      .title ??
                                                  "",
                                              maxLines: 1,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            AppText(
                                              text:
                                                  "${controller.brochuresModelList[index].month} ${controller.brochuresModelList[index].year}",
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(height: 5),
                                            InkWell(
                                              onTap: () async {
                                                await launchUrlString(
                                                  controller
                                                          .brochuresModelList[index]
                                                          .mediaFile ??
                                                      "",
                                                );
                                              },
                                              child: Container(
                                                height: 40,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF8EBF1F),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    AppText(
                                                      text: "Download",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Icon(
                                                      Icons.arrow_downward,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: controller.brochuresModelList.length,
                        ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    AppText(
                      text: "Posts",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.posts);
                      },
                      child: AppText(
                        text: "View All",
                        color: Color(0xFF8EBF1F),
                      ),
                    ),
                    Icon(Icons.arrow_forward_rounded, color: Color(0xFF8EBF1F)),
                  ],
                ),
                SizedBox(height: 5),
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
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => AppImageViewer(
                                    imageUrls: [
                                      controller
                                              .postsModelList[index]
                                              .mediaFile ??
                                          "",
                                    ],
                                    title:
                                        controller.postsModelList[index].title,
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                child: SizedBox(
                                  width: 180,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: AppImageViewThumb(
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
                              ),
                            );
                          },
                        ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    AppText(
                      text: "Reels",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.reels);
                      },
                      child: AppText(
                        text: "View All",
                        color: Color(0xFF8EBF1F),
                      ),
                    ),
                    Icon(Icons.arrow_forward_rounded, color: Color(0xFF8EBF1F)),
                  ],
                ),
                SizedBox(height: 5),
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
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => AppVideoPlayer(
                                    videoUrl:
                                        controller
                                            .reelsModelList[index]
                                            .mediaFile ??
                                        "",
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                child: SizedBox(
                                  width: 180,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: AppImageViewThumb(
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
                              ),
                            );
                          },
                        ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    AppText(
                      text: "Leaflets",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.leaflet);
                      },
                      child: AppText(
                        text: "View All",
                        color: Color(0xFF8EBF1F),
                      ),
                    ),
                    Icon(Icons.arrow_forward_rounded, color: Color(0xFF8EBF1F)),
                  ],
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 320,
                  child: controller.isLeafletLoading
                      ? CommonWidget.commonLoading()
                      : controller.leafletModelList.isEmpty
                      ? CommonWidget.commonEmpty()
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.leafletModelList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => AppImageViewer(
                                    imageUrls:
                                        controller
                                            .leafletModelList[index]
                                            .mediaFile ??
                                        [],
                                    title: controller
                                        .leafletModelList[index]
                                        .title,
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                child: SizedBox(
                                  width: 180,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: AppImageViewThumb(
                                          imageUrl:
                                              controller
                                                  .leafletModelList[index]
                                                  .mediaFile
                                                  ?.first ??
                                              "",
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
                                                      .leafletModelList[index]
                                                      .title ??
                                                  "",
                                              fontWeight: FontWeight.w700,
                                            ),
                                            AppText(
                                              text:
                                                  "${controller.leafletModelList[index].month ?? ""} ${controller.leafletModelList[index].year ?? ""}",
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    AppText(
                      text: "Videos",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.video);
                      },
                      child: AppText(
                        text: "View All",
                        color: Color(0xFF8EBF1F),
                      ),
                    ),
                    Icon(Icons.arrow_forward_rounded, color: Color(0xFF8EBF1F)),
                  ],
                ),
                SizedBox(height: 5),
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
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => AppVideoPlayer(
                                    videoUrl:
                                        controller
                                            .videoModelList[index]
                                            .mediaFile ??
                                        '',
                                    title:
                                        controller.videoModelList[index].title,
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                child: SizedBox(
                                  width: 180,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: AppImageViewThumb(
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
                              ),
                            );
                          },
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
