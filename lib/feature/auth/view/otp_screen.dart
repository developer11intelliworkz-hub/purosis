import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/auth/controller/auth_controller.dart';
import 'package:purosis/widget/app_text.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String numberData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder(
        init: AuthController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Verify Details",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 20),
                AppText(text: "OTP sent to your mobile number"),
                AppText(text: numberData, fontWeight: FontWeight.w600),
                SizedBox(height: 20),
                OtpTextField(
                  numberOfFields: 4,
                  borderColor: Color(0xFF512DA8),
                  showFieldAsBox: true,
                  fieldWidth: 60,
                  fieldHeight: 80,
                  alignment: Alignment.centerLeft,
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {
                    controller.verifyOTPApi(numberData, verificationCode);
                  }, // end onSubmit
                ),
                SizedBox(height: 40),
                if (controller.verifyOTPLoading)
                  Align(
                    alignment: Alignment.topCenter,
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
