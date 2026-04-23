import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/widget/app_video_player.dart';

import '../../../../routes/app_routes.dart';
import '../../../../widget/app_badge_widget.dart';
import '../../../../widget/app_image_view_thumb.dart';
import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/common_widget.dart';
import '../controller/marketing_controller.dart';

class ReelsViewDealer extends StatefulWidget {
  const ReelsViewDealer({super.key, this.isAppBarShow = true});
  final bool isAppBarShow;

  @override
  State<ReelsViewDealer> createState() => _ReelsViewDealerState();
}

class _ReelsViewDealerState extends State<ReelsViewDealer> {
  final MarketingController marketingController = Get.find();

  @override
  void initState() {
    marketingController.filterReelSelectedValue = {};
    marketingController.getReelApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAppBarShow
          ? CommonWidget.appAppBar(title: "Reel")
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
                        controller: controller.reelSearchTEC,
                        onChanged: controller.filterReel,
                      ),
                    ),
                    AppBadgeWidget(
                      showBadge:
                          controller.filterReelSelectedValue?.isNotEmpty ??
                          false,
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.filterMarketingReel,
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
                        icon: Icon(Icons.tune),
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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                            itemCount: controller.reelsModelFilterList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    AppVideoPlayer(
                                      videoUrl:
                                          controller
                                              .reelsModelFilterList[index]
                                              .mediaFile ??
                                          "",
                                      title: controller
                                          .reelsModelFilterList[index]
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
                                                .reelsModelFilterList[index]
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
                                                        .reelsModelFilterList[index]
                                                        .title ??
                                                    "",
                                                fontWeight: FontWeight.w700,
                                                maxLines: 1,
                                              ),
                                              AppText(
                                                text:
                                                    "${controller.reelsModelFilterList[index].month ?? ""} ${controller.reelsModelFilterList[index].year ?? ""}",
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey,
                                                maxLines: 1,
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
    );
  }
}
