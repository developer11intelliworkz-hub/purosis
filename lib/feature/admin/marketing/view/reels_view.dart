import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/marketing/controller/marketing_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../../routes/app_routes.dart';
import '../../../../widget/app_dialog.dart';
import '../../../../widget/app_image_view_thumb.dart';
import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/app_video_player.dart';
import '../../../../widget/common_widget.dart';

class ReelsView extends StatefulWidget {
  const ReelsView({super.key});

  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView> {
  final MarketingController marketingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Reels"),
      body: GetBuilder<MarketingController>(
        init: marketingController,
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
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
                Row(
                  children: [
                    Expanded(
                      child: AppSearchField(
                        controller: controller.reelSearchTEC,
                        onChanged: controller.filterReel,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.filterPageAdmin,
                          arguments: controller.filterReelSelectedValue,
                        )?.then((value) {
                          if (value != null) {
                            controller.filterReelSelectedValue = value;
                            controller.getReelApi(
                              queryParameters:
                                  controller.filterReelSelectedValue,
                            );
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Badge(
                            smallSize: 8,
                            isLabelVisible:
                                controller
                                    .filterReelSelectedValue
                                    ?.isNotEmpty ??
                                false,
                            backgroundColor: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset("assets/icon/filter.png"),
                            ),
                          ),
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
                  child: controller.isReelsLoading
                      ? CommonWidget.commonLoading()
                      : controller.reelsModelFilterList.isEmpty
                      ? CommonWidget.commonEmpty()
                      : RefreshIndicator(
                          onRefresh: () async => await controller.getReelApi(
                            queryParameters: controller.filterReelSelectedValue,
                          ),
                          child: GridView.builder(
                            padding: EdgeInsets.only(bottom: 200, top: 20),

                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                            itemCount: controller.reelsModelFilterList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                    () => AppVideoPlayer(
                                      videoUrl:
                                          controller
                                              .reelsModelFilterList[index]
                                              .mediaFile ??
                                          "",
                                    ),
                                  );
                                },
                                child: Card(
                                  color: Colors.white,
                                  child: SizedBox(
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: AppImageViewThumb(
                                            width: double.maxFinite,
                                            imageUrl: controller
                                                .reelsModelFilterList[index]
                                                .thumbnailImage,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  top: 8,
                                                  bottom: 8,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AppText(
                                                      text:
                                                          controller
                                                              .reelsModelFilterList[index]
                                                              .title ??
                                                          "",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    AppText(
                                                      text:
                                                          "${controller.reelsModelFilterList[index].month ?? ""} ${controller.reelsModelFilterList[index].year ?? ""}",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.grey,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            PopupMenuButton<String>(
                                              color: Colors.white,
                                              onSelected: (value) {
                                                if (value == 'edit') {
                                                  Get.toNamed(
                                                    AppRoutes.editReel,
                                                    arguments: controller
                                                        .reelsModelFilterList[index],
                                                  )?.then((value) {
                                                    if (value == true) {
                                                      marketingController
                                                          .getReelApi();
                                                    }
                                                  });
                                                } else if (value == 'delete') {
                                                  AppDialogs.showDeleteDialog(
                                                    onDelete: () async {
                                                      await controller
                                                          .deleteReelApi(
                                                            controller
                                                                .reelsModelFilterList[index]
                                                                .id,
                                                          );
                                                    },
                                                    isLoading: controller
                                                        .isReelDeleteLoading,
                                                  );
                                                }
                                              },
                                              itemBuilder: (context) => [
                                                const PopupMenuItem(
                                                  value: 'edit',
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.edit,
                                                        size: 18,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text('Edit'),
                                                    ],
                                                  ),
                                                ),
                                                const PopupMenuItem(
                                                  value: 'delete',
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.delete,
                                                        size: 18,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text('Delete'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                              icon: const Icon(Icons.more_vert),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF0067B1),
        onPressed: () {
          Get.toNamed(AppRoutes.addReels)?.then((value) {
            if (value == true) {
              marketingController.getReelApi();
            }
          });
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
