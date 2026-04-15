import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/widget/common_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../routes/app_routes.dart';
import '../../../../widget/app_image_view.dart';
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
                      onTap: () {},
                      child: Row(
                        children: [
                          SizedBox(
                            height: 2.h,
                            width: 2.h,
                            child: Image.asset("assets/icon/filter.png"),
                          ),
                          SizedBox(width: 2.w),
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
                          onRefresh: () async =>
                              await controller.getLeafletApi(),
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
                                  Get.toNamed(
                                    AppRoutes.editLeaflet,
                                    arguments: controller
                                        .leafletModelFilterList[index],
                                  )?.then((value) {
                                    if (value == true) {
                                      marketingController.getLeafletApi();
                                    }
                                  });
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
                                              ),
                                              AppText(
                                                text:
                                                    "${controller.leafletModelFilterList[index].month ?? ""} ${controller.leafletModelFilterList[index].year ?? ""}",
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
