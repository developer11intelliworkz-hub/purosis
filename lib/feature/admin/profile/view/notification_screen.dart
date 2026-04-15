import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:purosis/feature/admin/profile/controller/notification_controller.dart';
import 'package:purosis/feature/admin/profile/model/admin_notification_model.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (controller) {
        return Scaffold(
          appBar: _buildAppBar(controller),
          body: controller.isNotificationLoading
              ? CommonWidget.commonLoading()
              : controller.notificationFilterList.isEmpty
              ? CommonWidget.commonEmpty()
              : RefreshIndicator(
                  onRefresh: () async => await controller.getNotificationApi(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      itemCount: controller.notificationFilterList.length,
                      itemBuilder: (context, index) {
                        final item = controller.notificationFilterList[index];
                        return _NotificationCard(item: item);
                      },
                    ),
                  ),
                ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(NotificationController controller) {
    return AppBar(
      elevation: 0.5,
      centerTitle: false,
      title: Text(
        "Notifications",
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF1A1A2E),
        ),
      ),
      actions: [
        // Unread badge count
        GetBuilder<NotificationController>(
          builder: (c) {
            final unreadCount = c.notificationList
                .where((e) => e.isRead == false)
                .length;
            return unreadCount > 0
                ? Padding(
                    padding: EdgeInsets.only(right: 3.w),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 0.4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE53935),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "$unreadCount Unread",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationDatum item;

  const _NotificationCard({required this.item});

  String _formatTime(String? isoTime) {
    if (isoTime == null) return "";
    try {
      final dt = DateTime.parse(isoTime).toLocal();
      return DateFormat("dd MMM yyyy, hh:mm a").format(dt);
    } catch (_) {
      return isoTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isUnread = item.isRead == false;

    return Container(
      margin: EdgeInsets.only(bottom: 1.5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row: Avatar + Distributor info + Unread dot
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar circle with initials
                CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0xFF3B82F6).withOpacity(0.12),
                  child: AppText(
                    text: _getInitials(item.distributor?.name),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Distributor name
                      AppText(
                        text: item.distributor?.name ?? "Unknown",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A2E),
                      ),
                      SizedBox(height: 0.3.h),
                      // Company name
                      Row(
                        children: [
                          Icon(
                            Icons.business_rounded,
                            size: 13.sp,
                            color: const Color(0xFF6B7280),
                          ),
                          SizedBox(width: 1.w),
                          AppText(
                            text: item.distributor?.companyName ?? "",
                            fontSize: 12,
                            color: const Color(0xFF6B7280),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.3.h),
                      // Email
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 13,
                            color: const Color(0xFF6B7280),
                          ),
                          SizedBox(width: 1.w),
                          Flexible(
                            child: AppText(
                              text: item.distributor?.email ?? "",
                              fontSize: 12,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Unread indicator dot
                if (isUnread)
                  Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.only(top: 0.5.h),
                    decoration: const BoxDecoration(
                      color: Color(0xFF3B82F6),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),

            SizedBox(height: 1.2.h),
            Divider(color: const Color(0xFFE5E7EB), height: 0),
            SizedBox(height: 1.2.h),

            /// Order ID chip
            if (item.orderId != null)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 2.5.w,
                  vertical: 0.4.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: AppText(
                  text: "Order ID: #${item.orderId}",
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF059669),
                ),
              ),

            SizedBox(height: 1.h),

            /// Title
            AppText(
              text: item.title ?? "",
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A2E),
            ),

            SizedBox(height: 0.5.h),

            /// Message
            AppText(
              text: item.message ?? "",
              fontSize: 11,
              color: const Color(0xFF4B5563),
            ),

            SizedBox(height: 1.2.h),

            /// Time row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 13,
                  color: const Color(0xFF9CA3AF),
                ),
                SizedBox(width: 1.w),
                AppText(
                  text: _formatTime(item.time),
                  fontSize: 12,
                  color: const Color(0xFF9CA3AF),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return "?";
    final parts = name.trim().split(" ");
    if (parts.length >= 2) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }
}
