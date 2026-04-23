import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/distributor/product/model/product_detail_model.dart';
import 'package:purosis/feature/distributor/product/model/query/add_to_cart_query.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/utils/api_service.dart';
import 'package:purosis/utils/app_toast.dart';

import '../../../../consts/app_url.dart';
import '../model/product_model.dart';
import '../model/query/add_delete_wishlist_query.dart';

class ProductController extends GetxController {
  ApiService apiService = ApiService();
  Map<String, dynamic> selectedFilter = {};
  List<ProductModel> productModelList = [];
  List<ProductModel> productModelFilterList = [];
  ProductDetailModel? productDetailModel;
  bool isProductLoading = false;
  bool isProductDetailLoading = false;
  bool isAddWishlistLoading = false;
  bool isAddToCartLoading = false;
  int selectedProductIndex = 0;
  int productQuantity = 1;
  bool isBuyNowLoading = false;

  TextEditingController searchTEC = TextEditingController();

  increaseQuantity() {
    if (productQuantity < 100) {
      productQuantity += 1;
      update();
    }
  }

  decreaseQuantity() {
    if (productQuantity > 1) {
      productQuantity -= 1;
      update();
    }
  }

  filterProduct(String query) {
    if (query.isNotEmpty && query.length >= 4) {
      final item = productModelList
          .where(
            (item) =>
                (item.productName?.toLowerCase().contains(
                  query.toLowerCase(),
                ) ??
                false),
          )
          .toList();
      productModelFilterList = item;
      update();
    }
    if (query.isEmpty) {
      productModelFilterList.clear();
      productModelFilterList.addAll(productModelList);
      update();
    }
  }

  Future<List<ProductModel>> getProductApi({
    Map<String, dynamic>? queryParameters,
  }) async {
    isProductLoading = true;
    update();
    await apiService
        .get(
          AppUrl.getProductsUserUrl,
          queryParameters: {"filter": jsonEncode(queryParameters)},
        )
        .then((response) {
          productModelList.clear();
          productModelFilterList.clear();
          if (response["success"] == true) {
            for (final data in response['data']) {
              productModelList.add(ProductModel.fromJson(data));
              productModelFilterList.add(ProductModel.fromJson(data));
            }
          }
          isProductLoading = false;
          update();
        })
        .catchError((value) {
          isProductLoading = false;
          update();
        });
    return productModelList;
  }

  Future<void> getProductDetailApi(String productId) async {
    isProductDetailLoading = true;
    // update();
    await apiService
        .get(
          AppUrl.getProductsUserUrl,
          queryParameters: {"product_id": productId},
        )
        .then((response) {
          if (response["success"] == true) {
            for (final data in response['data']) {
              productDetailModel = ProductDetailModel.fromJson(data);
            }
            isProductDetailLoading = false;
            update();
          }
        })
        .catchError((value) {
          isProductDetailLoading = false;
          update();
        });
  }

  Future<void> addProductWishlistApi(
    String? productId,
    int? addOrDelete,
  ) async {
    isAddWishlistLoading = true;
    update();
    AddDeleteWishlistQuery addDeleteWishlistQuery = AddDeleteWishlistQuery(
      productId: productId,
      addOrDelete: addOrDelete,
    );
    await apiService
        .postFormData(
          AppUrl.addDeleteWishlistUrl,
          addDeleteWishlistQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            productDetailModel?.isWishlisted = addOrDelete == 1 ? true : false;
          }
          isAddWishlistLoading = false;
          update();
        })
        .catchError((value) {
          isAddWishlistLoading = false;
          update();
        });
  }

  Future<void> buyNowApi() async {
    isBuyNowLoading = true;
    update();
    AddToCartQuery addToCartQuery = AddToCartQuery(
      colorId: productDetailModel
          ?.productColorsImages?[selectedProductIndex]
          .colorId,
      productId: productDetailModel?.id,
      qty: productQuantity,
    );
    await apiService
        .postFormData(AppUrl.addToCartUrl, addToCartQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            isBuyNowLoading = false;
            Get.toNamed(AppRoutes.cartView);
            update();
          }
        })
        .catchError((value) {
          isBuyNowLoading = false;
          update();
        });
  }

  Future<void> addToCartApi() async {
    isAddToCartLoading = true;
    update();
    AddToCartQuery addToCartQuery = AddToCartQuery(
      colorId: productDetailModel
          ?.productColorsImages?[selectedProductIndex]
          .colorId,
      productId: productDetailModel?.id,
      qty: productQuantity,
    );
    await apiService
        .postFormData(AppUrl.addToCartUrl, addToCartQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            isAddToCartLoading = false;

            Get.back();
            AppToast.success(response["message"]);
          }
        })
        .catchError((value) {
          isAddToCartLoading = false;
          update();
        });
  }
}
