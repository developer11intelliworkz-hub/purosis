import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/profile/controller/banner_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_image_view_thumb.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/app_text.dart';

class BannerView extends StatefulWidget {
  const BannerView({super.key});

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  final BannerController bannerController = BannerController();

  @override
  void initState() {
    bannerController.getBannerApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Offer Banner"),
      body: GetBuilder<BannerController>(
        init: bannerController,
        builder: (controller) {
          return controller.isBannerLoading
              ? CommonWidget.commonLoading()
              : controller.bannerModelList.isEmpty
              ? CommonWidget.commonEmpty()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RefreshIndicator(
                    onRefresh: () async => await controller.getBannerApi(),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: controller.bannerModelList.length,
                      itemBuilder: (context, index) {
                        final banner = controller.bannerModelList[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: AppImageViewThumb(
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  imageUrl: banner.image ?? "",
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: AppText(
                                        text:
                                            "Show in: ${banner.type?.capitalizeFirst ?? ""}",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),

                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          Get.toNamed(
                                            AppRoutes.editBannerView,
                                            arguments: controller
                                                .bannerModelList[index],
                                          )?.then((value) {
                                            if (value == true) {
                                              controller.getBannerApi();
                                            }
                                          });
                                        },
                                        icon: Icon(Icons.edit, size: 20),
                                        color: Colors.grey.shade700,
                                      ),
                                    ),

                                    SizedBox(width: 6),

                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade50,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        onPressed:
                                            controller.isBannerDeleteLoading
                                            ? null
                                            : () {
                                                controller.deleteBannerApi(
                                                  controller
                                                      .bannerModelList[index]
                                                      .id,
                                                );
                                              },
                                        icon:
                                            controller.isBannerDeleteLoading &&
                                                controller.selectedId ==
                                                    controller
                                                        .bannerModelList[index]
                                                        .id
                                            ? Padding(
                                                padding: const EdgeInsets.all(
                                                  8,
                                                ),
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : Icon(Icons.delete, size: 20),
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF0067B1),
        onPressed: () {
          Get.toNamed(AppRoutes.addBannerView)?.then((value) {
            if (value == true) {
              bannerController.getBannerApi();
            }
          });
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
