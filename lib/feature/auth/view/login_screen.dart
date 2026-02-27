import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/feature/auth/controller/auth_controller.dart';
import 'package:purosis/utils/common_validation.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/app_text_field.dart';

import '../../../widget/app_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: AuthController(),
        builder: (controller) {
          return Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: double.maxFinite,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(
                          milliseconds: 800,
                        ),
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          controller.posterCurrentIndex = index;
                          controller.update();
                        },
                      ),
                      items: sliderImageList(),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: controller.posterCurrentIndex == index ? 10 : 8,
                        height: controller.posterCurrentIndex == index ? 10 : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.posterCurrentIndex == index
                              ? Colors.grey
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        AppText(text: "Welcome to purosia portal"),
                        SizedBox(height: 15),
                        AppText(text: "Your Complete", fontSize: 20),
                        AppText(
                          text: "Business Partner Portal",
                          fontSize: 25,
                          color: Color(0xFF0067B1),
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: 5),
                        AppText(
                          text:
                              "Access marketing maters place orders and manage your business with purosis",
                          align: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Form(
                          key: controller.mobileNumberValidationKey,
                          child: AppTextField(
                            labelText: "Mobile Number",
                            controller: controller.mobileNumberTEC,
                            validator: CommonValidation.fieldValidation,
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        AppText(
                          text:
                              "A 6-digit OTP will be sent to your registered mobile number for verification",
                        ),
                        SizedBox(height: 10),
                        AppButton(
                          text: 'Login Using OTP',
                          isLoading: controller.sendOTPLoading,
                          onPressed: () {
                            if (controller
                                    .mobileNumberValidationKey
                                    .currentState
                                    ?.validate() ??
                                false) {
                              controller.sendOTPApi();
                            }
                          },
                          color: Color(0xFF749B18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> sliderImageList() {
    return [
      Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Color(0xFF0067B1),
          image: DecorationImage(
            image: AssetImage(AppImage.loginLayer1),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 30),
            Image.asset(AppImage.purosisLogoWhite),
            Spacer(),
            AppText(
              text: "Marketing Library",
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            AppText(
              text:
                  "Access social media posts, videos, \nbrochures and more for your promotions.",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              align: TextAlign.center,
              color: Colors.white,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
      Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Color(0xFF0067B1),
          image: DecorationImage(
            image: AssetImage(AppImage.loginLayer2),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 30),
            Image.asset(AppImage.purosisLogoWhite),
            Spacer(),
            AppText(
              text: "Easy Ordering",
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            AppText(
              text:
                  "Place bulk orders with complete product \nspecifications and tracking.",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              align: TextAlign.center,
              color: Colors.white,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
      Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Color(0xFF0067B1),
          image: DecorationImage(
            image: AssetImage(AppImage.loginLayer3),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 30),
            Image.asset(AppImage.purosisLogoWhite),
            Spacer(),
            AppText(
              text: "Promotional Items",
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            AppText(
              text:
                  "Track and manage promotional materials \nsent to your location.",
              fontSize: 12,
              fontWeight: FontWeight.w400,
              align: TextAlign.center,
              color: Colors.white,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    ];
  }
}
