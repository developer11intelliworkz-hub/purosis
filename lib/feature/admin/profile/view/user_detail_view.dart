import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../consts/app_image.dart';
import '../../../../routes/app_routes.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/card_widget.dart';
import '../model/added_user_model.dart';

class UserDetailView extends StatefulWidget {
  const UserDetailView({super.key});

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> {
  final AddedUserModel data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(
        title: data.area,
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.activityLocation, arguments: data);
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
                    count: (data.totalOrders ?? 0).toString(),
                    bottomText: "Total Orders",
                  ),
                ),
                Expanded(
                  child: CardWidget(
                    icon: AppImage.imageIcon,
                    count: (data.assetsDownloaded ?? 0).toString(),
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
                    count: '${data.lastActive ?? 0} Days Ago',
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
                            text: data.name?.trim()[0] ?? "",
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
                              text: data.companyName ?? "",
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
                        AppText(text: data.phoneNo ?? ""),
                        Spacer(),
                        Icon(Icons.call_outlined, color: Colors.grey),
                        SizedBox(width: 5),
                        AppText(text: data.alternateMobileNo ?? ""),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(AppImage.mailIcon, color: Colors.grey),
                        SizedBox(width: 5),
                        AppText(text: data.email ?? ""),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    AppText(text: "GST Number:"),
                    SizedBox(height: 5),
                    AppText(
                      text: data.gstNumber ?? "",
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 10),
                    AppText(text: "Area:"),
                    SizedBox(height: 5),
                    AppText(text: data.area ?? "", fontWeight: FontWeight.w700),
                    SizedBox(height: 10),
                    if (data.billingAddress != null) ...[
                      AppText(text: "Billing Address:"),
                      SizedBox(height: 5),
                      AppText(
                        text: data.billingAddress ?? "",
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                    SizedBox(height: 10),
                    if (data.shippingAddressLine != null) ...[
                      AppText(text: "Shipping Address:"),
                      SizedBox(height: 5),
                      AppText(
                        text: data.shippingAddressLine ?? "",
                        fontWeight: FontWeight.w700,
                      ),
                    ],
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
