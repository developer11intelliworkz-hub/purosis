import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/feature/admin/marketing/controller/marketing_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/common_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';

class BrochureView extends StatefulWidget {
  const BrochureView({super.key});

  @override
  State<BrochureView> createState() => _BrochureViewState();
}

class _BrochureViewState extends State<BrochureView> {
  MarketingController marketingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Brochure"),
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
                        controller: controller.brochureSearchTEC,
                        onChanged: controller.filterBrochure,
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
                  child: RefreshIndicator(
                    onRefresh: () => controller.getBrochuresApi(),
                    child: controller.isBrochuresLoading
                        ? CommonWidget.commonLoading()
                        : controller.brochuresModelFilterList.isEmpty
                        ? CommonWidget.commonEmpty()
                        : GridView.builder(
                            padding: EdgeInsets.only(bottom: 200, top: 20),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.editBrochures,
                                    arguments: controller
                                        .brochuresModelFilterList[index],
                                  )?.then((value) {
                                    if (value == true) {
                                      controller.getBrochuresApi();
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
