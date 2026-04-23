import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/widget/app_image_viewer.dart';

import '../../../../routes/app_routes.dart';
import '../../../../widget/app_badge_widget.dart';
import '../../../../widget/app_image_view_thumb.dart';
import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/common_widget.dart';
import '../controller/marketing_controller.dart';

class LeafleatsViewDealer extends StatefulWidget {
  const LeafleatsViewDealer({super.key});

  @override
  State<LeafleatsViewDealer> createState() => _LeafleatsViewDealerState();
}

class _LeafleatsViewDealerState extends State<LeafleatsViewDealer> {
  final MarketingController marketingController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Leaflet"),
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
                        controller: controller.leafletSearchTEC,
                        onChanged: controller.filterLeaflet,
                      ),
                    ),
                    AppBadgeWidget(
                      showBadge:
                          controller.filterLeafletsSelectedValue?.isNotEmpty ??
                          false,
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.filterMarketingLeaflets,
                            arguments: controller.filterLeafletsSelectedValue,
                          )?.then((value) {
                            if (value != null) {
                              controller.filterLeafletsSelectedValue = value;
                              controller.getLeafletApi(
                                queryParameters:
                                    controller.filterLeafletsSelectedValue,
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
                  child: controller.isLeafletLoading
                      ? CommonWidget.commonLoading()
                      : controller.leafletModelFilterList.isEmpty
                      ? CommonWidget.commonEmpty()
                      : RefreshIndicator(
                          onRefresh: () async => await controller.getLeafletApi(
                            queryParameters:
                                controller.filterLeafletsSelectedValue,
                          ),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                            itemCount: controller.leafletModelFilterList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    AppImageViewer(
                                      imageUrls:
                                          controller
                                              .leafletModelFilterList[index]
                                              .mediaFile ??
                                          [],
                                      title: controller
                                          .leafletModelFilterList[index]
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
                                                .leafletModelFilterList[index]
                                                .mediaFile
                                                ?.first,
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
                                                        .leafletModelFilterList[index]
                                                        .title ??
                                                    "",
                                                fontWeight: FontWeight.w700,
                                                maxLines: 1,
                                              ),
                                              AppText(
                                                text:
                                                    "${controller.leafletModelFilterList[index].month ?? ""} ${controller.leafletModelFilterList[index].year ?? ""}",
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
