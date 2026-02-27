import 'package:flutter/material.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';

class DealerProfileView extends StatelessWidget {
  const DealerProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              color: Color(0xFF0067B1),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    child: AppText(
                      text: "MG",
                      color: Color(0xFF0067B1),
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "User Name",
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      AppText(
                        text: "Guest",
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "Dashboard",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    SizedBox(height: 15),
                    Divider(),
                    SizedBox(height: 15),
                    AppText(
                      text: "Brochure",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    SizedBox(height: 15),
                    Divider(),
                    SizedBox(height: 15),
                    AppText(
                      text: "Video",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    SizedBox(height: 15),
                    Divider(),
                    SizedBox(height: 15),
                    AppText(
                      text: "Reel",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    SizedBox(height: 15),
                    Divider(),
                    SizedBox(height: 15),
                    AppText(
                      text: "Leaflet",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    SizedBox(height: 15),
                    Divider(),
                    SizedBox(height: 15),
                    AppText(
                      text: "Profile",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    SizedBox(height: 15),
                    Divider(),
                    Spacer(),
                    AppButton(text: "Logout", color: Color(0xFF8EBF1F)),
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
