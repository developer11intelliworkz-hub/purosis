import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/product/controller/product_controller.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  ProductController productController = ProductController();

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
                    Expanded(child: AppSearchField()),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(
                          AppRoutes.filter,
                          arguments: controller.selectedFilter,
                        )?.then((value) {
                          if (value != null) {
                            controller.selectedFilter = value;
                          }
                        });
                      },
                      icon: Icon(Icons.tune),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Expanded(
                  child: controller.isProductLoading
                      ? CommonWidget.commonLoading()
                      : controller.productModelList.isEmpty
                      ? CommonWidget.commonEmpty()
                      : RefreshIndicator(
                          onRefresh: () => controller.getProductApi(),
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
                                      Expanded(child: SizedBox(width: 150)),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText(
                                              text:
                                                  controller
                                                      .productModelList[index]
                                                      .productName ??
                                                  "",
                                              maxLines: 1,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            AppText(
                                              text:
                                                  controller
                                                      .productModelList[index]
                                                      .productDescription ??
                                                  "",
                                              fontWeight: FontWeight.w700,
                                              maxLines: 2,
                                              color: Colors.grey,
                                            ),
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
                              );
                            },
                            itemCount: controller.productModelList.length,
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
