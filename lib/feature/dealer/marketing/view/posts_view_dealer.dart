import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/routes/app_routes.dart';

import '../../../../widget/app_badge_widget.dart';
import '../../../../widget/app_image_view.dart';
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
                    Expanded(child: AppSearchField()),
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
                      : controller.postsModelList.isEmpty
                      ? CommonWidget.commonEmpty()
                      : RefreshIndicator(
                          onRefresh: () async => await controller.getPostsApi(),
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
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      AppRoutes.customizePost,
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
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
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
                                              ),
                                              SizedBox(width: 10),
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xFF8EBF1F),
                                                ),
                                                child: Icon(
                                                  Icons.arrow_downward,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: controller.postsModelList.length,
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
