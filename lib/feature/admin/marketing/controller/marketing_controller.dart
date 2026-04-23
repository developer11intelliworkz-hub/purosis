import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../model/brochures_model.dart';
import '../model/leaflet_model.dart';
import '../model/posts_model.dart';
import '../model/query/delete_content_query.dart';
import '../model/reels_model.dart';
import '../model/video_model.dart';

class MarketingController extends GetxController {
  ApiService apiService = ApiService();
  bool isBrochuresLoading = false;
  bool isPostsLoading = false;
  bool isReelsLoading = false;
  bool isVideoLoading = false;
  bool isLeafletLoading = false;
  RxBool isBrochuresDeleteLoading = false.obs;
  RxBool isPostDeleteLoading = false.obs;
  RxBool isReelDeleteLoading = false.obs;
  RxBool isLeafletDeleteLoading = false.obs;
  RxBool isVideoDeleteLoading = false.obs;
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

  TextEditingController brochureSearchTEC = TextEditingController();
  TextEditingController postSearchTEC = TextEditingController();
  TextEditingController reelSearchTEC = TextEditingController();
  TextEditingController leafletSearchTEC = TextEditingController();
  TextEditingController videoSearchTEC = TextEditingController();

  Map<String, dynamic>? filterBrochuresSelectedValue = {};
  Map<String, dynamic>? filterReelSelectedValue = {};
  Map<String, dynamic>? filterVideoSelectedValue = {};
  Map<String, dynamic>? filterLeafletsSelectedValue = {};
  Map<String, dynamic>? filterPostSelectedValue = {};

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

  Future<void> getBrochuresApi({Map<String, dynamic>? queryParameters}) async {
    isBrochuresLoading = true;
    update();
    await apiService
        .get(
          AppUrl.getBrochuresUrl,
          queryParameters: {"filter": jsonEncode(queryParameters)},
        )
        .then((response) {
          brochuresModelList.clear();
          brochuresModelFilterList.clear();
          if (response["success"] == true) {
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

  Future<void> deleteBrochuresApi(int? deleteId) async {
    isBrochuresDeleteLoading.value = true;
    update();
    DeleteContentQuery deleteContentQuery = DeleteContentQuery(
      brochureId: deleteId,
    );
    await apiService
        .postFormData(
          AppUrl.deleteBrochuresUrl,
          deleteContentQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            brochuresModelList.removeWhere((e) => e.id == deleteId);
            brochuresModelFilterList.removeWhere((e) => e.id == deleteId);
          }
          isBrochuresDeleteLoading.value = false;
          update();
        })
        .catchError((value) {
          isBrochuresDeleteLoading.value = false;
          update();
        });
  }

  Future<void> getPostsApi({Map<String, dynamic>? queryParameters}) async {
    isPostsLoading = true;
    update();
    await apiService
        .get(
          AppUrl.getPostUrl,
          queryParameters: {"filter": jsonEncode(queryParameters)},
        )
        .then((response) {
          postsModelList.clear();
          postsModelFilterList.clear();
          if (response["success"] == true) {
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

  Future<void> deletePostApi(int? deleteId) async {
    isPostDeleteLoading.value = true;
    update();
    DeleteContentQuery deleteContentQuery = DeleteContentQuery(
      postId: deleteId,
    );
    await apiService
        .postFormData(AppUrl.deletePostUrl, deleteContentQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            postsModelList.removeWhere((e) => e.id == deleteId);
            postsModelFilterList.removeWhere((e) => e.id == deleteId);
          }
          isPostDeleteLoading.value = false;
          update();
        })
        .catchError((value) {
          isPostDeleteLoading.value = false;
          update();
        });
  }

  Future<void> getReelApi({Map<String, dynamic>? queryParameters}) async {
    isReelsLoading = true;
    update();
    await apiService
        .get(
          AppUrl.getReelsUrl,
          queryParameters: {"filter": jsonEncode(queryParameters)},
        )
        .then((response) {
          reelsModelList.clear();
          reelsModelFilterList.clear();
          if (response["success"] == true) {
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

  Future<void> deleteReelApi(int? deleteId) async {
    isReelDeleteLoading.value = true;
    update();
    DeleteContentQuery deleteContentQuery = DeleteContentQuery(
      reelId: deleteId,
    );
    await apiService
        .postFormData(AppUrl.deleteReelUrl, deleteContentQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            reelsModelList.removeWhere((e) => e.id == deleteId);
            reelsModelFilterList.removeWhere((e) => e.id == deleteId);
          }
          isReelDeleteLoading.value = false;
          update();
        })
        .catchError((value) {
          isReelDeleteLoading.value = false;
          update();
        });
  }

  Future<void> getLeafletApi({Map<String, dynamic>? queryParameters}) async {
    isLeafletLoading = true;
    update();
    await apiService
        .get(
          AppUrl.getLeafletsUrl,
          queryParameters: {"filter": jsonEncode(queryParameters)},
        )
        .then((response) {
          leafletModelList.clear();
          leafletModelFilterList.clear();
          if (response["success"] == true) {
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

  Future<void> deleteLeafletApi(int? deleteId) async {
    isLeafletDeleteLoading.value = true;
    update();
    DeleteContentQuery deleteContentQuery = DeleteContentQuery(
      leafletId: deleteId,
    );
    await apiService
        .postFormData(AppUrl.deleteLeafletUrl, deleteContentQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            leafletModelList.removeWhere((e) => e.id == deleteId);
            leafletModelFilterList.removeWhere((e) => e.id == deleteId);
          }
          isLeafletDeleteLoading.value = false;
          update();
        })
        .catchError((value) {
          isLeafletDeleteLoading.value = false;
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
          videoModelFilterList.clear();
          if (response["success"] == true) {
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

  Future<void> deleteVideoApi(int? deleteId) async {
    isVideoDeleteLoading.value = true;
    update();
    DeleteContentQuery deleteContentQuery = DeleteContentQuery(
      videoId: deleteId,
    );
    await apiService
        .postFormData(AppUrl.deleteVideoUrl, deleteContentQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            videoModelList.removeWhere((e) => e.id == deleteId);
            videoModelFilterList.removeWhere((e) => e.id == deleteId);
          }
          isVideoDeleteLoading.value = false;
          update();
        })
        .catchError((value) {
          isVideoDeleteLoading.value = false;
          update();
        });
  }
}
