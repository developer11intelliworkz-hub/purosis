import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/widget/common_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../routes/app_routes.dart';
import '../../../../widget/app_dialog.dart';
import '../../../../widget/app_image_view_thumb.dart';
import '../../../../widget/app_image_viewer.dart';
import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';
import '../controller/marketing_controller.dart';

class LeafletView extends StatefulWidget {
  const LeafletView({super.key});

  @override
  State<LeafletView> createState() => _LeafletViewState();
}

class _LeafletViewState extends State<LeafletView> {
  final MarketingController marketingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Leaflet"),
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
                        controller: controller.leafletSearchTEC,
                        onChanged: controller.filterLeaflet,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.filterPageAdmin,
                          arguments: controller.filterLeafletsSelectedValue,
                        )?.then((value) {
                          if (value != null) {
                            controller.filterLeafletsSelectedValue = value;
                            controller.getReelApi(
                              queryParameters:
                                  controller.filterLeafletsSelectedValue,
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
                                    .filterLeafletsSelectedValue
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
                            padding: EdgeInsets.only(bottom: 200, top: 20),

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
                                    () => AppImageViewer(
                                      imageUrls:
                                          controller
                                              .leafletModelFilterList[index]
                                              .mediaFile ??
                                          [],
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
                                                .leafletModelFilterList[index]
                                                .mediaFile
                                                ?.first,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  bottom: 8,
                                                  left: 8,
                                                ),
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      maxLines: 1,
                                                    ),
                                                    AppText(
                                                      text:
                                                          "${controller.leafletModelFilterList[index].month ?? ""} ${controller.leafletModelFilterList[index].year ?? ""}",
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
                                                    AppRoutes.editLeaflet,
                                                    arguments: controller
                                                        .leafletModelFilterList[index],
                                                  )?.then((value) {
                                                    if (value == true) {
                                                      marketingController
                                                          .getLeafletApi();
                                                    }
                                                  });
                                                } else if (value == 'delete') {
                                                  AppDialogs.showDeleteDialog(
                                                    onDelete: () async {
                                                      await controller
                                                          .deleteLeafletApi(
                                                            controller
                                                                .leafletModelFilterList[index]
                                                                .id,
                                                          );
                                                    },
                                                    isLoading: controller
                                                        .isLeafletDeleteLoading,
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
          Get.toNamed(AppRoutes.addLeaflet)?.then((value) {
            if (value == true) {
              marketingController.getLeafletApi();
            }
          });
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
