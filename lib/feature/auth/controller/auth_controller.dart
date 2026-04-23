import 'dart:io';

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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:purosis/utils/common_permission.dart';
import 'package:purosis/utils/notification_handler.dart';

import '../../../utils/storage_service.dart';

class AuthController extends GetxController {
  final ApiService apiService = ApiService();
  TextEditingController mobileNumberTEC = TextEditingController();
  GlobalKey<FormState> mobileNumberValidationKey = GlobalKey<FormState>();
  bool sendOTPLoading = false;
  bool verifyOTPLoading = false;
  int posterCurrentIndex = 0;
  String? selectYourCategory;
  Position? position;

  sendOTPApi() async {
    sendOTPLoading = true;
    update();
    final permissionCheck = await CommonPermission.checkLocationPermission();
    if (permissionCheck == true) {
      position = await CommonPermission.getCurrentLocation();
    } else {
      await CommonPermission.openAppSetting();
    }
    if (position != null) {
      await apiService
          .postFormData(
            selectYourCategory?.toLowerCase() == "admin"
                ? AppUrl.sendOTPUrl
                : AppUrl.sendUserOTPUrl,
            OtpQuery(
              phoneNo: mobileNumberTEC.text,
              userType: selectYourCategory?.toLowerCase(),
            ).toFormData(),
          )
          .then((response) {
            if (response["success"] == true) {
              AppToast.success(response["message"]);
              Get.toNamed(AppRoutes.otpScreen, arguments: mobileNumberTEC.text);
            } else {
              AppToast.error(message: response["message"]);
            }
            sendOTPLoading = false;
            update();
          })
          .catchError((value) {
            sendOTPLoading = false;
            update();
          });
    } else {
      sendOTPLoading = false;
      update();
      AppToast.error(message: "Location is need for login");
    }
  }

  verifyOTPApi(String mobileNumber, String otp) async {
    verifyOTPLoading = true;
    update();
    String? token = await NotificationHandler.getFCMToken();
    await apiService
        .postFormData(
          selectYourCategory?.toLowerCase() == "admin"
              ? AppUrl.verifyOTPUrl
              : AppUrl.verifyUserOTPUrl,
          VerifyOtpQuery(
            phoneNo: mobileNumber,
            otp: otp,
            userType: selectYourCategory?.toLowerCase(),
            latitude: position?.latitude,
            longitude: position?.longitude,
            deviceToken: token,
            deviceName: Platform.isIOS ? "IOS" : "Android",
          ).toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            AppToast.success(response["message"]);
            UserModel userModel = UserModel.fromJson(response["data"]);
            final storage = Get.find<StorageService>();
            storage.saveToken(userModel.token ?? "");
            storage.write(StorageKeys.userData, userModel.toJson());
            if (selectYourCategory?.toLowerCase() == "admin") {
              Get.offAllNamed(AppRoutes.adminDashboard);
            } else if (selectYourCategory?.toLowerCase() == "distributor") {
              Get.offAllNamed(AppRoutes.distributorDashboard);
            } else if (selectYourCategory?.toLowerCase() == "dealer") {
              Get.offAllNamed(AppRoutes.dealerDashboard);
            } else {
              AppToast.error();
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

  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await CommonPermission.checkLocationPermission();
    await messaging.requestPermission(alert: true, badge: true, sound: true);
  }
}
