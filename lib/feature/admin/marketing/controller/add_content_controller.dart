import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/marketing/model/posts_model.dart';
import 'package:purosis/feature/admin/marketing/model/query/add_brochure_query.dart';
import 'package:purosis/feature/admin/marketing/model/query/add_post_query.dart';
import 'package:purosis/feature/admin/marketing/model/query/add_video_query.dart';
import 'package:purosis/feature/admin/marketing/model/reels_model.dart';
import 'package:purosis/feature/admin/marketing/model/video_model.dart';
import 'package:purosis/utils/api_service.dart';
import 'package:purosis/utils/app_toast.dart';
import 'package:purosis/utils/common_api.dart';

import '../../../../consts/app_url.dart';
import '../../../../model/detail_model.dart';
import '../../../../utils/commmon_function.dart';
import '../model/brochures_model.dart';
import '../model/leaflet_model.dart';
import '../model/query/add_leaflet_query.dart';
import '../model/query/add_reel_query.dart';

class AddContentController extends GetxController {
  bool isDataLoading = false;
  ApiService apiService = ApiService();
  TextEditingController titleTEC = TextEditingController();
  TextEditingController descriptionTEC = TextEditingController();
  String? selectedYear;
  String? selectedMonth;
  PlatformFile? selectedFile;
  PlatformFile? selectedMediaFile;
  BrochuresModel? selectedBrochure;
  ReelsModel? selectedReel;
  PostsModel? selectedPost;
  LeafletModel? selectedLeaflet;
  VideoModel? selectedVideo;
  GlobalKey<FormState> validationKey = GlobalKey();
  List<PlatformFile> selectedImages = [];
  ProductsModel? selectedCategory;
  CategoryItem? selectedType;
  String? selectedFileName;
  String? selectedMediaFileName;
  bool isEditLoading = false;

  List<String> yearList = List.generate(
    2040 - 2015 + 1,
    (index) => (2015 + index).toString(),
  );
  List<String> monthList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  void addImages() async {
    final images = await CommonFunction.pickMultipleImages(
      alreadySelected: selectedImages.length,
      maxLimit: 6,
    );
    selectedImages.addAll(images);
    update();
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
    update();
  }

  setEditBrochureValue(BrochuresModel value) async {
    selectedBrochure = value;
    titleTEC.text = value.title ?? "";
    selectedMonth = value.month;
    selectedYear = value.year;
    selectedFileName = value.mediaFile?.split("/").last;
    descriptionTEC.text = value.description ?? "";
    selectedCategory = value.category;
    update();
  }

  setEditPostValue(PostsModel value) async {
    selectedPost = value;
    titleTEC.text = value.title ?? "";
    selectedMonth = value.month;
    selectedYear = value.year;
    selectedFileName = value.mediaFile?.split("/").last;
    descriptionTEC.text = value.description ?? "";
    selectedCategory = value.category;
    update();
  }

  setEditReelValue(ReelsModel value) async {
    selectedReel = value;
    titleTEC.text = value.title ?? "";
    selectedMonth = value.month;
    selectedYear = value.year;
    selectedMediaFileName = value.mediaFile?.split("/").last;
    selectedFileName = value.thumbnailImage?.split("/").last;
    descriptionTEC.text = value.description ?? "";
    selectedCategory = value.category;
    update();
  }

  setEditLeafletValue(LeafletModel value) async {
    isEditLoading = true;
    selectedLeaflet = value;
    titleTEC.text = value.title ?? "";
    selectedMonth = value.month;
    selectedYear = value.year;
    for (final data in value.mediaFile ?? []) {
      selectedImages.add((await CommonFunction.urlToPlatformFile(data ?? "")));
    }
    descriptionTEC.text = value.description ?? "";
    selectedCategory = value.category;
    isEditLoading = false;
    update();
  }

  setEditVideoValue(VideoModel value) async {
    isEditLoading = true;
    selectedVideo = value;
    titleTEC.text = value.title ?? "";
    selectedMonth = value.month;
    selectedYear = value.year;
    selectedMediaFileName = value.mediaFile?.split("/").last;
    selectedFileName = value.thumbnailImage?.split("/").last;
    descriptionTEC.text = value.description ?? "";
    final data = await CommonApi().getDetailApi();
    selectedType = data.videoType?.firstWhere((e) => e.key == value.type);
    selectedCategory = value.category;
    isEditLoading = false;
    update();
  }

  Future<void> addBrochureApi() async {
    isDataLoading = true;
    update();
    AddBrochureQuery addBrochureQuery = AddBrochureQuery(
      id: selectedBrochure?.id,
      title: titleTEC.text,
      category: selectedCategory?.id,
      month: selectedMonth,
      year: selectedYear,
      description: descriptionTEC.text,
      isFeatured: 1,
      mediaFile: selectedFile,
    );
    await apiService
        .postFormData(
          AppUrl.addUpdateBrochureUrl,
          await addBrochureQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error(message: response['message']);
          }
          isDataLoading = false;
          update();
        })
        .catchError((value) {
          isDataLoading = false;
          update();
        });
  }

  Future<void> editBrochureApi() async {
    isDataLoading = true;
    update();
    AddBrochureQuery addBrochureQuery = AddBrochureQuery(
      id: selectedBrochure?.id,
      title: titleTEC.text,
      category: selectedCategory?.id,
      month: selectedMonth,
      year: selectedYear,
      description: descriptionTEC.text,
      isFeatured: 1,
      mediaFile: selectedFile,
    );
    await apiService
        .postFormData(
          AppUrl.addUpdateBrochureUrl,
          await addBrochureQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error(message: response['message']);
          }
          isDataLoading = false;
          update();
        })
        .catchError((value) {
          isDataLoading = false;
          update();
        });
  }

  Future<void> addPostApi() async {
    isDataLoading = true;
    update();
    AddPostQuery addPostQuery = AddPostQuery(
      title: titleTEC.text,
      category: selectedCategory?.id,
      month: selectedMonth,
      year: selectedYear,
      description: descriptionTEC.text,
      isFeatured: 1,
      mediaFile: selectedFile,
    );
    await apiService
        .postFormData(AppUrl.addUpdatePostUrl, await addPostQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error(message: response['message']);
          }
          isDataLoading = false;
          update();
        })
        .catchError((value) {
          isDataLoading = false;
          update();
        });
  }

  Future<void> addLeafletApi() async {
    isDataLoading = true;
    update();
    AddLeafletQuery addLeafletQuery = AddLeafletQuery(
      leafletId: selectedLeaflet?.id,
      title: titleTEC.text,
      category: selectedCategory?.id,
      month: selectedMonth,
      year: selectedYear,
      description: descriptionTEC.text,
      isFeatured: 1,
      mediaFiles: selectedImages,
    );
    await apiService
        .postFormData(
          AppUrl.addUpdateLeafletUrl,
          await addLeafletQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error(message: response['message']);
          }
          isDataLoading = false;
          update();
        })
        .catchError((value) {
          isDataLoading = false;
          update();
        });
  }

  Future<void> editPostApi() async {
    isDataLoading = true;
    update();
    AddPostQuery addPostQuery = AddPostQuery(
      id: selectedPost?.id,
      title: titleTEC.text,
      category: selectedCategory?.id,
      month: selectedMonth,
      year: selectedYear,
      description: descriptionTEC.text,
      isFeatured: 1,
      mediaFile: selectedFile,
    );
    await apiService
        .postFormData(AppUrl.addUpdatePostUrl, await addPostQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error(message: response['message']);
          }
          isDataLoading = false;
          update();
        })
        .catchError((value) {
          isDataLoading = false;
          update();
        });
  }

  Future<void> addReelsApi() async {
    isDataLoading = true;
    update();
    AddReelQuery addReelQuery = AddReelQuery(
      title: titleTEC.text,
      category: selectedCategory?.id,
      month: selectedMonth,
      year: selectedYear,
      description: descriptionTEC.text,
      isFeatured: 1,
      mediaFile: selectedMediaFile,
      thumbnailImage: selectedFile,
    );
    await apiService
        .postFormData(AppUrl.addUpdateReelUrl, await addReelQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error(message: response['message']);
          }
          isDataLoading = false;
          update();
        })
        .catchError((value) {
          isDataLoading = false;
          update();
        });
  }

  Future<void> editReelsApi() async {
    isDataLoading = true;
    update();
    AddReelQuery addReelQuery = AddReelQuery(
      id: selectedReel?.id,
      title: titleTEC.text,
      category: selectedCategory?.id,
      month: selectedMonth,
      year: selectedYear,
      description: descriptionTEC.text,
      isFeatured: 1,
      mediaFile: selectedMediaFile,
      thumbnailImage: selectedFile,
    );
    await apiService
        .postFormData(AppUrl.addUpdateReelUrl, await addReelQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error(message: response['message']);
          }
          isDataLoading = false;
          update();
        })
        .catchError((value) {
          isDataLoading = false;
          update();
        });
  }

  Future<void> addVideoApi() async {
    isDataLoading = true;
    update();
    AddVideoQuery addVideoQuery = AddVideoQuery(
      videoId: selectedVideo?.id,
      title: titleTEC.text,
      category: selectedCategory?.id,
      type: selectedType?.key,
      month: selectedMonth,
      year: selectedYear,
      description: descriptionTEC.text,
      isFeatured: 1,
      mediaFile: selectedMediaFile,
      thumbnailImage: selectedFile,
    );
    await apiService
        .postFormData(
          AppUrl.addUpdateVideoUrl,
          await addVideoQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error(message: response['message']);
          }
          isDataLoading = false;
          update();
        })
        .catchError((value) {
          isDataLoading = false;
          update();
        });
  }

  Future<void> editVideoApi() async {
    isDataLoading = true;
    update();
    AddVideoQuery addVideoQuery = AddVideoQuery(
      videoId: selectedVideo?.id,
      title: titleTEC.text,
      category: selectedCategory?.id,
      type: selectedType?.key,
      month: selectedMonth,
      year: selectedYear,
      description: descriptionTEC.text,
      isFeatured: 1,
      mediaFile: selectedMediaFile,
      thumbnailImage: selectedFile,
    );
    await apiService
        .postFormData(
          AppUrl.addUpdateVideoUrl,
          await addVideoQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error(message: response['message']);
          }
          isDataLoading = false;
          update();
        })
        .catchError((value) {
          isDataLoading = false;
          update();
        });
  }
}
