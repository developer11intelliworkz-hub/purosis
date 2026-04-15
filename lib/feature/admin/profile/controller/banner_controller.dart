import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/profile/model/banner_model.dart';
import 'package:purosis/utils/api_service.dart';
import 'package:purosis/utils/app_toast.dart';

import '../../../../consts/app_url.dart';
import '../model/query/add_banner_query.dart';
import '../model/query/delete_banner_query.dart';

class BannerController extends GetxController {
  final ApiService apiService = ApiService();
  File? selectedFile;
  bool isBannerAddLoading = false;
  bool isBannerLoading = false;
  bool isBannerDeleteLoading = false;
  String? selectedOfferFor;
  List<BannerModel> bannerModelList = [];
  int? selectedId;
  GlobalKey<FormState> validationKey = GlobalKey<FormState>();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
      allowMultiple: false,
    );
    if (result != null) {
      selectedFile = File(result.files.first.path ?? "");
      update();
    }
  }

  clearData() {
    selectedFile = null;
    selectedOfferFor = null;
  }

  Future<void> addBannerApi() async {
    isBannerAddLoading = true;
    update();
    AddBannerQuery addBannerQuery = AddBannerQuery(
      image: selectedFile,
      type: selectedOfferFor?.toLowerCase(),
    );
    await apiService
        .postFormData(AppUrl.addUpdateBannerUrl, addBannerQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.success(response['message']);
          }
          isBannerAddLoading = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isBannerAddLoading = false;
          update();
        });
  }

  Future<void> editBannerApi(int? id) async {
    isBannerAddLoading = true;
    update();
    AddBannerQuery addBannerQuery = AddBannerQuery(
      id: id,
      image: selectedFile,
      type: selectedOfferFor?.toLowerCase(),
    );
    await apiService
        .postFormData(AppUrl.addUpdateBannerUrl, addBannerQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          isBannerAddLoading = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isBannerAddLoading = false;
          update();
        });
  }

  Future<void> deleteBannerApi(int? id) async {
    isBannerDeleteLoading = true;
    selectedId = id;
    update();
    DeleteBannerQuery deleteBannerQuery = DeleteBannerQuery(bannerId: id);
    await apiService
        .postFormData(AppUrl.deleteBannerUrl, deleteBannerQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            bannerModelList.removeWhere((e) => e.id == id);
            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          isBannerDeleteLoading = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isBannerDeleteLoading = false;
          update();
        });
  }

  Future<void> getBannerApi() async {
    isBannerLoading = true;
    update();
    await apiService
        .get(AppUrl.getBannerUrl)
        .then((response) {
          bannerModelList.clear();
          if (response["success"] == true) {
            for (final data in response['data']) {
              bannerModelList.add(BannerModel.fromJson(data));
            }
          }
          isBannerLoading = false;
          update();
        })
        .catchError((value) {
          isBannerLoading = false;
          update();
        });
  }
}
