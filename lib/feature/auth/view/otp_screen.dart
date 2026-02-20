import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:purosis/widget/app_text.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        AppText(text: "Verify Details",fontSize: 18,),
        SizedBox(height: 20,),
        AppText(text: "OTP sent to your mobile number"),
        AppText(text: "1234567890",fontWeight: FontWeight.w600,),
          SizedBox(height: 20,),
        OtpTextField(
          numberOfFields: 4,
          borderColor: Color(0xFF512DA8),
          showFieldAsBox: true,
          alignment: Alignment.centerLeft,
          onCodeChanged: (String code) {
          },
          onSubmit: (String verificationCode){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text("Verification Code"),
                    content: Text('Code entered is $verificationCode'),
                  );
                }
            );
          }, // end onSubmit
        ),
      ],),
    ),);
  }
}
