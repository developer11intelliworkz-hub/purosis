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
      appBar: CommonWidget.appAppBar(title: "Support Messages"),
      body: GetBuilder<AdminProfileController>(
        init: adminProfileController,
        builder: (controller) {
          if (controller.isSupportMessageLoading) {
            return CommonWidget.commonLoading();
          }
          if (controller.supportMessageModelList.isEmpty) {
            return CommonWidget.commonEmpty();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.supportMessageModelList.length,
            itemBuilder: (context, index) {
              final item = controller.supportMessageModelList[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Header ──────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF8EBF1F).withOpacity(0.1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.support_agent,
                            size: 16,
                            color: Color(0xFF8EBF1F),
                          ),
                          SizedBox(width: 6),
                          AppText(
                            text: "Support Request #${index + 1}",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8EBF1F),
                          ),
                        ],
                      ),
                    ),

                    // ── Body ────────────────────────
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Subject
                          _LabelValue(
                            label: "Subject",
                            value: item.subject ?? "N/A",
                            icon: Icons.title,
                            iconColor: Colors.blue,
                            bold: true,
                          ),

                          SizedBox(height: 6),

                          // Message Box
                          _LabelValue(
                            label: "Message",
                            value: item.message ?? "N/A",
                            icon: Icons.message_outlined,
                            iconColor: Colors.purple,
                            isMessageBox: true,
                          ),

                          SizedBox(height: 8),

                          // Distributor + Product in a row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _LabelValue(
                                  label: "Company",
                                  value: item.distributor?.companyName ?? "N/A",
                                  icon: Icons.business,
                                  iconColor: Colors.orange,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: _LabelValue(
                                  label: "Product",
                                  value: item.product?.productName ?? "N/A",
                                  icon: Icons.shopping_bag_outlined,
                                  iconColor: Color(0xFF8EBF1F),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 6),

                          // Email
                          _LabelValue(
                            label: "Email",
                            value: item.distributor?.email ?? "N/A",
                            icon: Icons.email_outlined,
                            iconColor: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ── Reusable Label + Value ────────────────────────────────────
class _LabelValue extends StatelessWidget {
  const _LabelValue({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    this.bold = false,
    this.isMessageBox = false,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final bool bold;
  final bool isMessageBox;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: iconColor),
        SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 2),
              isMessageBox
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    )
                  : Text(
                      value,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
