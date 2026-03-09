import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/marketing/model/query/add_brochure_query.dart';
import 'package:purosis/feature/admin/marketing/model/query/add_video_query.dart';
import 'package:purosis/feature/admin/marketing/model/video_model.dart';
import 'package:purosis/utils/api_service.dart';
import 'package:purosis/utils/app_toast.dart';

import '../../../../consts/app_url.dart';
import '../../../../utils/commmon_function.dart';
import '../model/brochures_model.dart';
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
  VideoModel? selectedVideo;
  GlobalKey<FormState> validationKey = GlobalKey();
  List<PlatformFile> selectedImages = [];

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

  setEditBrochureValue(BrochuresModel value) {
    titleTEC.text = value.title ?? "";
    selectedMonth = value.month;
    selectedYear = value.year;
    descriptionTEC.text = value.description ?? "";
  }

  Future<void> addBrochureApi() async {
    isDataLoading = true;
    update();
    AddBrochureQuery addBrochureQuery = AddBrochureQuery(
      title: titleTEC.text,
      category: "brochure1",
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
            Get.back();
            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          isDataLoading = false;
          update();
        })
        .catchError((value) {
          isDataLoading = false;
          update();
        });
  }

  Future<void> updateBrochureApi() async {
    isDataLoading = true;
    update();
    AddBrochureQuery addBrochureQuery = AddBrochureQuery(
      id: selectedBrochure?.id,
      title: titleTEC.text,
      category: "brochure1",
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
            AppToast.error();
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
    AddBrochureQuery addBrochureQuery = AddBrochureQuery(
      id: selectedBrochure?.id,
      title: titleTEC.text,
      category: "post1",
      month: selectedMonth,
      year: selectedYear,
      description: descriptionTEC.text,
      isFeatured: 1,
      mediaFile: selectedFile,
    );
    await apiService
        .postFormData(
          AppUrl.addUpdatePostUrl,
          await addBrochureQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error();
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
      // id: selectedBrochure?.id,
      title: titleTEC.text,
      category: "reel1",
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
            AppToast.error();
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
      category: "videocat1",
      type: "videotype1",
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
            AppToast.error();
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
