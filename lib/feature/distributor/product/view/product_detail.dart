import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/feature/distributor/product/controller/product_controller.dart';
import 'package:purosis/utils/commmon_function.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_button_outline.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late ProductController productController;
  final String productId = Get.arguments;

  @override
  void initState() {
    if (Get.isRegistered<ProductController>()) {
      productController = Get.find();
    } else {
      productController = ProductController();
    }
    productController.getProductDetailApi(productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: productController,
      builder: (controller) {
        return Scaffold(
          appBar: CommonWidget.appAppBar(title: "Product Detail"),
          body: controller.isProductDetailLoading
              ? CommonWidget.commonLoading()
              : controller.productDetailModel == null
              ? CommonWidget.commonEmpty()
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
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
                              text:
                                  controller.productDetailModel?.productName ??
                                  "",
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
                                            controller.selectedProductIndex ==
                                                index
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
                                separatorBuilder:
                                    (BuildContext context, int index) =>
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
                                AppText(text: "Quantity:"),
                                SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 170,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              controller.decreaseQuantity();
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  bottomLeft: Radius.circular(
                                                    8,
                                                  ),
                                                ),
                                                color: Color(0xFFCAE6FB),
                                              ),
                                              child: Icon(Icons.remove),
                                            ),
                                          ),
                                          Expanded(
                                            child: AppText(
                                              text: controller.productQuantity
                                                  .toString(),
                                              align: TextAlign.center,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.increaseQuantity();
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(8),
                                                  bottomRight: Radius.circular(
                                                    8,
                                                  ),
                                                ),
                                                color: Color(0xFFCAE6FB),
                                              ),
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    AppText(
                                      text:
                                          "${controller.productDetailModel?.unitsPerBox ?? 0} units in 1 Box",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (controller
                                    .productDetailModel
                                    ?.specifications
                                    ?.isNotEmpty ??
                                false)
                              Column(
                                children: [
                                  SizedBox(height: 5),
                                  Divider(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:
                                        controller
                                            .productDetailModel
                                            ?.specifications
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                            .toList() ??
                                        [],
                                  ),
                                  Divider(),
                                ],
                              ),
                            SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(text: "Net Weight : "),
                                Expanded(
                                  child: AppText(
                                    text:
                                        "${controller.productDetailModel?.weightPerBox ?? 0} KG(Approx)",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(text: "Product Type : "),
                                Expanded(
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
                            // SizedBox(height: 5),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       flex: 1,
                            //       child: AppText(text: "Gross Weight :"),
                            //     ),
                            //     Expanded(
                            //       flex: 3,
                            //       child: AppText(text: "10.50 KG(Approx.)"),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: 20),
                            AppText(
                              text: "Description",
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0067B1),
                            ),
                            SizedBox(height: 5),
                            AppText(
                              text:
                                  controller
                                      .productDetailModel
                                      ?.productDescription ??
                                  '',
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          controller.isAddWishlistLoading
                              ? SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: CommonWidget.commonLoading(),
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    controller.addProductWishlistApi(
                                      productId,
                                      (controller
                                                  .productDetailModel
                                                  ?.isWishlisted ??
                                              false)
                                          ? 0
                                          : 1,
                                    );
                                  },
                                  icon:
                                      (controller
                                              .productDetailModel
                                              ?.isWishlisted ??
                                          false)
                                      ? Icon(Icons.favorite, color: Colors.red)
                                      : Icon(Icons.favorite_border),
                                ),
                          Spacer(),
                          SizedBox(
                            width: 100,
                            height: 40,
                            child: AppButtonOutline(
                              text: "Buy Now",
                              color: Color(0xFF8EBF1F),
                              isLoading: controller.isBuyNowLoading,
                              onPressed: () {
                                controller.buyNowApi();
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 140,
                            height: 40,
                            child: AppButton(
                              text: "Add to cart",
                              prefixIcon: Image.asset(
                                AppImage.cart2Icon,
                                color: Colors.white,
                              ),
                              color: Color(0xFF8EBF1F),
                              isLoading: controller.isAddToCartLoading,
                              onPressed: () {
                                controller.addToCartApi();
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
