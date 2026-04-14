import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/routes/app_routes.dart';

import '../../../../utils/commmon_function.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/common_widget.dart';
import '../controller/product_controller.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final ProductController productController = Get.find();
  final String productId = Get.arguments;

  @override
  void initState() {
    productController.getProductDetailApi(productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: productController,
      builder: (controller) {
        return Scaffold(
          appBar: CommonWidget.appAppBar(
            title: "Product Detail",
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.editProduct,
                    arguments: controller.productDetailModel,
                  )?.then((value) {
                    productController.getProductDetailApi(
                      productId,
                      isUpdate: true,
                    );
                  });
                },
                icon: Icon(Icons.edit, color: Colors.grey),
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(Icons.delete, color: Colors.grey),
              // ),
            ],
          ),
          body: controller.isProductDetailLoading
              ? CommonWidget.commonLoading()
              : controller.productDetailModel == null
              ? CommonWidget.commonEmpty()
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 300,
                          viewportFraction: 1,
                          enableInfiniteScroll: false,
                        ),
                        items:
                            controller
                                .productDetailModel
                                ?.productColorsImages?[controller
                                    .selectedProductIndex]
                                .images
                                ?.map((image) {
                                  return Image.network(
                                    image,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  );
                                })
                                .toList() ??
                            [],
                      ),
                      AppText(
                        text: controller.productDetailModel?.productName ?? "",
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                      AppText(
                        text: "Experience the purity in every drop.",
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      AppText(
                        text:
                            controller
                                .productDetailModel
                                ?.productColorsImages?[controller
                                    .selectedProductIndex]
                                .colorName ??
                            "",
                      ),
                      SizedBox(
                        height: 50,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                controller.selectedProductIndex = index;
                                controller.update();
                              },
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      controller.selectedProductIndex == index
                                      ? Border.all(color: Colors.black)
                                      : Border.all(color: Colors.grey),
                                  color: Colors.white,
                                ),
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CommonFunction.hexToColor(
                                      controller
                                              .productDetailModel
                                              ?.productColorsImages?[index]
                                              .colorCode ??
                                          "#000000",
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(width: 5),
                          itemCount:
                              controller
                                  .productDetailModel
                                  ?.productColorsImages
                                  ?.length ??
                              0,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(text: "Quantity :"),
                              SizedBox(width: 5),
                              AppText(
                                text:
                                    "${controller.productDetailModel?.unitsPerBox ?? 0} units in 1 Box",
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            controller.productDetailModel?.specifications
                                ?.map(
                                  (e) => Row(
                                    children: [
                                      AppText(
                                        text: "• ",
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                      ),
                                      Expanded(
                                        child: AppText(
                                          text: e,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList() ??
                            [],
                      ),
                      Divider(),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: AppText(text: "Net Weight :"),
                          ),
                          Expanded(
                            flex: 3,
                            child: AppText(
                              text:
                                  "${controller.productDetailModel?.weightPerBox ?? 0} KG(Approx)",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: AppText(text: "Product Type :"),
                          ),
                          Expanded(
                            flex: 3,
                            child: AppText(
                              text:
                                  controller
                                      .productDetailModel
                                      ?.category
                                      ?.categoryName ??
                                  '',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: AppText(text: "Gross Weight :"),
                          ),
                          Expanded(
                            flex: 3,
                            child: AppText(text: "10.50 KG(Approx.)"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
