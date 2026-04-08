import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/distributor/dashboard/view/dashboard_view.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../../marketing/model/posts_model.dart';
import '../../marketing/model/reels_model.dart';
import '../../marketing/view/marketing_assets_view.dart';
import '../../product/model/product_model.dart';
import '../../product/view/product_view.dart';
import '../../profile/view/profile_view.dart';
import '../model/dashboard_data_model.dart';

class DashboardController extends GetxController {
  final ApiService apiService = ApiService();
  List<String> screenNameList = [
    "Dashboard",
    "Products",
    "Marketing Assets",
    "Profile",
  ];
  List<Widget> distributorList = [
    DashboardView(),
    ProductView(),
    MarketingAssetsView(),
    ProfileView(),
  ];
  List<PostsModel> postsModelList = [];
  List<ReelsModel> reelsModelList = [];
  List<ProductModel> productModelList = [];
  DashboardDataModel? dashboardDataModel;

  int selectedIndex = 0;
  bool isPostsLoading = false;
  bool isReelsLoading = false;
  bool isProductDetailLoading = false;
  bool isProductLoading = false;
  bool isDashboardDataLoading = false;
  int bannerCurrentIndex = 0;

  Future<void> getDashboardDataApi() async {
    isDashboardDataLoading = true;
    // update();
    await apiService
        .get(AppUrl.getBannersUrl, queryParameters: {"type": "distributor"})
        .then((response) {
          if (response["success"] == true) {
            dashboardDataModel = DashboardDataModel.fromJson(response['data']);
          }
          isDashboardDataLoading = false;
          update();
        })
        .catchError((value) {
          isDashboardDataLoading = false;
          update();
        });
  }

  Future<void> getPostsApi() async {
    isPostsLoading = true;
    // update();
    await apiService
        .get(AppUrl.getPostUserUrl)
        .then((response) {
          if (response["success"] == true) {
            postsModelList.clear();
            for (final data in response['data']) {
              postsModelList.add(PostsModel.fromJson(data));
            }
          }
          isPostsLoading = false;
          update();
        })
        .catchError((value) {
          isPostsLoading = false;
          update();
        });
  }

  Future<void> getReelApi() async {
    isReelsLoading = true;
    // update();
    await apiService
        .get(AppUrl.getReelUserUrl)
        .then((response) {
          if (response["success"] == true) {
            reelsModelList.clear();
            for (final data in response['data']) {
              reelsModelList.add(ReelsModel.fromJson(data));
            }
          }
          isReelsLoading = false;
          update();
        })
        .catchError((value) {
          isReelsLoading = false;
          update();
        });
  }

  Future<List<ProductModel>> getProductApi({
    Map<String, dynamic>? queryParameters,
  }) async {
    isProductLoading = true;
    // update();
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
}
