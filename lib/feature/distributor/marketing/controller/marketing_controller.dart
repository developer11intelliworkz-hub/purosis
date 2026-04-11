import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../consts/app_url.dart';
import '../../../../consts/storage_keys.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/api_service.dart';
import '../../../../utils/storage_service.dart';
import '../../../auth/model/User_model.dart';
import '../model/brochures_model.dart';
import '../model/customize_post_model.dart';
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
  List<BrochuresModel> brochuresModelFilterList = [];
  List<PostsModel> postsModelList = [];
  List<PostsModel> postsModelFilterList = [];
  List<ReelsModel> reelsModelList = [];
  List<ReelsModel> reelsModelFilterList = [];
  List<LeafletModel> leafletModelList = [];
  List<LeafletModel> leafletModelFilterList = [];
  List<VideoModel> videoModelList = [];
  List<VideoModel> videoModelFilterList = [];
  UserModel? userModel;

  TextEditingController brochureSearchTEC = TextEditingController();
  TextEditingController postSearchTEC = TextEditingController();
  TextEditingController reelSearchTEC = TextEditingController();
  TextEditingController leafletSearchTEC = TextEditingController();
  TextEditingController videoSearchTEC = TextEditingController();

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
        AppRoutes.customizePostPreviewDistributor,
        arguments: customizePostModel,
      );
    }
  }

  filterBrochure(String query) {
    if (query.isNotEmpty && query.length >= 4) {
      final item = brochuresModelList
          .where(
            (item) =>
                (item.title?.toLowerCase().contains(query.toLowerCase()) ??
                false),
          )
          .toList();
      brochuresModelFilterList = item;
      update();
    }
    if (query.isEmpty) {
      brochuresModelFilterList.clear();
      brochuresModelFilterList.addAll(brochuresModelList);
      update();
    }
  }

  filterPosts(String query) {
    if (query.isNotEmpty && query.length >= 4) {
      final item = postsModelList
          .where(
            (item) =>
                (item.title?.toLowerCase().contains(query.toLowerCase()) ??
                false),
          )
          .toList();
      postsModelFilterList = item;
      update();
    }
    if (query.isEmpty) {
      postsModelFilterList.clear();
      postsModelFilterList.addAll(postsModelList);
      update();
    }
  }

  filterReel(String query) {
    if (query.isNotEmpty && query.length >= 4) {
      final item = reelsModelList
          .where(
            (item) =>
                (item.title?.toLowerCase().contains(query.toLowerCase()) ??
                false),
          )
          .toList();
      reelsModelFilterList = item;
      update();
    }
    if (query.isEmpty) {
      reelsModelFilterList.clear();
      reelsModelFilterList.addAll(reelsModelList);
      update();
    }
  }

  filterLeaflet(String query) {
    if (query.isNotEmpty && query.length >= 4) {
      final item = leafletModelList
          .where(
            (item) =>
                (item.title?.toLowerCase().contains(query.toLowerCase()) ??
                false),
          )
          .toList();
      leafletModelFilterList = item;
      update();
    }
    if (query.isEmpty) {
      leafletModelFilterList.clear();
      leafletModelFilterList.addAll(leafletModelList);
      update();
    }
  }

  filterVideo(String query) {
    if (query.isNotEmpty && query.length >= 4) {
      final item = videoModelList
          .where(
            (item) =>
                (item.title?.toLowerCase().contains(query.toLowerCase()) ??
                false),
          )
          .toList();
      videoModelFilterList = item;
      update();
    }
    if (query.isEmpty) {
      videoModelFilterList.clear();
      videoModelFilterList.addAll(videoModelList);
      update();
    }
  }

  Future<void> getBrochuresApi() async {
    isBrochuresLoading = true;
    update();
    await apiService
        .get(AppUrl.getBrochureUserUrl)
        .then((response) {
          if (response["success"] == true) {
            brochuresModelList.clear();
            brochuresModelFilterList.clear();
            for (final data in response['data']) {
              brochuresModelList.add(BrochuresModel.fromJson(data));
              brochuresModelFilterList.add(BrochuresModel.fromJson(data));
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

  Future<void> getPostsApi() async {
    isPostsLoading = true;
    update();
    await apiService
        .get(AppUrl.getPostUserUrl)
        .then((response) {
          if (response["success"] == true) {
            postsModelList.clear();
            postsModelFilterList.clear();
            for (final data in response['data']) {
              postsModelList.add(PostsModel.fromJson(data));
              postsModelFilterList.add(PostsModel.fromJson(data));
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
    update();
    await apiService
        .get(AppUrl.getReelUserUrl)
        .then((response) {
          if (response["success"] == true) {
            reelsModelList.clear();
            reelsModelFilterList.clear();
            for (final data in response['data']) {
              reelsModelList.add(ReelsModel.fromJson(data));
              reelsModelFilterList.add(ReelsModel.fromJson(data));
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

  Future<void> getLeafletApi() async {
    isLeafletLoading = true;
    update();
    await apiService
        .get(AppUrl.getLeafletUserUrl)
        .then((response) {
          if (response["success"] == true) {
            leafletModelList.clear();
            leafletModelFilterList.clear();
            for (final data in response['data']) {
              leafletModelList.add(LeafletModel.fromJson(data));
              leafletModelFilterList.add(LeafletModel.fromJson(data));
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

  Future<void> getVideoApi() async {
    isVideoLoading = true;
    update();
    await apiService
        .get(AppUrl.getVideosUserUrl)
        .then((response) {
          if (response["success"] == true) {
            videoModelList.clear();
            videoModelFilterList.clear();
            for (final data in response['data']) {
              videoModelList.add(VideoModel.fromJson(data));
              videoModelFilterList.add(VideoModel.fromJson(data));
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
