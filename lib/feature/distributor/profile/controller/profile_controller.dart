import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/distributor/profile/model/order_history_model.dart';
import 'package:purosis/feature/distributor/profile/model/query/update_profile_query.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../../../../consts/storage_keys.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_toast.dart';
import '../../../../utils/storage_service.dart';
import '../../../auth/model/user_model.dart';

class ProfileController extends GetxController {
  final storage = Get.find<StorageService>();
  final ApiService apiService = ApiService();
  File? selectedFile;
  TextEditingController companyNameTEC = TextEditingController();
  TextEditingController contactPersonNameTEC = TextEditingController();
  TextEditingController gstNumberTEC = TextEditingController();
  TextEditingController areaTEC = TextEditingController();
  TextEditingController mobileNumberTEC = TextEditingController();
  TextEditingController alternateMobileNumberTEC = TextEditingController();
  TextEditingController landlineNumberTEC = TextEditingController();
  TextEditingController emailAddressTEC = TextEditingController();

  bool isSaveProfileLoading = false;
  bool isOrderHistoryLoading = false;
  bool isLatest = true;

  OrderHistoryModel? orderHistoryModel;

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

  getProfileData() {
    UserModel userData = UserModel.fromJson(storage.read(StorageKeys.userData));
    companyNameTEC.text = userData.name ?? "";
    contactPersonNameTEC.text = userData.name ?? "";
    gstNumberTEC.text = userData.gstNumber ?? "";
    areaTEC.text = userData.area ?? "";
    mobileNumberTEC.text = userData.phoneNo ?? "";
    alternateMobileNumberTEC.text = userData.alternateMobileNo ?? "";
    landlineNumberTEC.text = userData.landlineNo ?? "";
    emailAddressTEC.text = userData.email ?? "";
  }

  clearData() {
    selectedFile = null;
  }

  Future<void> updateProfileApi() async {
    isSaveProfileLoading = true;
    update();
    UpdateProfileQuery updateProfileQuery = UpdateProfileQuery(
      companyName: companyNameTEC.text,
      contactPersonName: contactPersonNameTEC.text,
      gstNumber: gstNumberTEC.text,
      area: areaTEC.text,
      mobileNo: mobileNumberTEC.text,
      alternateMobileNo: alternateMobileNumberTEC.text,
      landlineNo: landlineNumberTEC.text,
      email: emailAddressTEC.text,
      logo: selectedFile,
    );

    await apiService
        .postFormData(
          AppUrl.updateProfileDistributorUrl,
          updateProfileQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            UserModel userModel = UserModel.fromJson(response["data"]);
            clearData();
            storage.write(StorageKeys.userData, userModel.toJson());
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          isSaveProfileLoading = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isSaveProfileLoading = false;
          update();
        });
  }

  Future<void> getOrderHistoryApi() async {
    isOrderHistoryLoading = true;
    await apiService
        .get(AppUrl.getOrderHistoryUrl)
        .then((response) {
          if (response["success"] == true) {
            orderHistoryModel = OrderHistoryModel.fromJson(response['data']);
          }
          isOrderHistoryLoading = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isOrderHistoryLoading = false;
          update();
        });
  }

  logout() async {
    await storage.remove(StorageKeys.userData);
    await storage.clearAuth();
    Get.offAllNamed(AppRoutes.login);
  }
}
