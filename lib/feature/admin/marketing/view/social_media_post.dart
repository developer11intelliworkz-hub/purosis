import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/marketing/controller/marketing_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_image_view.dart';
import 'package:purosis/widget/app_search_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/app_text.dart';

class SocialMediaPost extends StatefulWidget {
  const SocialMediaPost({super.key});

  @override
  State<SocialMediaPost> createState() => _SocialMediaPostState();
}

class _SocialMediaPostState extends State<SocialMediaPost> {
  MarketingController marketingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Social Media Post"),
      body: GetBuilder<MarketingController>(
        init: marketingController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AppSearchField(),
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
                            itemCount: controller.postsModelList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.editPost,
                                    arguments: controller.postsModelList[index],
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
