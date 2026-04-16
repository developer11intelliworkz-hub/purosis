import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../consts/app_image.dart';
import '../../../../routes/app_routes.dart';
import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/common_widget.dart';
import '../controller/marketing_controller.dart';

class BrochuresViewDistributorDashboard extends StatefulWidget {
  const BrochuresViewDistributorDashboard({super.key});

  @override
  State<BrochuresViewDistributorDashboard> createState() =>
      _BrochuresViewDistributorDashboardState();
}

class _BrochuresViewDistributorDashboardState
    extends State<BrochuresViewDistributorDashboard> {
  MarketingController marketingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Brochures"),
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
                        controller: controller.brochureSearchTEC,
                        onChanged: controller.filterBrochure,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.filterPageAdmin,
                          arguments: controller.filterBrochuresSelectedValue,
                        )?.then((value) {
                          if (value != null) {
                            controller.filterBrochuresSelectedValue = value;
                            controller.getBrochuresApi(
                              queryParameters:
                                  controller.filterBrochuresSelectedValue,
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
                                    .filterBrochuresSelectedValue
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
                  child: RefreshIndicator(
                    onRefresh: () async => await controller.getBrochuresApi(
                      queryParameters: controller.filterBrochuresSelectedValue,
                    ),
                    child: controller.isBrochuresLoading
                        ? CommonWidget.commonLoading()
                        : controller.brochuresModelFilterList.isEmpty
                        ? CommonWidget.commonEmpty()
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {},
                                child: Card(
                                  color: Colors.white,
                                  child: SizedBox(
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            width: double.maxFinite,
                                            AppImage.pdfThumbImage,
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
                                                        .brochuresModelFilterList[index]
                                                        .title ??
                                                    "",
                                                fontWeight: FontWeight.w700,
                                              ),
                                              AppText(
                                                text:
                                                    "${controller.brochuresModelFilterList[index].month} ${controller.brochuresModelFilterList[index].year}",
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(height: 5),
                                              InkWell(
                                                onTap: () async {
                                                  await launchUrlString(
                                                    controller
                                                            .brochuresModelFilterList[index]
                                                            .mediaFile ??
                                                        "",
                                                  );
                                                },
                                                child: Container(
                                                  height: 40,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF8EBF1F),
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
                                                        text: "Download",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(width: 5),
                                                      Icon(
                                                        Icons.arrow_downward,
                                                        color: Colors.white,
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
                                  ),
                                ),
                              );
                            },
                            itemCount:
                                controller.brochuresModelFilterList.length,
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
          Get.toNamed(AppRoutes.addBrochures)?.then((value) {
            marketingController.getBrochuresApi();
          });
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
