import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/auth/controller/auth_controller.dart';
import 'package:purosis/utils/common_validation.dart';
import 'package:purosis/widget/app_drop_down.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/app_text_field.dart';

import '../../../widget/app_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder(
      init: AuthController(),
      builder: (controller) {
        return Column(children: [
          Expanded(flex:2,child: Column(
            children: [
              Expanded(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: double.maxFinite,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    viewportFraction: 1,
                  ),
                  items: [Container(color: Colors.red,),Container(color: Colors.green,)],
                ),
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                2,
                    (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: //_currentIndex == index
                      true ? 10 : 8,
                  height:// _currentIndex == index
                     true ? 10 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: true//_currentIndex == index
                        ? Colors.grey
                        : Colors.grey,
                  ),
                ),
              ),)
            ],
          )),Expanded(flex:3,child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Column(children: [
                SizedBox(height: 10,),
                AppText(text: "Welcome to purosia portal"),
                SizedBox(height: 15,),
                AppText(text: "Your Complete",fontSize: 20,),
                AppText(text: "Business Partner Portal",fontSize: 25,color: Color(0xFF0067B1),fontWeight: FontWeight.w700,),
                SizedBox(height: 5,),
                AppText(text: "Access marketing maters place orders and manage your business with purosis",align: TextAlign.center,),
                SizedBox(height: 10,),
                Form(
                  key: controller.mobileNumberValidationKey,
                    child: AppTextField(labelText: "Mobile Number",controller: controller.mobileNumberTEC,validator: CommonValidation.fieldValidation,)),
                SizedBox(height: 10,),
                AppText(text: "A 6-digit OTP will be sent to your registered mobile number for verification",)
              ,SizedBox(height: 10,)
                ,AppButton(text: 'Login Using OTP', isLoading: controller.sendOTPLoading, onPressed: () {
                  if(controller.mobileNumberValidationKey.currentState?.validate() ?? false){
                    controller.sendOTPApi();
                  }
                },color: Color(0xFF749B18),)
              ],),
            ),
          ))
        ],);
      }
    ),);
  }
}
