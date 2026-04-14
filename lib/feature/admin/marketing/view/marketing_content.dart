import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/marketing/controller/marketing_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_image_view.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../consts/app_image.dart';

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
              children: [
                SizedBox(height: 5),
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
                            return Card(
                              color: Colors.white,
                              child: SizedBox(
                                width: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  AppText(
                                                    text: "Download",
                                                    fontWeight: FontWeight.w600,
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
                SizedBox(height: 5),
                Row(
                  children: [
                    AppText(
                      text: "Reel",
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
                SizedBox(height: 5),
                Row(
                  children: [
                    AppText(
                      text: "Leaflet",
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
                            return Card(
                              color: Colors.white,
                              child: SizedBox(
                                width: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: AppImageView(
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
                            );
                          },
                        ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    AppText(
                      text: "Video",
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
      ),
    );
  }
}
