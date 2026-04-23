import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_image_viewer.dart';

import '../../../../widget/app_badge_widget.dart';
import '../../../../widget/app_image_view_thumb.dart';
import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/common_widget.dart';
import '../controller/marketing_controller.dart';

class PostsViewDealer extends StatefulWidget {
  const PostsViewDealer({super.key, this.isAppBarShow = true});
  final bool isAppBarShow;

  @override
  State<PostsViewDealer> createState() => _PostsViewDealerState();
}

class _PostsViewDealerState extends State<PostsViewDealer> {
  final MarketingController marketingController = Get.find();

  @override
  void initState() {
    marketingController.filterPostSelectedValue = {};
    marketingController.getPostsApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAppBarShow
          ? CommonWidget.appAppBar(title: "Posts")
          : null,
      body: GetBuilder<MarketingController>(
        init: marketingController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppSearchField(
                        controller: controller.postSearchTEC,
                        onChanged: controller.filterPosts,
                      ),
                    ),
                    AppBadgeWidget(
                      showBadge:
                          controller.filterPostSelectedValue?.isNotEmpty ??
                          false,
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.filterMarketingPost,
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
                        icon: Icon(Icons.tune),
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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    AppImageViewer(
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                              fontWeight: FontWeight.w700,
                                              maxLines: 1,
                                            ),
                                            AppText(
                                              text:
                                                  "${controller.postsModelFilterList[index].month ?? ""} ${controller.postsModelFilterList[index].year ?? ""}",
                                              fontWeight: FontWeight.w700,
                                              color: Colors.grey,
                                              maxLines: 1,
                                            ),
                                            SizedBox(height: 5),
                                            GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                  AppRoutes.customizePost,
                                                  arguments: controller
                                                      .postsModelFilterList[index],
                                                );
                                              },
                                              child: Container(
                                                height: 30,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF0067B1),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    AppText(
                                                      text: "Customize",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_rounded,
                                                      color: Colors.white,
                                                      size: 20,
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
                            itemCount: controller.postsModelFilterList.length,
                          ),
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
