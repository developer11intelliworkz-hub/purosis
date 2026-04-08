import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/dealer/marketing/model/customize_post_model.dart';

import '../../../../consts/app_url.dart';
import '../../../../consts/storage_keys.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/api_service.dart';
import '../../../../utils/storage_service.dart';
import '../../../auth/model/User_model.dart';
import '../model/brochures_model.dart';
import '../model/leaflet_model.dart';
import '../model/posts_model.dart';
import '../model/reels_model.dart';
import '../model/video_model.dart';

class MarketingController extends GetxController {
  ApiService apiService = ApiService();
  final storage = Get.find<StorageService>();
  bool isBrochuresLoading = false;
  bool isPostsLoading = false;
  bool isReelsLoading = false;
  bool isVideoLoading = false;
  bool isLeafletLoading = false;
  List<BrochuresModel> brochuresModelList = [];
  List<PostsModel> postsModelList = [];
  List<ReelsModel> reelsModelList = [];
  List<LeafletModel> leafletModelList = [];
  List<VideoModel> videoModelList = [];
  Map<String, dynamic>? filterPostSelectedValue = {};
  Map<String, dynamic>? filterReelSelectedValue = {};
  Map<String, dynamic>? filterVideoSelectedValue = {};
  Map<String, dynamic>? filterLeafletsSelectedValue = {};
  Map<String, dynamic>? filterBrochuresSelectedValue = {};
  UserModel? userModel;
  TextEditingController addressTEC = TextEditingController();
  TextEditingController mailTEC = TextEditingController();
  TextEditingController callTEC = TextEditingController();
  TextEditingController whatsAppTEC = TextEditingController();
  GlobalKey<FormState> validationKey = GlobalKey<FormState>();

  fetchProfileData() {
    userModel = UserModel.fromJson(storage.read(StorageKeys.userData));
  }

  submitToPreview(String url) {
    if (validationKey.currentState?.validate() ?? false) {
      CustomizePostModel customizePostModel = CustomizePostModel(
        imageUrl: url,
        address: addressTEC.text,
        call: callTEC.text,
        mail: mailTEC.text,
        whatsapp: whatsAppTEC.text,
        logoUrl: userModel?.logo,
      );
      Get.toNamed(
        AppRoutes.customizePostPreview,
        arguments: customizePostModel,
      );
    }
  }

  Future<void> getBrochuresApi({Map<String, dynamic>? queryParameters}) async {
    isBrochuresLoading = true;
    update();
    await apiService
        .get(
          AppUrl.getBrochureUserUrl,
          queryParameters: {"filter": jsonEncode(queryParameters)},
        )
        .then((response) {
          brochuresModelList.clear();
          if (response["success"] == true) {
            for (final data in response['data']) {
              brochuresModelList.add(BrochuresModel.fromJson(data));
            }
          }
          isBrochuresLoading = false;
          update();
        })
        .catchError((value) {
          isBrochuresLoading = false;
          update();
        });
  }

  Future<void> getPostsApi({Map<String, dynamic>? queryParameters}) async {
    isPostsLoading = true;
    update();
    await apiService
        .get(
          AppUrl.getPostUserUrl,
          queryParameters: {"filter": jsonEncode(queryParameters)},
        )
        .then((response) {
          postsModelList.clear();
          if (response["success"] == true) {
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

  Future<void> getReelApi({Map<String, dynamic>? queryParameters}) async {
    isReelsLoading = true;
    update();
    await apiService
        .get(
          AppUrl.getReelUserUrl,
          queryParameters: {"filter": jsonEncode(queryParameters)},
        )
        .then((response) {
          reelsModelList.clear();
          if (response["success"] == true) {
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

  Future<void> getLeafletApi({Map<String, dynamic>? queryParameters}) async {
    isLeafletLoading = true;
    update();
    await apiService
        .get(
          AppUrl.getLeafletUserUrl,
          queryParameters: {"filter": jsonEncode(queryParameters)},
        )
        .then((response) {
          leafletModelList.clear();
          if (response["success"] == true) {
            for (final data in response['data']) {
              leafletModelList.add(LeafletModel.fromJson(data));
            }
          }
          isLeafletLoading = false;
          update();
        })
        .catchError((value) {
          isLeafletLoading = false;
          update();
        });
  }

  Future<void> getVideoApi({Map<String, dynamic>? queryParameters}) async {
    isVideoLoading = true;
    update();
    await apiService
        .get(
          AppUrl.getVideoUrl,
          queryParameters: {"filter": jsonEncode(queryParameters)},
        )
        .then((response) {
          videoModelList.clear();
          if (response["success"] == true) {
            for (final data in response['data']) {
              videoModelList.add(VideoModel.fromJson(data));
            }
          }
          isVideoLoading = false;
          update();
        })
        .catchError((value) {
          isVideoLoading = false;
          update();
        });
  }
}
