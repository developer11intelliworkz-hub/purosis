import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/dealer/profile/model/query/update_profile_query.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../../../../consts/storage_keys.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_toast.dart';
import '../../../../utils/storage_service.dart';
import '../../../auth/model/user_model.dart';

class ProfileController extends GetxController {
  final storage = Get.find<StorageService>();
  UserModel? userModel;
  ApiService apiService = ApiService();
  bool isProfileLoading = false;
  GlobalKey<FormState> validationKey = GlobalKey<FormState>();
  File? selectedFile;

  TextEditingController nameTEC = TextEditingController();
  TextEditingController gstNumberTEC = TextEditingController();
  TextEditingController phoneNumberTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();

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

  fetchProfileData() {
    userModel = UserModel.fromJson(storage.read(StorageKeys.userData));
  }

  setEditProfileData() {
    userModel = UserModel.fromJson(storage.read(StorageKeys.userData));
    nameTEC.text = userModel?.name ?? "";
    gstNumberTEC.text = userModel?.gstNumber ?? "";
    phoneNumberTEC.text = userModel?.phoneNo ?? "";
    emailTEC.text = userModel?.email ?? "";
  }

  Future<void> editProfileApi() async {
    isProfileLoading = true;
    update();
    UpdateProfileQuery updateProfileQuery = UpdateProfileQuery(
      name: nameTEC.text,
      email: emailTEC.text,
      gstNumber: gstNumberTEC.text,
      phoneNo: phoneNumberTEC.text,
      logo: selectedFile,
    );
    await apiService
        .postFormData(AppUrl.updateProfileUrl, updateProfileQuery.toFormData())
        .then((response) async {
          if (response["success"] == true) {
            final oldData = storage.read(StorageKeys.userData) ?? {};
            final Map<String, dynamic> mergedData = {
              ...oldData,
              ...response["data"],
            };
            final UserModel userModel = UserModel.fromJson(mergedData);
            await storage.write(StorageKeys.userData, userModel.toJson());
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          isProfileLoading = false;
          update();
        })
        .catchError((value) {
          isProfileLoading = false;
          update();
        });
  }

  logout() async {
    await storage.remove(StorageKeys.userData);
    await storage.clearAuth();
    Get.offAllNamed(AppRoutes.login);
  }
}
