import 'package:flutter/material.dart';
import 'package:purosis/widget/app_text.dart';

class ReviewView extends StatelessWidget {
  const ReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: AppText(
                                          text: "PuroAqua Water Purifiers",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      AppText(text: "25.50 Kg"),
                                    ],
                                  ),
                                  AppText(text: "Color: Matt Black"),
                                  AppText(text: "3 box(es) 60 units"),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: 3,
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          AppText(
                            text: "Total",
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0067B1),
                          ),
                          Spacer(),
                          AppText(text: "53.50 kg / 0.2809 m"),
                        ],
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "Billing Address",
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0067B1),
                          ),
                          Divider(),
                          SizedBox(height: 5),
                          AppText(text: "Silicon India Private Limited"),
                          AppText(text: "Ramesh Patel"),
                          AppText(text: "GST: 24AAACH7409R2Z6"),
                          AppText(text: "Maharashtra"),
                          AppText(text: "+91 1234567890"),
                          AppText(text: "info@sillicon.com"),
                          AppText(
                            text: "Shipping Address: Same as Billing Address",
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
