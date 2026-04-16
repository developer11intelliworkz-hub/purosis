import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../widget/app_image_view_thumb.dart';
import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/common_widget.dart';
import '../controller/marketing_controller.dart';

class PostsViewDistributor extends StatefulWidget {
  const PostsViewDistributor({super.key});

  @override
  State<PostsViewDistributor> createState() => _PostsViewDistributorState();
}

class _PostsViewDistributorState extends State<PostsViewDistributor> {
  late MarketingController marketingController;

  @override
  void initState() {
    if (Get.isRegistered<MarketingController>()) {
      marketingController = Get.find();
    } else {
      marketingController = MarketingController();
      marketingController.getPostsApi();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Posts"),
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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          ),
                                          AppText(
                                            text:
                                                "${controller.postsModelFilterList[index].month ?? ""} ${controller.postsModelFilterList[index].year ?? ""}",
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(height: 5),
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                AppRoutes
                                                    .customizePostDistributor,
                                                arguments: controller
                                                    .postsModelList[index],
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
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  AppText(
                                                    text: "Customize",
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Icon(
                                                    Icons.arrow_forward_rounded,
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
