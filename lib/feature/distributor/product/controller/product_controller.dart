import 'dart:convert';

import 'package:get/get.dart';
import 'package:purosis/feature/distributor/product/model/product_detail_model.dart';
import 'package:purosis/feature/distributor/product/model/query/add_to_cart_query.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/utils/api_service.dart';
import 'package:purosis/utils/app_toast.dart';

import '../../../../consts/app_url.dart';
import '../model/product_model.dart';

class ProductController extends GetxController {
  ApiService apiService = ApiService();
  Map<String, dynamic> selectedFilter = {};
  List<ProductModel> productModelList = [];
  ProductDetailModel? productDetailModel;
  bool isProductLoading = false;
  bool isProductDetailLoading = false;
  bool isAddToCartLoading = false;
  int selectedProductIndex = 0;
  int productQuantity = 1;
  bool isBuyNowLoading = false;

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
          if (response["success"] == true) {
            for (final data in response['data']) {
              productModelList.add(ProductModel.fromJson(data));
            }
            isProductLoading = false;
            update();
          }
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
