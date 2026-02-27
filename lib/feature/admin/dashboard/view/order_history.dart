import 'package:flutter/material.dart';
import 'package:purosis/widget/app_search_field.dart';

import '../../../../consts/app_image.dart';
import '../../../../widget/app_text.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: AppSearchField()),
                SizedBox(width: 5),
                Image.asset(AppImage.shortArrowIcon),
                SizedBox(width: 5),
                AppText(text: "Sort by"),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AppText(
                                text: "#ORD-2026-001",
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF2EBD2),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: AppText(text: "Pending Approval"),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(AppImage.manIcon),
                              SizedBox(width: 5),
                              AppText(
                                text: "Distributor : Mumbai Water Solutions",
                              ),
                            ],
                          ),
                          SizedBox(height: 3),
                          Row(
                            children: [
                              Image.asset(AppImage.calenderIcon),
                              SizedBox(width: 5),
                              AppText(text: "Jan 05, 2026 • 01:48 PM"),
                            ],
                          ),
                          SizedBox(height: 3),
                          Row(
                            children: [
                              Image.asset(AppImage.shippingBoxIcon),
                              SizedBox(width: 5),
                              AppText(text: "8 Products"),
                            ],
                          ),
                          SizedBox(height: 3),
                          Row(
                            children: [
                              Image.asset(AppImage.truckIcon),
                              SizedBox(width: 5),
                              AppText(text: "Blue Dart Express"),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              AppText(text: "Total Weight: "),
                              AppText(
                                text: "73.00 kg",
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                              AppText(text: "0.800 m³"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Color(0xFF8EBF1F),
                                    ),
                                  ),
                                  child: AppText(
                                    text: "View Details",
                                    color: Color(0xFF8EBF1F),
                                  ),
                                ),
                              ),
                              SizedBox(width: 3),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xFF8EBF1F),
                                  ),
                                  child: AppText(
                                    text: "Approve",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 3),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Color(0xFFBF1F1F),
                                    ),
                                  ),
                                  child: AppText(
                                    text: "Decline",
                                    color: Color(0xFFBF1F1F),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
