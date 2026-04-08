import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/profile/controller/admin_profile_controller.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/app_text.dart';

class SupportMessageView extends StatefulWidget {
  const SupportMessageView({super.key});

  @override
  State<SupportMessageView> createState() => _SupportMessageViewState();
}

class _SupportMessageViewState extends State<SupportMessageView> {
  final AdminProfileController adminProfileController = Get.find();

  @override
  void initState() {
    adminProfileController.getSupportMessageApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Support Message"),
      body: GetBuilder<AdminProfileController>(
        init: adminProfileController,
        builder: (controller) {
          return controller.isSupportMessageLoading
              ? CommonWidget.commonLoading()
              : controller.supportMessageModelList.isEmpty
              ? CommonWidget.commonEmpty()
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: controller.supportMessageModelList.length,
                  itemBuilder: (context, index) {
                    final item = controller.supportMessageModelList[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Card(
                        elevation: 3,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.subject,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: AppText(
                                      text: item.subject ?? "",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              AppText(
                                text: item.message ?? "",
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),

                              const Divider(height: 20),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.business,
                                    size: 18,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: AppText(
                                      text:
                                          item.distributor?.companyName ??
                                          "N/A",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 6),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.email,
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: AppText(
                                      text: item.distributor?.email ?? "N/A",
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.shopping_bag,
                                    size: 18,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: AppText(
                                      text:
                                          item.product?.productName ??
                                          "No Product",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
