import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../consts/app_image.dart';
import '../../../../routes/app_routes.dart';
import '../../../../widget/app_badge_widget.dart';
import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/common_widget.dart';
import '../controller/marketing_controller.dart';

class BrochuresViewDealer extends StatefulWidget {
  const BrochuresViewDealer({super.key});

  @override
  State<BrochuresViewDealer> createState() => _BrochuresViewDealerState();
}

class _BrochuresViewDealerState extends State<BrochuresViewDealer> {
  MarketingController marketingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Brochure"),
      body: GetBuilder<MarketingController>(
        init: marketingController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: AppSearchField()),
                    AppBadgeWidget(
                      showBadge:
                          controller.filterBrochuresSelectedValue?.isNotEmpty ??
                          false,
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.filterMarketingBrochures,
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
                        icon: Icon(Icons.tune),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Expanded(
                  child: controller.isBrochuresLoading
                      ? CommonWidget.commonLoading()
                      : controller.brochuresModelList.isEmpty
                      ? CommonWidget.commonEmpty()
                      : RefreshIndicator(
                          onRefresh: () async =>
                              await controller.getBrochuresApi(),
                          child: GridView.builder(
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
                                                        .brochuresModelList[index]
                                                        .title ??
                                                    "",
                                                fontWeight: FontWeight.w700,
                                              ),
                                              AppText(
                                                text:
                                                    "${controller.brochuresModelList[index].month} ${controller.brochuresModelList[index].year}",
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(height: 5),
                                              InkWell(
                                                onTap: () async {
                                                  await launchUrlString(
                                                    controller
                                                            .brochuresModelList[index]
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
                            itemCount: controller.brochuresModelList.length,
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
