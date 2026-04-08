import 'package:get/get.dart';

import '../../../../consts/app_url.dart';
import '../../../../utils/api_service.dart';
import '../model/brochures_model.dart';
import '../model/leaflet_model.dart';
import '../model/posts_model.dart';
import '../model/reels_model.dart';
import '../model/video_model.dart';

class MarketingController extends GetxController {
  ApiService apiService = ApiService();
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

  Future<void> getBrochuresApi() async {
    isBrochuresLoading = true;
    update();
    await apiService
        .get(AppUrl.getBrochureUserUrl)
        .then((response) {
          if (response["success"] == true) {
            brochuresModelList.clear();
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

  Future<void> getPostsApi() async {
    isPostsLoading = true;
    update();
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
    update();
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

  Future<void> getLeafletApi() async {
    isLeafletLoading = true;
    update();
    await apiService
        .get(AppUrl.getLeafletUserUrl)
        .then((response) {
          if (response["success"] == true) {
            leafletModelList.clear();
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

  Future<void> getVideoApi() async {
    isVideoLoading = true;
    update();
    await apiService
        .get(AppUrl.getVideosUserUrl)
        .then((response) {
          if (response["success"] == true) {
            videoModelList.clear();
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
