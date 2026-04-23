import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/feature/distributor/dashboard/controller/dashboard_controller.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';

class NotificationScreenDistributor extends StatefulWidget {
  const NotificationScreenDistributor({super.key});

  @override
  State<NotificationScreenDistributor> createState() =>
      _NotificationScreenDistributorState();
}

class _NotificationScreenDistributorState
    extends State<NotificationScreenDistributor> {
  final DashboardController dashboardController = Get.find();

  @override
  void initState() {
    dashboardController.getNotificationApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Notification"),
      body: GetBuilder<DashboardController>(
        init: dashboardController,
        builder: (controller) {
          return controller.isNotificationLoading
              ? CommonWidget.commonLoading()
              : controller.notificationModelList.isEmpty
              ? emptyWidget()
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: SizedBox(
                          height: 100,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text:
                                          (controller
                                                      .notificationModelList[index]
                                                      .title ??
                                                  "")
                                              .toString(),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 5),
                                    AppText(
                                      text:
                                          controller
                                              .notificationModelList[index]
                                              .message ??
                                          "",
                                      maxLines: 2,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              AppText(
                                text: controller.formatSmartDate(
                                  controller
                                          .notificationModelList[index]
                                          .time ??
                                      "",
                                ),
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: controller.notificationModelList.length,
                );
        },
      ),
    );
  }

  Widget emptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFDEF1FF),
            ),
            child: Image.asset(AppImage.notificationIcon, color: Colors.blue),
          ),
          SizedBox(height: 20),
          AppText(
            text: "No notifications yet",
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
          AppText(
            text: "We'll notify you when there's something new",
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
