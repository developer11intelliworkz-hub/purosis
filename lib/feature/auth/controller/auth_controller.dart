import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/consts/app_url.dart';
import 'package:purosis/consts/storage_keys.dart';
import 'package:purosis/feature/auth/model/User_model.dart';
import 'package:purosis/feature/auth/model/query/otp_query.dart';
import 'package:purosis/feature/auth/model/query/verify_otp_query.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/utils/api_service.dart';
import 'package:purosis/utils/app_toast.dart';

import '../../../utils/storage_service.dart';

class AuthController extends GetxController {
  final ApiService apiService = ApiService();
  TextEditingController mobileNumberTEC = TextEditingController();
  GlobalKey<FormState> mobileNumberValidationKey = GlobalKey<FormState>();
  bool sendOTPLoading = false;
  bool verifyOTPLoading = false;
  int posterCurrentIndex = 0;
  String? selectYourCategory;

  sendOTPApi() async {
    sendOTPLoading = true;
    update();
    await apiService
        .postFormData(
          selectYourCategory == "admin"
              ? AppUrl.sendOTPUrl
              : AppUrl.sendUserOTPUrl,
          OtpQuery(
            phoneNo: mobileNumberTEC.text,
            userType: selectYourCategory,
          ).toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            AppToast.success(response["message"]);
            Get.offAllNamed(
              AppRoutes.otpScreen,
              arguments: mobileNumberTEC.text,
            );
            sendOTPLoading = false;
            update();
          }
        })
        .catchError((value) {
          sendOTPLoading = false;
          update();
        });
  }

  verifyOTPApi(String mobileNumber, String otp) async {
    verifyOTPLoading = true;
    update();
    await apiService
        .postFormData(
          selectYourCategory == "admin"
              ? AppUrl.verifyOTPUrl
              : AppUrl.verifyUserOTPUrl,
          VerifyOtpQuery(
            phoneNo: mobileNumber,
            otp: otp,
            userType: selectYourCategory,
          ).toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            AppToast.success(response["message"]);
            UserModel userModel = UserModel.fromJson(response["data"]);
            final storage = Get.find<StorageService>();
            storage.saveToken(userModel.token ?? "");
            storage.write(StorageKeys.userData, userModel.toJson());
            if (selectYourCategory == "admin") {
              Get.offAllNamed(AppRoutes.adminDashboard);
            } else if (selectYourCategory == "distributor") {
              Get.offAllNamed(AppRoutes.distributorDashboard);
            } else {
              Get.offAllNamed(AppRoutes.dealerDashboard);
            }
          } else {
            AppToast.error(message: response["message"]);
          }
          verifyOTPLoading = false;
          update();
        })
        .catchError((value) {
          verifyOTPLoading = false;
          update();
        });
  }
}
