import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:purosis/consts/app_url.dart';
import 'package:purosis/feature/auth/model/query/otp_query.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/utils/api_service.dart';
import 'package:purosis/utils/app_toast.dart';

class AuthController extends GetxController{

  TextEditingController mobileNumberTEC=TextEditingController();
  GlobalKey<FormState> mobileNumberValidationKey=GlobalKey<FormState>();
  bool sendOTPLoading=false;

  sendOTPApi()async{
    sendOTPLoading=true;
    update();
    await ApiService().postFormData(AppUrl.senOTPUrl,OtpQuery(phoneNo: mobileNumberTEC.text).toFormData()).then((response) {
      if(response["success"]==true){
        AppToast.success(response["message"]);
        Get.offAllNamed(AppRoutes.otpScreen);
      }
    },);
  }
}