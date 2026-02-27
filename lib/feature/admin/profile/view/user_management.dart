import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_search_field.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';

class UserManagement extends StatelessWidget {
  const UserManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "User Management"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AppSearchField(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFDEF1FF),
                                ),
                                child: AppText(
                                  text: "M",
                                  color: Color(0xFF0067B1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text: "Mumbai Water Solutions",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 3,
                                        bottom: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEFF2D2),
                                      ),
                                      child: AppText(
                                        text: "Admin",
                                        color: Color(0xFF8EBF1F),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(Icons.call),
                                        AppText(text: "+91 12345 67890"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 3,
                                  horizontal: 10,
                                ),
                                child: AppText(
                                  text: "Active",
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.userDetail);
                                  },
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF8EBF1F),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: AppText(
                                      text: "View",
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Color(0xFF8EBF1F),
                                    ),
                                  ),
                                  child: AppText(
                                    text: "Edit",
                                    color: Color(0xFF8EBF1F),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Color(0xFF888888),
                                    ),
                                  ),
                                  child: AppText(
                                    text: "Deactivate",
                                    color: Color(0xFF888888),
                                    fontWeight: FontWeight.w600,
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
