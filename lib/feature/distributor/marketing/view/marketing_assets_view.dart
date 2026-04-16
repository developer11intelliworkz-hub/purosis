import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/feature/distributor/marketing/controller/marketing_controller.dart';
import 'package:purosis/feature/distributor/marketing/view/widget/view_all_widget.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../widget/app_image_view_thumb.dart';
import '../../../../widget/common_widget.dart';

class MarketingAssetsView extends StatefulWidget {
  const MarketingAssetsView({super.key});

  @override
  State<MarketingAssetsView> createState() => _MarketingAssetsViewState();
}

class _MarketingAssetsViewState extends State<MarketingAssetsView> {
  final MarketingController marketingController = Get.put(
    MarketingController(),
  );
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
    return GetBuilder<MarketingController>(
      init: marketingController,
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 600,
                  child: GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.postViewDistributor);
                        },
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: "Post",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                                SizedBox(height: 40),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFFDEF1FF),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_outlined,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.brochuresViewDistributor);
                        },
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: "Brochure",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                                SizedBox(height: 40),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFFDEF1FF),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_outlined,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.videoViewDistributor);
                        },
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: "Video",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                                SizedBox(height: 40),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFFDEF1FF),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_outlined,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.reelViewDistributor);
                        },
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: "Reel",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                                SizedBox(height: 40),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFFDEF1FF),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_outlined,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.leafletViewDistributor);
                        },
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: "Leaflet",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                                SizedBox(height: 40),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFFDEF1FF),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_outlined,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      AppText(text: "Brochures", fontWeight: FontWeight.w600),
                      Spacer(),
                      ViewAllWidget(
                        onTap: () {
                          Get.toNamed(AppRoutes.brochuresViewDistributor);
                        },
                      ),
                    ],
                  ),
                ),
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
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      AppText(text: "Posts", fontWeight: FontWeight.w600),
                      Spacer(),
                      ViewAllWidget(
                        onTap: () {
                          Get.toNamed(AppRoutes.postViewDistributor);
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
                          Get.toNamed(AppRoutes.reelViewDistributor);
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
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
