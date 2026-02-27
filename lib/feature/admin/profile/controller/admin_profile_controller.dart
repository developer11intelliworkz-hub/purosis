import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/consts/storage_keys.dart';
import 'package:purosis/feature/auth/model/user_model.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../../../../utils/app_toast.dart';
import '../../../../utils/storage_service.dart';

class AdminProfileController extends GetxController {
  final storage = Get.find<StorageService>();
  ApiService apiService = ApiService();
  UserModel? userModel;
  TextEditingController adminNameTEC = TextEditingController();
  TextEditingController mobileNumberTEC = TextEditingController();
  TextEditingController emailAddressTEC = TextEditingController();
  GlobalKey<FormState> validationKey = GlobalKey();
  bool isUpdateProfileLoading = false;

  fetchProfileData() {
    userModel = UserModel.fromJson(storage.read(StorageKeys.userData));
    adminNameTEC.text = userModel?.name ?? "";
    mobileNumberTEC.text = userModel?.phoneNo ?? "";
    emailAddressTEC.text = userModel?.email ?? "";
  }

  updateProfileApi() async {
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
}
