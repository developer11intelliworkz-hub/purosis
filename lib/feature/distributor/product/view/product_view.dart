import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/widget/app_image_view_thumb.dart';

import '../../../../routes/app_routes.dart';
import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/common_widget.dart';
import '../controller/product_controller.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final ProductController productController = ProductController();

  @override
  void initState() {
    productController.getProductApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProductController>(
        init: productController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppSearchField(
                        onChanged: controller.filterProduct,
                        controller: controller.searchTEC,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.filter,
                          arguments: controller.selectedFilter,
                        )?.then((value) {
                          if (value != null) {
                            controller.selectedFilter = value;
                            controller.getProductApi(
                              queryParameters: controller.selectedFilter,
                            );
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Badge(
                            smallSize: 8,
                            isLabelVisible:
                                controller.selectedFilter.isNotEmpty,
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
                  child: controller.isProductLoading
                      ? CommonWidget.commonLoading()
                      : controller.productModelFilterList.isEmpty
                      ? CommonWidget.commonEmpty()
                      : RefreshIndicator(
                          onRefresh: () => controller.getProductApi(
                            queryParameters: controller.selectedFilter,
                          ),
                          child: GridView.builder(
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
                                        child: Center(
                                          child: AppImageViewThumb(
                                            imageUrl:
                                                (controller
                                                        .productModelFilterList[index]
                                                        .productColorsImages
                                                        ?.firstOrNull
                                                        ?.images
                                                        ?.isNotEmpty ??
                                                    false)
                                                ? controller
                                                      .productModelFilterList[index]
                                                      .productColorsImages
                                                      ?.first
                                                      .images
                                                      ?.first
                                                : null,
                                          ),
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
                                                      .productModelFilterList[index]
                                                      .productName ??
                                                  "",
                                              maxLines: 1,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            AppText(
                                              text:
                                                  controller
                                                      .productModelFilterList[index]
                                                      .productDescription ??
                                                  "",
                                              fontWeight: FontWeight.w700,
                                              maxLines: 1,
                                              color: Colors.grey,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.toNamed(
                                                        AppRoutes.productDetail,
                                                        arguments: controller
                                                            .productModelFilterList[index]
                                                            .id
                                                            .toString(),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: Color(
                                                          0xFF8EBF1F,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              5,
                                                            ),
                                                      ),
                                                      child: AppText(
                                                        text: "View Details",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                // Container(
                                                //   height: 40,
                                                //   width: 40,
                                                //   decoration: BoxDecoration(
                                                //     borderRadius:
                                                //         BorderRadius.circular(
                                                //           5,
                                                //         ),
                                                //     color: Color(0xFF0067B1),
                                                //   ),
                                                //   child: Image.asset(
                                                //     AppImage.cartIcon,
                                                //     color: Colors.white,
                                                //     scale: 1.5,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: controller.productModelFilterList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
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
