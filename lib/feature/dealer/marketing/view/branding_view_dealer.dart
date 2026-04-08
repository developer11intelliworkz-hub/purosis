import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/dealer/marketing/controller/marketing_controller.dart';
import 'package:purosis/feature/dealer/marketing/view/widget/view_all_widget.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../consts/app_image.dart';
import '../../../../widget/app_image_view.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/common_widget.dart';

class BrandingViewDealer extends StatefulWidget {
  const BrandingViewDealer({super.key});

  @override
  State<BrandingViewDealer> createState() => _BrandingViewDealerState();
}

class _BrandingViewDealerState extends State<BrandingViewDealer> {
  final MarketingController marketingController = Get.find();

  @override
  void initState() {
    marketingController.getBrochuresApi();
    marketingController.getLeafletApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarketingController>(
      init: marketingController,
      builder: (controller) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    AppText(text: "Brochures", fontWeight: FontWeight.w600),
                    Spacer(),
                    ViewAllWidget(
                      onTap: () {
                        Get.toNamed(AppRoutes.brochuresDealer);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 320,
                child: controller.isBrochuresLoading
                    ? CommonWidget.commonLoading()
                    : controller.brochuresModelList.isEmpty
                    ? CommonWidget.commonEmpty()
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            child: SizedBox(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          maxLines: 1,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        AppText(
                                          text:
                                              "${controller.brochuresModelList[index].month} ${controller.brochuresModelList[index].year}",
                                          fontWeight: FontWeight.w400,
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
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                AppText(
                                                  text: "Download",
                                                  fontWeight: FontWeight.w600,
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
                          );
                        },
                        itemCount: controller.brochuresModelList.length,
                      ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    AppText(text: "Leaflets", fontWeight: FontWeight.w600),
                    Spacer(),
                    ViewAllWidget(
                      onTap: () {
                        Get.toNamed(AppRoutes.leafletDealer);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 320,
                child: controller.isLeafletLoading
                    ? CommonWidget.commonLoading()
                    : controller.leafletModelList.isEmpty
                    ? CommonWidget.commonEmpty()
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.leafletModelList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            child: SizedBox(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          fontWeight: FontWeight.w400,
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
            ],
          ),
        );
      },
    );
  }
}
