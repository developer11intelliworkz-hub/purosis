import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/consts/storage_keys.dart';
import 'package:purosis/feature/auth/model/user_model.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../../../../utils/app_toast.dart';
import '../../../../utils/storage_service.dart';
import '../model/added_user_model.dart';

class AdminProfileController extends GetxController {
  final storage = Get.find<StorageService>();
  ApiService apiService = ApiService();
  UserModel? userModel;
  TextEditingController adminNameTEC = TextEditingController();
  TextEditingController mobileNumberTEC = TextEditingController();
  TextEditingController emailAddressTEC = TextEditingController();
  GlobalKey<FormState> validationKey = GlobalKey();
  bool isUpdateProfileLoading = false;
  bool isUserLoading = false;
  List<AddedUserModel> addUserModelList = [];

  fetchProfileData() {
    userModel = UserModel.fromJson(storage.read(StorageKeys.userData));
    adminNameTEC.text = userModel?.name ?? "";
    mobileNumberTEC.text = userModel?.phoneNo ?? "";
    emailAddressTEC.text = userModel?.email ?? "";
  }

  logout() async {
    await storage.remove(StorageKeys.userData);
    await storage.clearAuth();
    Get.offAllNamed(AppRoutes.login);
  }

  getUserStatus(value) {
    if (value == 1) {
      return "Active";
    } else {
      return "Deactivate";
    }
  }

  Future<void> updateProfileApi() async {
    isUpdateProfileLoading = true;
    update();
    await apiService
        .get(AppUrl.verifyOTPUrl)
        .then((response) {
          if (response["success"] == true) {
            AppToast.success(response["message"]);
            UserModel userModel = UserModel.fromJson(response["data"]);
            final storage = Get.find<StorageService>();
            storage.write(StorageKeys.userData, userModel.toJson());
            isUpdateProfileLoading = false;
            update();
          }
        })
        .catchError((value) {
          isUpdateProfileLoading = false;
          update();
        });
  }

  Future<void> getUserApi() async {
    isUserLoading = true;
    // update();
    await apiService
        .get(AppUrl.getUserUrl)
        .then((response) {
          if (response["success"] == true) {
            addUserModelList.clear();
            for (final data in response["data"]) {
              addUserModelList.add(AddedUserModel.fromJson(data));
            }
            isUserLoading = false;
            update();
          }
        })
        .catchError((value) {
          isUserLoading = false;
          update();
        });
  }
}
