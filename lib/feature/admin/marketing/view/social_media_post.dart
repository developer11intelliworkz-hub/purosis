import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/marketing/controller/marketing_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_image_view_thumb.dart';
import 'package:purosis/widget/app_image_viewer.dart';
import 'package:purosis/widget/app_search_field.dart';
import 'package:purosis/widget/common_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../widget/app_dialog.dart';
import '../../../../widget/app_text.dart';

class SocialMediaPost extends StatefulWidget {
  const SocialMediaPost({super.key});

  @override
  State<SocialMediaPost> createState() => _SocialMediaPostState();
}

class _SocialMediaPostState extends State<SocialMediaPost> {
  final MarketingController marketingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Social Media Post"),
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
                        controller: controller.postSearchTEC,
                        onChanged: controller.filterPosts,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.filterPageAdmin,
                          arguments: controller.filterPostSelectedValue,
                        )?.then((value) {
                          if (value != null) {
                            controller.filterPostSelectedValue = value;
                            controller.getPostsApi(
                              queryParameters:
                                  controller.filterPostSelectedValue,
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
                                    .filterPostSelectedValue
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
                  child: controller.isPostsLoading
                      ? CommonWidget.commonLoading()
                      : controller.postsModelFilterList.isEmpty
                      ? CommonWidget.commonEmpty()
                      : RefreshIndicator(
                          onRefresh: () async => await controller.getPostsApi(
                            queryParameters: controller.filterPostSelectedValue,
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
                            itemCount: controller.postsModelFilterList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                    () => AppImageViewer(
                                      imageUrls: [
                                        controller
                                                .postsModelFilterList[index]
                                                .mediaFile ??
                                            "",
                                      ],
                                      title: controller
                                          .postsModelFilterList[index]
                                          .title,
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
                                                .postsModelFilterList[index]
                                                .mediaFile,
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
                                                              .postsModelFilterList[index]
                                                              .title ??
                                                          "",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      maxLines: 1,
                                                    ),
                                                    AppText(
                                                      text:
                                                          "${controller.postsModelFilterList[index].month ?? ""} ${controller.postsModelFilterList[index].year ?? ""}",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.grey,
                                                      maxLines: 1,
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
                                                    AppRoutes.editPost,
                                                    arguments: controller
                                                        .postsModelFilterList[index],
                                                  )?.then((value) {
                                                    if (value == true) {
                                                      controller.getPostsApi();
                                                    }
                                                  });
                                                } else if (value == 'delete') {
                                                  AppDialogs.showDeleteDialog(
                                                    onDelete: () async {
                                                      await controller
                                                          .deletePostApi(
                                                            controller
                                                                .postsModelFilterList[index]
                                                                .id,
                                                          );
                                                    },
                                                    isLoading: controller
                                                        .isPostDeleteLoading,
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
          Get.toNamed(AppRoutes.addPosts)?.then((value) {
            if (value == true) {
              marketingController.getPostsApi();
            }
          });
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
