import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/product/controller/product_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_image_view.dart';
import 'package:purosis/widget/common_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';

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
                        controller: controller.productSearchTEC,
                        onChanged: controller.filterProduct,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Badge(
                      smallSize: 8,
                      isLabelVisible: controller.selectedFilter.isNotEmpty,
                      backgroundColor: Colors.red,
                      child: InkWell(
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
                            Icon(Icons.tune),
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
                            padding: EdgeInsets.only(bottom: 20.h, top: 2.h),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.productDetailView,
                                    arguments: controller
                                        .productModelFilterList[index]
                                        .id
                                        .toString(),
                                  );
                                },
                                child: Card(
                                  color: Colors.white,
                                  clipBehavior: Clip.antiAlias,
                                  child: SizedBox(
                                    // color: Colors.red,
                                    width: 20.h,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: AppImageView(
                                            // height: 17.h,
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
                                            fit: BoxFit.cover,
                                            width: double.infinity,
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
                                              SizedBox(height: 0.5.h),
                                              AppText(
                                                text:
                                                    controller
                                                        .productModelFilterList[index]
                                                        .productDescription ??
                                                    "",
                                                fontWeight: FontWeight.w700,
                                                maxLines: 2,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(height: 0.5.h),

                                              Container(
                                                height: 40,
                                                width: double.maxFinite,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF8EBF1F),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: AppText(
                                                  text: "View Details",
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF0067B1),
        onPressed: () {
          Get.toNamed(AppRoutes.addProduct)?.then((value) {
            if (value == true) {
              productController.getProductApi();
            }
          });
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
