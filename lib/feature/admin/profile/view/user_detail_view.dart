import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../consts/app_image.dart';
import '../../../../routes/app_routes.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/card_widget.dart';

class UserDetailView extends StatelessWidget {
  const UserDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(
        title: "Mumbai",
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.activityLocation);
            },
            child: Image.asset(AppImage.mapDistance),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CardWidget(
                    icon: AppImage.cartIcon,
                    count: '3',
                    bottomText: "Total Orders",
                  ),
                ),
                Expanded(
                  child: CardWidget(
                    icon: AppImage.imageIcon,
                    count: '3',
                    bottomText: "Assets Downloaded",
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CardWidget(
                    icon: AppImage.cartIcon,
                    count: '2 Days Ago',
                    bottomText: "Last Active",
                  ),
                ),
                Expanded(
                  child: CardWidget(
                    icon: AppImage.imageIcon,
                    count: 'Map Tracker',
                    bottomText: "View Activity Map",
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Card(
              color: Colors.white,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFDEF1FF),
                          ),
                          child: AppText(
                            text: "s",
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "Mumbai Water Solutions",
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                            SizedBox(height: 3),
                            Container(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 3,
                                bottom: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFE8F2D2),
                              ),
                              child: AppText(
                                text: "Distributor",
                                color: Color(0xFF8EBF1F),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(Icons.call_outlined, color: Colors.grey),
                        SizedBox(width: 5),
                        AppText(text: "+91 12345 67890"),
                        Spacer(),
                        Image.asset(AppImage.whatsAppIcon),
                        SizedBox(width: 5),
                        AppText(text: "+91 12345 67890"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(AppImage.mailIcon, color: Colors.grey),
                        SizedBox(width: 5),
                        AppText(text: "dealer@mumbaiwater.com"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    AppText(text: "GST Number:"),
                    SizedBox(height: 5),
                    AppText(
                      text: "27AABCU9603R1ZV",
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 10),
                    AppText(text: "Area:"),
                    SizedBox(height: 5),
                    AppText(
                      text: "Mumbai Central",
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 10),
                    AppText(text: "Billing Address:"),
                    SizedBox(height: 5),
                    AppText(
                      text: "123 Market Street, Mumbai, Maharashtra 400001",
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 10),
                    AppText(text: "Shipping Address:"),
                    SizedBox(height: 5),
                    AppText(
                      text: "123 Market Street, Mumbai, Maharashtra 400001",
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
