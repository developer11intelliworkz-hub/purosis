import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/widget/common_widget.dart';

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
  MarketingController marketingController = Get.find();

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
                AppSearchField(),
                SizedBox(height: 5),
                Expanded(
                  child: controller.isLeafletLoading
                      ? CommonWidget.commonLoading()
                      : controller.leafletModelList.isEmpty
                      ? CommonWidget.commonEmpty()
                      : RefreshIndicator(
                          onRefresh: () async =>
                              await controller.getLeafletApi(),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                            itemCount: controller.leafletModelList.length,
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
                                              .leafletModelList[index]
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
                                                      .leafletModelList[index]
                                                      .title ??
                                                  "",
                                              fontWeight: FontWeight.w700,
                                            ),
                                            AppText(
                                              text:
                                                  "${controller.leafletModelList[index].month ?? ""} ${controller.leafletModelList[index].year ?? ""}",
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
