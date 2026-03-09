import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/marketing/controller/marketing_controller.dart';

import '../../../../routes/app_routes.dart';
import '../../../../widget/app_image_view.dart';
import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/common_widget.dart';

class ReelsView extends StatefulWidget {
  const ReelsView({super.key});

  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView> {
  MarketingController marketingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Reels"),
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
                  child: controller.isReelsLoading
                      ? CommonWidget.commonLoading()
                      : controller.reelsModelList.isEmpty
                      ? CommonWidget.commonEmpty()
                      : RefreshIndicator(
                          onRefresh: () async => await controller.getReelApi(),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                            itemCount: controller.reelsModelList.length,
                            itemBuilder: (context, index) {
                              return Card(
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
                                              fontWeight: FontWeight.w700,
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
