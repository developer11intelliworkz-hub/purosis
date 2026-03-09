import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/app_image_view.dart';
import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/common_widget.dart';
import '../controller/marketing_controller.dart';

class ReelsViewDistributor extends StatefulWidget {
  const ReelsViewDistributor({super.key});

  @override
  State<ReelsViewDistributor> createState() => _ReelsViewDistributorState();
}

class _ReelsViewDistributorState extends State<ReelsViewDistributor> {
  final MarketingController marketingController = Get.find();
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
    );
  }
}
