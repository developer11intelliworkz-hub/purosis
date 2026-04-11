import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../widget/app_image_view.dart';
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
  final MarketingController marketingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Social Media Post"),
      body: GetBuilder<MarketingController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AppSearchField(
                  controller: controller.postSearchTEC,
                  onChanged: controller.filterPosts,
                ),
                SizedBox(height: 5),
                Expanded(
                  child: controller.isPostsLoading
                      ? CommonWidget.commonLoading()
                      : controller.postsModelFilterList.isEmpty
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
