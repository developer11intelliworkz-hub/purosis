import 'dart:convert';

import 'package:get/get.dart';
import 'package:purosis/feature/admin/product/model/product_detail_model.dart';
import 'package:purosis/feature/admin/product/model/product_model.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../model/product_categories.dart';
import '../model/query/sub_category_query.dart';
import '../model/sub_category_model.dart';

class ProductController extends GetxController {
  final ApiService apiService = ApiService();
  bool productCategoriesLoading = false;
  ProductCategories? selectedProductCategories;
  SubCategoryModel? selectedSubCategoryModel;
  Map<String, dynamic> selectedFilter = {};
  List<ProductModel> productModelList = [];
  bool isProductLoading = false;
  bool isProductDetailLoading = false;
  ProductDetailModel? productDetailModel;
  int selectedProductIndex = 0;

  Future<List<ProductModel>> getProductApi({
    Map<String, dynamic>? queryParameters,
  }) async {
    isProductLoading = true;
    update();
    await apiService
        .get(
          AppUrl.getProductsUrl,
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
    await apiService
        .get(AppUrl.getProductsUrl, queryParameters: {"product_id": productId})
        .then((response) async {
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

  Future<List<ProductCategories>> productCategoriesApi() async {
    productCategoriesLoading = true;
    update();
    List<ProductCategories> productCategoriesList = [];
    await apiService
        .get(AppUrl.productCategoriesUrl)
        .then((response) {
          if (response["success"] == true) {
            for (final data in response['data']) {
              productCategoriesList.add(ProductCategories.fromJson(data));
            }
            productCategoriesLoading = false;
            update();
          }
        })
        .catchError((value) {
          productCategoriesLoading = false;
          update();
        });
    return productCategoriesList;
  }

  Future<List<SubCategoryModel>> productSubCategoriesApi() async {
    productCategoriesLoading = true;
    update();
    List<SubCategoryModel> productSubCategoriesList = [];
    await apiService
        .get(
          AppUrl.productSubCategoriesUrl,
          queryParameters: SubCategoryQuery(
            categoryId: selectedProductCategories?.id,
          ).toJson(),
        )
        .then((response) {
          if (response["success"] == true) {
            for (final data in response['data']) {
              productSubCategoriesList.add(SubCategoryModel.fromJson(data));
            }

            productCategoriesLoading = false;
            update();
          }
        })
        .catchError((value) {
          productCategoriesLoading = false;
          update();
        });
    return productSubCategoriesList;
  }
}
